# Prototype Pattern

코드를 클래스에 종속시키지 않고 기존에 존재하던 객체를 복사할 수 있는 디자인 패턴

어떤 객체와 정확하게 똑같은 객체를 만들고 싶을 때 사용. 우선, 클래스와 같은 reference type 을 복사하는 방법에는 얕은 복사(shallow), 깊은 복사(deep copy) 가 있음. 
- **얕은 복사**: 새로운 변수에 기존 객체를 할당. 생성된 객체는 기존 객체를 계속 가리키고 있어서 새로운 객체라 할 수 없음.
- **깊은 복사**: 모든 정보를 동일하게 가진 새로운 객체를 생성

원본 객체의 모든 값을 가지고 직접 새로운 객체를 만드려고 하는 경우, private property 에는 접근할 수 없기 때문에 할 수 없을 수 있음. 또한, 복사본을 만들기 위해 원본 객체의 클래스를 알아야 하기 때문에 코드가 해당 클래스에 종속되어 의존성 발생.

이런 상황에서 Prototype Pattern 사용할 수 있음. Prototype Class 를 만들어서 간편하게 사용 가능. 또한, Prototype 이 Protocol 을 갖는 객체를 허용하여 클래스 의존성도 해결할 수 있음. 즉, 객체의 복제를 직접 하는 것이 아닌 Prototype Class 에 넘겨서 처리하는 패턴.
<br><br>

```swift
public protocol Prototype: class {
    init(prototype: Self)
}

extension Prototype {
    public func clone() -> Self {
        return type(of: self).init(prototype: self)
    }
}


// Concrete Prototype
public class Marin: Prototype {
    
    public var health: Int
    public var attack: Int
    public var defence: Int
    
    public init(health: Int, attack: Int, defence: Int) {
        self.health = health
        self.attack = attack
        self.defence = defence
    }
    
    public required convenience init(prototype: Marin) {
        self.init(health: prototype.health, attack: prototype.attack, defence: prototype.defence)
    }
    
    func printStatus() {
        print("Marin Health: \(health) Attack: \(attack) Defence: \(defence)")
    }
}


public class Medic: Prototype {
    
    public var health: Int
    public var mana: Int
    public var defence: Int
    
    public init(health: Int, mana: Int, defence: Int) {
        self.health = health
        self.mana = mana
        self.defence = defence
    }
    
    public required convenience init(prototype: Medic) {
        self.init(health: prototype.health, mana: prototype.mana, defence: prototype.defence)
    }
    func printStatus() {
        print("Medic Health: \(health) Mana: \(mana) Defence: \(defence)\n")
    }
}



var marin = Marin(health: 40, attack: 5, defence: 1)
var shallowCopyMarin = marin
var deepCopyMarin = marin.clone()

shallowCopyMarin.health += 7
deepCopyMarin.defence += 5

marin.printStatus()
deepCopyMarin.printStatus()

var marinAddress: UnsafeMutablePointer<Marin> = .init(&marin)
var shallowCopyMarinAddress: UnsafeMutablePointer<Marin> = .init(&shallowCopyMarin)
var deepCopyMarinAddress: UnsafeMutablePointer<Marin> = .init(&deepCopyMarin)

print("원본 마린 주소 : \(marinAddress)")
print("얕은 복사 마린 주소 : \(shallowCopyMarinAddress)")
print("깊은 복사 마린 주소 : \(deepCopyMarinAddress)")
```




출처  
https://icksw.tistory.com/238