

### Usual Singleton Pattern

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


