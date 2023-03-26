import UIKit

//var greeting = "Hello, playground"


public enum Meat: String {
    case beef
    case chicken
    case pork
}

public enum Sauce: String {
    case mayonnaise
    case mustard
    case ketchup
    case secret
}

public enum Vegetable: String {
    case cabbage
    case lettuce
    case pickels
    case tomatoes
}

public enum Bread: String {
    case brownBread
    case hotDogBun
    case mealBread
    case ryeBread
}

public struct Hamburger {
    public let meat: Meat
    public let sauce: Set<Sauce>
    public let vegetable: Set<Vegetable>
    public let bread: Bread
    
    func getAllProperty() {
        print("Meat = \(meat)")
        print("sauce = \(sauce)")
        print("vegetable = \(vegetable)")
        print("bread = \(bread)")
    }
}


public class HamburgerBuilder {
    public private(set) var meat: Meat = .beef
    public private(set) var sauces: Set<Sauce> = []
    public private(set) var vegetables: Set<Vegetable> = []
    public private(set) var bread: Bread = .brownBread
    
    public func addSauce(_ sauce: Sauce) {
        sauces.insert(sauce)
    }
    
    public func removeSauce(_ sauce: Sauce) {
        sauces.remove(sauce)
    }
    
    
    public func addVegetable(_ vegetable: Vegetable) {
        vegetables.insert(vegetable)
    }
    
    public func removeVegetable(_ vegetable: Vegetable) {
        vegetables.remove(vegetable)
    }
    
    
    public func setMeat(_ meat: Meat) {
        self.meat = meat
    }
    
    public func setBread(_ bread: Bread) {
        self.bread = bread
    }
    
    public func build() -> Hamburger {
        return Hamburger(meat: meat, sauce: sauces, vegetable: vegetables, bread: bread)
    }
}


let builder = HamburgerBuilder()
print("first burger")
var hamburger = builder.build()
hamburger.getAllProperty()

print("\nsecond burger")
builder.setMeat(.chicken)
builder.setBread(.hotDogBun)
builder.addSauce(.secret)
builder.addVegetable(.cabbage)
hamburger = builder.build()
hamburger.getAllProperty()


class HamburgerDirector {
    public func createBeefBurger() -> Hamburger {
        let builder = HamburgerBuilder()
        builder.setMeat(.beef)
        builder.addSauce(.ketchup)
        builder.addSauce(.mustard)
        builder.addVegetable(.lettuce)
        builder.setBread(.ryeBread)
        return builder.build()
    }
    
    public func createChickenBurger() -> Hamburger {
        let builder = HamburgerBuilder()
        builder.setMeat(.chicken)
        builder.addSauce(.secret)
        builder.addSauce(.mayonnaise)
        builder.addVegetable(.cabbage)
        builder.addVegetable(.tomatoes)
        builder.setBread(.brownBread)
        return builder.build()
    }
}

let director = HamburgerDirector()
let beefBurger = director.createBeefBurger()
print("\nthird burger")
beefBurger.getAllProperty()
