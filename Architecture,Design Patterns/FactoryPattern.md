# Factory Pattern

Instance 생성을 Factory Type Method 에 위임하는 방식으로, Instance 생성을 용이하게 해줌.  
<br>
## 패턴 적용하지 않은 경우  

<br>

```swift
import UIKit

final class MyAppLabel: UILabel {
    
    init(textColor: CGColor = UIColor.label.cgColor, backgroundColor: UIColor = .systemBackground) {
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
}


final class MyAppButton: UIButton {

    init(textColor: CGColor, backgroundColor: UIColor = .systemBackground) {
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
}

final class MyAppTextField: UITextField {

    init(textColor: CGColor = UIColor.label.cgColor, backgroundColor: UIColor) {
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
}
```

이 경우, 아래처럼 일일이 설정해줘야 하는 번거로움이 있음. (기억하기도 힘듦)

```swift
let label = MyAppLabel()
let button = MyAppButton(textColor: UIColor.systemPink.cgColor)
let textField = MyAppTextField(backgroundColor: .systemTeal)
```

실제 개발 과정에서는 크기, 여백 등 훨씬 더 많은 Customizing 요소들이 포함되어있을 수 있음.


<br>

### protocol, enum 정의


```swift
import UIKit

enum UIComponent {
    case label, button, textField
}

protocol MyAppUIComponent {

    var component: UIComponent { get }
    var textColor: CGColor { get set }
    var backgroundColor: UIColor { get set }
}
```

## 사용할 UI Components

```swift
final class MyAppLabel: UILabel, MyAppUIComponent {
    
    var component: UIComponent { .label }
    
    init(textColor: CGColor = UIColor.label.cgColor, backgroundColor: UIColor = .systemBackground) {
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
}


final class MyAppButton: UIButton, MyAppUIComponent {

    var component: UIComponent { .button }

    init(textColor: CGColor, backgroundColor: UIColor = .systemBackground) {
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
}

final class MyAppTextField: UITextField, MyAppUIComponent {
    
    var component: UIComponent { .textField }

    init(textColor: CGColor = UIColor.label.cgColor, backgroundColor: UIColor) {
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
}
```

정의한 Custom UI Component 의 생성을 맡을 Factory Type 생성.  
여기에서, properties 의 customize 진행

```swift
struct ComponentFactory {
    
    func make(_ component: UIComponent) -> MyAppUIComponent {
        switch component {
        case .label:
            return MyAppLabel()
        case .button:
            return MyAppButton(textColor: UIColor.systemPink.cgColor)
        case .textField:
            return MyAppTextField(backgroundColor: .systemTeal)
        }
    }
}
```

```swift
let factory = ComponentFactory()

let label = factory.make(.label)
let button = factory.make(.button)
let textField = factory.make(.textField)
```

이제, 정의된 Components 들이 어떤 properties 를 가져야 하는지 외울 필요가 없게됨!


출처  
https://velog.io/@ryan-son/%EB%94%94%EC%9E%90%EC%9D%B8-%ED%8C%A8%ED%84%B4-Factory-pattern-in-Swift