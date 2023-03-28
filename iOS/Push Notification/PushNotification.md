# Push Notification

Server 또는 Local 에서 사용자에게 푸쉬를 보낼 수 있다.  
대표적인 방법으로는 alert, message, badge 가 있다. 
<br>
<br>

## 해당 과정에서 App, APNs, Push Server 가 정보를 주고받는다.

### App 
### APNs(Apple Push Notification Service)
### Push Server(our server or third party)
<br><br>

정보를 주고받는 순서는 아래와 같다.

1. **App** -> **APNs** / Device Token 요청
2. **APNs** -> **App** / Device Token 전송
3. **App** -> **Server** / Device Toekn 전송
4. **Server** -> **APNs** / DeviceToken, Data 전송
5. **APNs** -> **App** / Data 전송 
<br>
<br>
* DeviceToken: Push 가 전송되는 주소.  
 Push notification 을 보낼 때, server 는 token 을 맞는 기기로의 '주소' 로서 이용한다.  app 에서 server 로 token 을 보내고, Server 에서는 저장 후 notification 을 보낼 때 사용한다. 
 
 
<br><br>

Push Server 에서는 해당 과정을 위한 인증서(Certificate) 또는 Key 가 필요한데, p8, p12, pem 세 확장자로 나뉠 수 있다.

- .p8: 하나의 Key 로서 계정 내 모든 App 에서 사용될 수 있다.   
- .p12: 하나의 Certificate 으로, 각 App 에서 발급되어야 한다.  
- .pem: 주로 PHP 환경에서 사용한다고 하고, 해당 글에서는 다루지 않는다.  

[.p8 발급받기](/iOS/Push%20Notification/GettingP8.md)  
[.p12 발급받기](/iOS/Push%20Notification/GettingP12.md)  

[APNs SSL Certificates](/)


[Push Notification Code]