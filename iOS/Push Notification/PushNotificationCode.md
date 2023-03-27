```swift

import UIKit
import RxCocoa

import UserNotifications


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
        // 폰이 닫혀있을 때 Notification 을 통해 누른 경우.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MARK: - Push Notification
        UNUserNotificationCenter.current().delegate = self
        registerForPushNotifications()
        
        if let _ = launchOptions?[.remoteNotification] {
            PushUtil.shared.notiTab.accept(())
        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    // Called when APNs has assigned the device a unique token successfully
    
    
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    
    func applicationWillTerminate(_ application: UIApplication) { }
    
    // original Code
    //    func application(_ application: UIApplication,
    //                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    //        UserDefaults.standard.deviceToken = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
    //    }
    
    
    
    // called by iOS whenever a call to registerForRemoteNotifications succeeds.
    // it takes a received deviceToken and convert it to a string.
    // The device token is the fruit of this process. It's provided by APNs and uniquely identifies this app on this particular device.
    
    // When sending a push notification, the server uses tokens as "addresses" to deliver to the correct devices. In your app, you would now send this token to your server to save and use later on for sending notifications.
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data)}
        let token = tokenParts.joined()
        UserDefaults.standard.deviceToken = token
//        d726d85db3f57daf955b60629d6103ebae6c28522592d524889885361f0d05df
        
        print("Device Token: \(token)")
    }
    
    // called by iOS if registerForRemoteNotifications() fails.
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        debugPrint("Failed to register: \(error)")
    }
    // The app is not yet able to process push notifications while in the foreground.
    
    // running either in the foreground or the background -> the system notifies your app by calling it.
    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable: Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            
            guard let aps = userInfo["aps"] as? [String: AnyObject] else { return }
            
            // silent push notification
            if aps["content-available"] as? Int == 1 {
                
            } else {
                PushUtil.shared.newMessage.accept(())
                PushUtil.shared.badge.accept(())
                completionHandler(.newData)
            }
        }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        PushUtil.shared.newMessage.accept(())
        PushUtil.shared.badge.accept(())
        PushUtil.shared.notiTab.accept(())
        completionHandler()
    }
}

// You must get the user's permission to show notifications.  Then, you can register the device to receive remote notifications. If all goes well, the system will then provide you with a device token, which you can think of as an "address" to this device.


extension AppDelegate {
    
    // 'AppName' would like to send you notifications
    func registerForPushNotifications() {
        // UNUserNotificationCenter handles all notification-related activities in the app, including push notifications.
        UNUserNotificationCenter.current()
        // invoke to request authorization to show notifications. The passed options indicate the types of notifications you want your app to use.
        // The completion handler receives a Bool that indicates whether authorization was successful.
            .requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, _ in
                guard granted else { return }
                // the user can, at any time, go into the Settings app and change their notification permissions.
                // The guard avoids making this call in cases where permission wasn't granted.
                
                // Now that you have permissions, you'll register for remote notifications!
                self?.getNotificationSettings()
                print("Permission granted")
            }
    }
    
    // What if the user declines the permissions?
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current()
            .getNotificationSettings { settings in
                print("Notification settings: \(settings)")
                // verify if the user has granted notification permissions.
                guard settings.authorizationStatus == .authorized else { return }
                DispatchQueue.main.async {
                    // kick off registration with the Apple Push Notification service.
                    // You need to call this on the main thread, or you'll receive a runtime warning.
                    
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
    }
}

// UNAuthorizationOptions:
//    .badge: Display a number on the corner of the app’s icon.
//    .sound: Play a sound.
//    .alert: Display a text notification.
//    .carPlay: Display notifications in CarPlay.
//    .provisional: Post non-interrupting notifications. The user won’t get a request for permission if you use only this option, but your notifications will only show silently in the Notification Center.
//    .providesAppNotificationSettings: Indicate that the app has its own UI for notification settings.
//    .criticalAlert: Ignore the mute switch and Do Not Disturb. You’ll need a special entitlement from Apple to use this option, because it’s meant only for very special use cases.
```