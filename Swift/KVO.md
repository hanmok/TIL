# KVO (Key-value Observing)



## Overview
Notify <ins>objects</ins> about changes to the properties of <ins>other objects</ins>.  
Objects 에게 다른 objects 내 properties 의 변화를 알려주는 것.


Models 와 Views 사이와 같이 분리된 부분들간 데이터를 주고받을 때 사용하면 유용하다.
NSObject 를 inherit 하는 classes 에서만 사용할 수 있다.
<br>
<br>
<br>

## Annotate a Property for Key-Value Observing
KVO 를 통해 'observe' 하고 싶은 properties 에 '<ins>@objc dynamic</ins>' 을 앞에 사용한다.
```swift
@objc dynamic var observedProperty: NSDate(timeIntervalSince1970: 0)
```

<br>
<br>

## Define an Obserever
Observer class의 instance 는 property(또는 properties) 의 변화에 대한 정보를 관리한다.   
Observer 를 생성할 때는, <ins>observe(_:options:changeHandler)</ins> *method* 와 <ins>observe 하고싶은 property 의 key path</ins> 를 함께 사용해 호출함으로써 'observation' 을 시작한다. 
<br>
<Br>


아래 예시에서 \.objectToObserve.myDate 'key path' 는 MyObjectToObserve' 의 'myDate' 를 가리킨다.


```swift
import Foundation

class MyObjectToObserve: NSObject {
    @objc dynamic var myDate = NSDate(timeIntervalSince1970: 0)
    
    func updateDate() {
        myDate = myDate.addingTimeInterval(100)
    }
}

class MyObserver: NSObject {
    @objc var objectToObserve: MyObjectToObserve
    
    var observation: NSKeyValueObservation?
    
    init(object: MyObjectToObserve) {
        objectToObserve = object
        super.init()
        observation = observe(\.objectToObserve.myDate, options: [.old, .new], changeHandler: { object, change in
            print("myDate changed from: \(change.oldValue!) to \(change.newValue!)")
        })
    }
}

let observed = MyObjectToObserve()
let observer = MyObserver(object: observed)

observed.updateDate()
// myDate changed from: 1970-01-01 00:00:00 +0000 to 1970-01-01 00:01:40 +0000
```

위 예시에서 observing 하고있는 property 의 변화를 보기 위해 <ins>NSKeyValueObservedChange</ins> instance 의 *oldValue*, *newValue* properties 를 사용하고 있다.
만약 어떻게 변하는지 알 필요가 없다면 **options** parameter 를 제거하면 된다. 
options 를 빼면 new, old property values 의 저장 없이 진행되며, 이 경우 oldValue 와 newValue 를 nil 로 만든다.
<br>
<br>

## Associate the Observer with the Property to Observe
observer 의 initializer 에 'observe' 하고 싶은 대상을 넣어줌으로써 둘 사이의 관계를 맺게 할 수 있다.
```swift
let observed = MyObjectToObserve()
let observer = MyObserver(object: observed)
```

<br>
<br>

## Respond to a Property Change

Key-value observing 을 사용하기 위해 설정된 objects 는 그것들의(본인) property에 대한 변화를 observers 에게 알린다. 위 예시에서는 'updateDate' method 를 사용해서 myDate property 를 바꿔주고 있다. 이에 따라 자동으로 observer 의 change handler 가 trigger 된다. 

```swift
observed.updateDate()
// myDate changed from: 1970-01-01 00:00:00 +0000 to 1970-01-01 00:01:40 +0000
```
