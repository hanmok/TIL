# Handling ChildViewController

## Add to parent

```swift
private func presentPreview(with videoURL: URL) {
        previewVC = VideoPlayerViewController(videoURL: videoURL)
        guard let previewVC = previewVC else {
            return
        }

        addChild(previewVC)
        view.addSubview(previewVC.view)
        previewVC.view.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(view.snp.width)
        }
    }
```

## Remove from parent
```swift
private func removePreview() {
        if self.children.count > 0 {
            let viewcontrollers: [UIViewController] = self.children
            for vc in viewcontrollers {
                vc.willMove(toParent: nil)
                vc.view.removeFromSuperview()
                vc.removeFromParent()
            }
        }
    }
```
