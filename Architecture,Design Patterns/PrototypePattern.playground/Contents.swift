import UIKit

var greeting = "Hello, playground"

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


