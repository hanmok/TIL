

### Usual Singleton Pattern

```swift
class Singleton {
    static let shared = Singleton()  // 전역으로 사용
    
    private init() {}    // 다른 곳에서 instance 생성하지 못하도록 private 사용
    
    var id: String?
    var password: String?
}
```

```swift
Singleton.shared.id = "sth"
```


## Declaration

```swift
public final class PushUtil { 
    private init() {}
    static let shared = PushUtil()
    
    public var newMessage = PublishRelay<Void>()
    public var badge = PublishRelay<Void>()
    public var notiTab = BehaviorRelay<Void?>(value: nil)
}
```

## Usage
```swift
PushUtil.shared.notiTab.accept(())

PushUtil.shared.newMessage
    .subscribe(onNext: { [weak self] in 
        self?.view.makeToast("New Message arrived")
    })
    .disposed(by: self.disposeBag)
```

## UserDefaults (built-in singleton)

```swift
import Foundation

extension UserDefaults { 
    enum Key: String { 
        case isDarkMode
    }
}
```



