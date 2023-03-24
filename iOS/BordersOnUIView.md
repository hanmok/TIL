# UIView, Border on Specific Sides

```swift
import UIKit

extension UIView {
    enum ViewSide {
        case top
        case left
        case bottom
        case right
    }

    func addBorders(to sides: [ViewSide], in color: UIColor, width: CGFloat) {
        sides.forEach { addBorder(to: $0, in: color, width: width) }
    }

    func addBorder(to side: ViewSide, in color: UIColor, width: CGFloat) {
        switch side {
        case .top:
            addTopBorder(in: color, width: width)
        case .left:
            addLeftBorder(in: color, width: width)
        case .bottom:
            addBottomBorder(in: color, width: width)
        case .right:
            addRightBorder(in: color, width: width)
        }
    }

    func addTopBorder(in color: UIColor?, width borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        addSubview(border)
    }

    func addBottomBorder(in color: UIColor?, width borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        addSubview(border)
    }

    func addLeftBorder(in color: UIColor?, width borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }

    func addRightBorder(in color: UIColor?, width borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        addSubview(border)
    }
}
```

사용 예

```swift
private let deleteBtn = UIButton().then {
        $0.setTitle("Delete", for: .normal)
        $0.setTitleColor(.red500, for: .normal)
        $0.backgroundColor = .white
        $0.addBorders(to: [.top, .bottom], in: .lavenderGray100, width: 1)
    }
```

출처: [https://stackoverflow.com/questions/17355280/how-to-add-a-border-just-on-the-top-side-of-a-uiview](https://stackoverflow.com/questions/17355280/how-to-add-a-border-just-on-the-top-side-of-a-uiview)