

# **Initialization**

Initialization 은 class, structure, 또는 enumeration 의 ***instance*** 를 사용하기 전 준비과정이다. 이 과정은 instance 의 <ins>각 stored property 에 대한 초기값 세팅</ins>과, <ins>그 외 새로운 instance 를 사용하기 위해 필요한 setup 과정</ins>을 포함한다.

Initialization 과정은 **initializers** 를 정의함으로써 구현할 수 있다. Initializer 는 특정 type 의 새로운 instance 를 생성하기 위해 호출될  수 있는 특별한 methods 이다. Objective-C initializer 와는 다르게 Swift initializer 는 값은 반환하지 않는다. 주 목적은 어떤 타입의 새로운 instance 가 처음 사용되기 전에 알맞게 initialized 되는 것이다.

Class type 의 instances 는 ***deinitializer*** 또한 구현할 수 있다. Deinitializer 는 어떠한 custom clean up 이라도 class 의 instance 가 deallocated 되기 전에 수행한다. [Deinitialization](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/deinitialization/)

<br>
<br>


# Setting Initial Values for Stored Properties

Classes 와 structures 는 instance 가 생성되기 전에 **모든 stored properties** 를 적절한 초기값을 갖도록 반드시 설정해야한다. 다시 말하면, **Stored properties** 는 정해지지 않은 상태로 내버려질 수 없다.

initializer 또는 property definition 부분에서 stored property 의 기본값을 정해줄 수 있다.
<br><br>

> **Note**
>
> stored property 에 기본 값을 할당하거나 initializer 에서 초기 값을 설정할 때, 어떠한 property observers 도 호출하지 않고 해당 값이 바로 정해진다.

<br>

### Initializers

Initializer 는 특정 type 의 새로운 instance 를 생성할 때 호출된다. 가장 단순한 형태의 initializer 는 parameters 가 없고 init keyword 가 사용된 instance method 처럼 생겼다. 

```swift
init() {
	// perform some initialization here
}
```

아래 예시에서는 Fahrenheit scale 로 온도를 저장하기 위해 Fahrenheit structure 를 정의하고있다. Fahrenheit structure 는 하나의 stored property 로 temperature 를 갖고, Type 은 Double 이다.

```swift
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")
// Prints "The default temperature is 32.0° Fahrenheit"
```

Fahrenheit Structure 는 **parameter 가 없는** 하나의 initializer 를 정의하고, 이 initializer 는 temperature 를 32.0 으로 initialize 시킨다. (Fahrenheit scale 에서 물의 어는 점)
<br>
<br>
### Default Property Values

Stored property 의 초기값은 위와 같이 initializer 에서 설정해줄 수도 있고, property 의 declaration 부분에서 default property value 를 정해줄 수도 있다. Property 가 defined 될 때 할당할 Default value를 정해주면 된다. 

> Note
> 
> 만약 property 가 항상 같은 초기값을 갖는다면, initializer 내에서 값을 설정하는 것 보다는 **default value** 를 정해주도록 하자. 결과는 같지만, default value 는 property 의 initialization 와 declaration 을 더 강하게 묶어준다. 이렇게 하면 짧고 명료한 initializers 를 만들 수 있고, default value 로부터 type 을 추론할 수 있게 해준다. Default value 는 default initializers 와 initializer inheritance 의 이점 또한 이용하기 쉽게 해준다. (나중에 나온다.)

Property 가 declared 되는 시점에 temperature property 에 default value 를 제공함으로써 위 Fahrenheit structure 를 아래와 같이 더 단순한 형태로 만들 수 있다. 

```swift
struct Fahrenheit { 
	var temperature = 32.0
}
```
<br><br>

# Customizing Initialization

Input parameters 와 optional property types 를 이용하거나, initialization 과정 중 constant properties 에 할당하는 방식으로 initialization process 를 customize 할 수 있다.

### Initialization Parameters

Initializer 의 definition 부분에서 initialization parameters 를 제공할 수 있다. (values 의 types, names 를 정의하기 위함)
Initialization parameters 는 function, method parameters 와 같은 capabilities 및 syntax 를 갖는다.

아래 예제에서는 Celsius structure 를 정의하고, 이 structure 는 Celsius 단위의 temperatures 를 저장한다. Celsius structure 에서는 두개의 custom initializers 를 구현하고있다. init(fromHahrenheit:), init(fromKelvin:) 는 다른 temperature scale 로부터 새로운 Celsius instance 를 initialize 한다. 

```swift
struct Celsius { 
	var temperatureInCelsius: Double
	init(fromFahrenheit fahrenheit: Double) { 
		temperatureInCelsius = (fahrenheit - 32.0) / 1.8
	}
	init(fromKelvin kelvin: Double){
		temperatureInCelsius = kelvin - 273.15
	}
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
// boilingPointOfWater.temperatureInCelsius is 100.0
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
 // freezingPointOfWater.temperatureInCelsius is 0.0
```

첫번째 initializer 는 argument label 로 fromFahrenheit 를, parameter name 으로 fahrenheit 을 갖고, 두번째 initializer 는 각각 fromKelvin, kelvin 을 갖는다. 두 initializers 모두 하나의 argument 를 Celsius 단위로 변환 후 temperatureInCelsius property 에 저장한다. 
<br><br>
### Parameter Names and Argument Labels

Function, method parameters 와 같이 initialization parameters 는 parameter name (init body 에서 사용) 과 argument label (init 을 호출할 때 사용) 을 가질 수 있다. 그러나 initializers 는 function, method 처럼 괄호 전에 그것들을 구분하는 ‘<ins>이름</ins>’ 을 갖지는 않는다. 따라서, initializer 내 parameters 의 name과 type 은  initializer 들을 ***구분***하는 역할을 한다. 그렇기 때문에, Swift 는 본인이 직접 만들어주지 않는 경우 각 parameter 에 대해 자동으로 argument label 을 만들어 initializer 를 제공한다.  
<br>

아래 예시에서는 세개의 constant properties (red, green, blue) 를 갖는 Color structure 를 정의한다. 세 properties 는 각각 color 의 양을 의미하는 0.0 ~ 1.0 사이의 값을 갖는다. ***Color*** 는 Double Type 의 red, green, blue 로 구성된 initializer 를 제공한다. Color 는 또한 ‘white’ parameter 하나만 갖는 initializer 도 갖는다. 이 initializer 는 세 color components 에 같은 값을 줄 때 사용된다. 

```swift
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}
```

<br>
두 initializers 모두 각 parameter 에 값을 넣어주어 새 Color instance 를 만들 때 사용될 수 있다. 

<br>

```swift
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)
```

<br>

이 initializers 를 argument labels 없이 호출하는 건 ***불가능***하다. Argument labels 는 initializer 에서 정의되어있다면 반드시 항상 사용되어야 하며, 그렇지 않으면 compile-time error 가 발생한다.

```swift
let veryGreen = Color(0.0, 1.0, 0.0)
// error: Missing argument labels 'red:green:blue:' in call
```
<br>

### Initializer Parameters Without Argument Labels

Initializer parameter 에 argument label 을 사용하고 싶지 않다면, underscore(_) 를 사용하여 default behavior 를 ***override*** 할 수 있다. 아래는 위 Celsius struct 의 확장된 버전이다. 여기에서는 Celsius scale 의 값을 바로 사용할 수 있는 initialize 가 있다.

```swift
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double){
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}

let bodyTemperature = Celsius(37.0)
// bodyTemperature.temperatureInCelsius is 37.0
```

Celsius(37.0) initializer 의 의미는 argument label 없이도 명확하다. 따라서, init(_ celsius: Double) 로 명명하여 unnamed Double 값을 넣어주도록 하는게 적절하다. 
<br>
<br>

### Optional Property Types

If your custom type has a stored property that’s logically allowed to have “no value”—perhaps because its value can’t be set during initialization, or because it’s allowed to have “no value” at some later point—declare the property with an optional type. Properties of optional type are automatically initialized with a value of nil, indicating that the property is deliberately intended to have “no value yet” during initialization.

The following example defines a class called SurveyQuestion, with an optional String property called response:
```swift

```
1. class SurveyQuestion {
2. var text: String
3. var response: String?
4. init(text: String) {
5. self.text = text
6. }
7. func ask() {
8. print(text)
9. }
10. }
11. let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
12. cheeseQuestion.ask()
13. // Prints "Do you like cheese?"
14. cheeseQuestion.response = "Yes, I do like cheese."

The response to a survey question can’t be known until it’s asked, and so the response property is declared with a type of String?, or “optional String”. It’s automatically assigned a default value of nil, meaning “no string yet”, when a new instance of SurveyQuestion is initialized.

### Assigning Constant Properties During Initialization

You can assign a value to a constant property at any point during initialization, as long as it’s set to a definite value by the time initialization finishes. Once a constant property is assigned a value, it can’t be further modified.

NOTE

For class instances, a constant property can be modified during initialization only by the class that introduces it. It can’t be modified by a subclass.

You can revise the SurveyQuestion example from above to use a constant property rather than a variable property for the text property of the question, to indicate that the question doesn’t change once an instance of SurveyQuestion is created. Even though the text property is now a constant, it can still be set within the class’s initializer:
```swift

```
1. class SurveyQuestion {
2. let text: String
3. var response: String?
4. init(text: String) {
5. self.text = text
6. }
7. func ask() {
8. print(text)
9. }
10. }
11. let beetsQuestion = SurveyQuestion(text: "How about beets?")
12. beetsQuestion.ask()
13. // Prints "How about beets?"
14. beetsQuestion.response = "I also like beets. (But not with cheese.)"

# Default Initializers

Swift provides a default initializer for any structure or class that provides default values for all of its properties and doesn’t provide at least one initializer itself. The default initializer simply creates a new instance with all of its properties set to their default values.

This example defines a class called ShoppingListItem, which encapsulates the name, quantity, and purchase state of an item in a shopping list:
```swift

```
1. class ShoppingListItem {
2. var name: String?
3. var quantity = 1
4. var purchased = false
5. }
6. var item = ShoppingListItem()

Because all properties of the ShoppingListItem class have default values, and because it’s a base class with no superclass, ShoppingListItem automatically gains a default initializer implementation that creates a new instance with all of its properties set to their default values. (The name property is an optional String property, and so it automatically receives a default value of nil, even though this value isn’t written in the code.) The example above uses the default initializer for the ShoppingListItem class to create a new instance of the class with initializer syntax, written as ShoppingListItem(), and assigns this new instance to a variable called item.

### Memberwise Initializers for Structure Types

Structure types automatically receive a memberwise initializer if they don’t define any of their own custom initializers. Unlike a default initializer, the structure receives a memberwise initializer even if it has stored properties that don’t have default values.

The memberwise initializer is a shorthand way to initialize the member properties of new structure instances. Initial values for the properties of the new instance can be passed to the memberwise initializer by name.

The example below defines a structure called Size with two properties called width and height. Both properties are inferred to be of type Double by assigning a default value of 0.0.

The Size structure automatically receives an init(width:height:) memberwise initializer, which you can use to initialize a new Size instance:
```swift

```
1. struct Size {
2. var width = 0.0, height = 0.0
3. }
4. let twoByTwo = Size(width: 2.0, height: 2.0)

When you call a memberwise initializer, you can omit values for any properties that have default values. In the example above, the Size structure has a default value for both its height and width properties. You can omit either property or both properties, and the initializer uses the default value for anything you omit—for example:
```swift

```
1. let zeroByTwo = Size(height: 2.0)
2. print(zeroByTwo.width, zeroByTwo.height)
3. // Prints "0.0 2.0"
4.  
5. let zeroByZero = Size()
6. print(zeroByZero.width, zeroByZero.height)
7. // Prints "0.0 0.0"

# Initializer Delegation for Value Types

Initializers can call other initializers to perform part of an instance’s initialization. This process, known as initializer delegation, avoids duplicating code across multiple initializers.

The rules for how initializer delegation works, and for what forms of delegation are allowed, are different for value types and class types. Value types (structures and enumerations) don’t support inheritance, and so their initializer delegation process is relatively simple, because they can only delegate to another initializer that they provide themselves. Classes, however, can inherit from other classes, as described in [Inheritance](https://docs.swift.org/swift-book/LanguageGuide/Inheritance.html). This means that classes have additional responsibilities for ensuring that all stored properties they inherit are assigned a suitable value during initialization. These responsibilities are described in [Class Inheritance and Initialization](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html#ID216) below.

For value types, you use self.init to refer to other initializers from the same value type when writing your own custom initializers. You can call self.init only from within an initializer.

Note that if you define a custom initializer for a value type, you will no longer have access to the default initializer (or the memberwise initializer, if it’s a structure) for that type. This constraint prevents a situation in which additional essential setup provided in a more complex initializer is accidentally circumvented by someone using one of the automatic initializers.

NOTE

If you want your custom value type to be initializable with the default initializer and memberwise initializer, and also with your own custom initializers, write your custom initializers in an extension rather than as part of the value type’s original implementation. For more information, see [Extensions](https://docs.swift.org/swift-book/LanguageGuide/Extensions.html).

The following example defines a custom Rect structure to represent a geometric rectangle. The example requires two supporting structures called Size and Point, both of which provide default values of 0.0 for all of their properties:
```swift

```
1. struct Size {
2. var width = 0.0, height = 0.0
3. }
4. struct Point {
5. var x = 0.0, y = 0.0
6. }

You can initialize the Rect structure below in one of three ways—by using its default zero-initialized origin and size property values, by providing a specific origin point and size, or by providing a specific center point and size. These initialization options are represented by three custom initializers that are part of the Rect structure’s definition:
```swift

```
1. struct Rect {
2. var origin = Point()
3. var size = Size()
4. init() {}
5. init(origin: Point, size: Size) {
6. self.origin = origin
7. self.size = size
8. }
9. init(center: Point, size: Size) {
10. let originX = center.x - (size.width / 2)
11. let originY = center.y - (size.height / 2)
12. self.init(origin: Point(x: originX, y: originY), size: size)
13. }
14. }

The first Rect initializer, init(), is functionally the same as the default initializer that the structure would have received if it didn’t have its own custom initializers. This initializer has an empty body, represented by an empty pair of curly braces {}. Calling this initializer returns a Rect instance whose origin and size properties are both initialized with the default values of Point(x: 0.0, y: 0.0) and Size(width: 0.0, height: 0.0) from their property definitions:
```swift

```
1. let basicRect = Rect()
2. // basicRect's origin is (0.0, 0.0) and its size is (0.0, 0.0)

The second Rect initializer, init(origin:size:), is functionally the same as the memberwise initializer that the structure would have received if it didn’t have its own custom initializers. This initializer simply assigns the origin and size argument values to the appropriate stored properties:
```swift

```
1. let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
2. size: Size(width: 5.0, height: 5.0))
3. // originRect's origin is (2.0, 2.0) and its size is (5.0, 5.0)

The third Rect initializer, init(center:size:), is slightly more complex. It starts by calculating an appropriate origin point based on a center point and a size value. It then calls (or delegates) to the init(origin:size:) initializer, which stores the new origin and size values in the appropriate properties:
```swift

```
1. let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
2. size: Size(width: 3.0, height: 3.0))
3. // centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)

The init(center:size:) initializer could have assigned the new values of origin and size to the appropriate properties itself. However, it’s more convenient (and clearer in intent) for the init(center:size:) initializer to take advantage of an existing initializer that already provides exactly that functionality.

NOTE

For an alternative way to write this example without defining the init() and init(origin:size:) initializers yourself, see [Extensions](https://docs.swift.org/swift-book/LanguageGuide/Extensions.html).

# Class Inheritance and Initialization

Class 의 모든 stored properties(superclass 로부터 상속받는 것들 포함) 은 반드시 initialization 과정에서 초기 값을 할당받아야한다. Swift 는 class types 에 대해 모든 stored properties 가 초기값을 갖도록 보장하기 위해 두종류의 initializers 를 정의한다. Designated initializers 와 Convenience initializers 이다. 

### Designated Initializers and Convenience Initializers

Designated initializers are the primary initializers for a class. A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain.

Classes tend to have very few designated initializers, and it’s quite common for a class to have only one. Designated initializers are “funnel” points through which initialization takes place, and through which the initialization process continues up the superclass chain.

Every class must have at least one designated initializer. In some cases, this requirement is satisfied by inheriting one or more designated initializers from a superclass, as described in [Automatic Initializer Inheritance](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html#ID222) below.

Convenience initializers are secondary, supporting initializers for a class. You can define a convenience initializer to call a designated initializer from the same class as the convenience initializer with some of the designated initializer’s parameters set to default values. You can also define a convenience initializer to create an instance of that class for a specific use case or input value type.

You don’t have to provide convenience initializers if your class doesn’t require them. Create convenience initializers whenever a shortcut to a common initialization pattern will save time or make initialization of the class clearer in intent.

### Syntax for Designated and Convenience Initializers

Designated initializers for classes are written in the same way as simple initializers for value types:
```swift

```
1. init(parameters) {
2. statements
3. }

Convenience initializers are written in the same style, but with the convenience modifier placed before the init keyword, separated by a space:
```swift

```
1. convenience init(parameters) {
2. statements
3. }

### Initializer Delegation for Class Types

To simplify the relationships between designated and convenience initializers, Swift applies the following three rules for delegation calls between initializers:

**Rule 1**

A designated initializer must call a designated initializer from its immediate superclass.

**Rule 2**

A convenience initializer must call another initializer from the same class.

**Rule 3**

A convenience initializer must ultimately call a designated initializer.

A simple way to remember this is:

- Designated initializers must always delegate up.
- Convenience initializers must always delegate across.

These rules are illustrated in the figure below:

![https://blog.kakaocdn.net/dn/cjPJwV/btrriVTOH0C/K8oI41nUkXo5XDlsXnkhU0/img.png](https://blog.kakaocdn.net/dn/cjPJwV/btrriVTOH0C/K8oI41nUkXo5XDlsXnkhU0/img.png)

Here, the superclass has a single designated initializer and two convenience initializers. One convenience initializer calls another convenience initializer, which in turn calls the single designated initializer. This satisfies rules 2 and 3 from above. The superclass doesn’t itself have a further superclass, and so rule 1 doesn’t apply.

The subclass in this figure has two designated initializers and one convenience initializer. The convenience initializer must call one of the two designated initializers, because it can only call another initializer from the same class. This satisfies rules 2 and 3 from above. Both designated initializers must call the single designated initializer from the superclass, to satisfy rule 1 from above.

NOTE

These rules don’t affect how users of your classes create instances of each class. Any initializer in the diagram above can be used to create a fully initialized instance of the class they belong to. The rules only affect how you write the implementation of the class’s initializers.

The figure below shows a more complex class hierarchy for four classes. It illustrates how the designated initializers in this hierarchy act as “funnel” points for class initialization, simplifying the interrelationships among classes in the chain:

![https://blog.kakaocdn.net/dn/oxfjC/btrrlT8RjJ4/wdzPDta2wP9fCXQTYYpuEK/img.png](https://blog.kakaocdn.net/dn/oxfjC/btrrlT8RjJ4/wdzPDta2wP9fCXQTYYpuEK/img.png)

### Two-Phase Initialization

Class initialization in Swift is a two-phase process. In the first phase, each stored property is assigned an initial value by the class that introduced it. Once the initial state for every stored property has been determined, the second phase begins, and each class is given the opportunity to customize its stored properties further before the new instance is considered ready for use.

The use of a two-phase initialization process makes initialization safe, while still giving complete flexibility to each class in a class hierarchy. Two-phase initialization prevents property values from being accessed before they’re initialized, and prevents property values from being set to a different value by another initializer unexpectedly.

NOTE

Swift’s two-phase initialization process is similar to initialization in Objective-C. The main difference is that during phase 1, Objective-C assigns zero or null values (such as 0 or nil) to every property. Swift’s initialization flow is more flexible in that it lets you set custom initial values, and can cope with types for which 0 or nil isn’t a valid default value.

Swift’s compiler performs four helpful safety-checks to make sure that two-phase initialization is completed without error:

**Safety check 1**

A designated initializer must ensure that all of the properties introduced by its class are initialized before it delegates up to a superclass initializer.

As mentioned above, the memory for an object is only considered fully initialized once the initial state of all of its stored properties is known. In order for this rule to be satisfied, a designated initializer must make sure that all of its own properties are initialized before it hands off up the chain.

**Safety check 2**

A designated initializer must delegate up to a superclass initializer before assigning a value to an inherited property. If it doesn’t, the new value the designated initializer assigns will be overwritten by the superclass as part of its own initialization.

**Safety check 3**

A convenience initializer must delegate to another initializer before assigning a value to any property (including properties defined by the same class). If it doesn’t, the new value the convenience initializer assigns will be overwritten by its own class’s designated initializer.

**Safety check 4**

An initializer can’t call any instance methods, read the values of any instance properties, or refer to self as a value until after the first phase of initialization is complete.

The class instance isn’t fully valid until the first phase ends. Properties can only be accessed, and methods can only be called, once the class instance is known to be valid at the end of the first phase.

Here’s how two-phase initialization plays out, based on the four safety checks above:

**Phase 1**

- A designated or convenience initializer is called on a class.
- Memory for a new instance of that class is allocated. The memory isn’t yet initialized.
- A designated initializer for that class confirms that all stored properties introduced by that class have a value. The memory for these stored properties is now initialized.
- The designated initializer hands off to a superclass initializer to perform the same task for its own stored properties.
- This continues up the class inheritance chain until the top of the chain is reached.
- Once the top of the chain is reached, and the final class in the chain has ensured that all of its stored properties have a value, the instance’s memory is considered to be fully initialized, and phase 1 is complete.

**Phase 2**

- Working back down from the top of the chain, each designated initializer in the chain has the option to customize the instance further. Initializers are now able to access self and can modify its properties, call its instance methods, and so on.
- Finally, any convenience initializers in the chain have the option to customize the instance and to work with self.

Here’s how phase 1 looks for an initialization call for a hypothetical subclass and superclass:

![https://blog.kakaocdn.net/dn/Ltbe8/btrrn2Eq52G/NuECdy02LZcmhTdpMXott1/img.png](https://blog.kakaocdn.net/dn/Ltbe8/btrrn2Eq52G/NuECdy02LZcmhTdpMXott1/img.png)

In this example, initialization begins with a call to a convenience initializer on the subclass. This convenience initializer can’t yet modify any properties. It delegates across to a designated initializer from the same class.

The designated initializer makes sure that all of the subclass’s properties have a value, as per safety check 1. It then calls a designated initializer on its superclass to continue the initialization up the chain.

The superclass’s designated initializer makes sure that all of the superclass properties have a value. There are no further superclasses to initialize, and so no further delegation is needed.

As soon as all properties of the superclass have an initial value, its memory is considered fully initialized, and phase 1 is complete.

Here’s how phase 2 looks for the same initialization call:

![https://blog.kakaocdn.net/dn/cD16kG/btrrotIyIkT/TslKw4KbshM7edyfytjkvk/img.png](https://blog.kakaocdn.net/dn/cD16kG/btrrotIyIkT/TslKw4KbshM7edyfytjkvk/img.png)

The superclass’s designated initializer now has an opportunity to customize the instance further (although it doesn’t have to).

Once the superclass’s designated initializer is finished, the subclass’s designated initializer can perform additional customization (although again, it doesn’t have to).

Finally, once the subclass’s designated initializer is finished, the convenience initializer that was originally called can perform additional customization.

### Initializer Inheritance and Overriding

Unlike subclasses in Objective-C, Swift subclasses don’t inherit their superclass initializers by default. Swift’s approach prevents a situation in which a simple initializer from a superclass is inherited by a more specialized subclass and is used to create a new instance of the subclass that isn’t fully or correctly initialized.

NOTE

Superclass initializers are inherited in certain circumstances, but only when it’s safe and appropriate to do so. For more information, see [Automatic Initializer Inheritance](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html#ID222) below.

If you want a custom subclass to present one or more of the same initializers as its superclass, you can provide a custom implementation of those initializers within the subclass.

When you write a subclass initializer that matches a superclass designated initializer, you are effectively providing an override of that designated initializer. Therefore, you must write the override modifier before the subclass’s initializer definition. This is true even if you are overriding an automatically provided default initializer, as described in [Default Initializers](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html#ID213).

As with an overridden property, method or subscript, the presence of the override modifier prompts Swift to check that the superclass has a matching designated initializer to be overridden, and validates that the parameters for your overriding initializer have been specified as intended.

NOTE

You always write the override modifier when overriding a superclass designated initializer, even if your subclass’s implementation of the initializer is a convenience initializer.

Conversely, if you write a subclass initializer that matches a superclass convenience initializer, that superclass convenience initializer can never be called directly by your subclass, as per the rules described above in [Initializer Delegation for Class Types](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html#ID219). Therefore, your subclass is not (strictly speaking) providing an override of the superclass initializer. As a result, you don’t write the override modifier when providing a matching implementation of a superclass convenience initializer.

The example below defines a base class called Vehicle. This base class declares a stored property called numberOfWheels, with a default Int value of 0. The numberOfWheels property is used by a computed property called description to create a String description of the vehicle’s characteristics:
```swift
class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}
```
The Vehicle class provides a default value for its only stored property, and doesn’t provide any custom initializers itself. As a result, it automatically receives a default initializer, as described in [Default Initializers](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html#ID213). The default initializer (when available) is always a designated initializer for a class, and can be used to create a new Vehicle instance with a numberOfWheels of 0:

```swift
let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")
// Vehicle: 0 wheel(s)
```

The next example defines a subclass of Vehicle called Bicycle:
```swift

```
1. class Bicycle: Vehicle {
2. override init() {
3. super.init()
4. numberOfWheels = 2
5. }
6. }

The Bicycle subclass defines a custom designated initializer, init(). This designated initializer matches a designated initializer from the superclass of Bicycle, and so the Bicycle version of this initializer is marked with the override modifier.

The init() initializer for Bicycle starts by calling super.init(), which calls the default initializer for the Bicycle class’s superclass, Vehicle. This ensures that the numberOfWheels inherited property is initialized by Vehicle before Bicycle has the opportunity to modify the property. After calling super.init(), the original value of numberOfWheels is replaced with a new value of 2.

If you create an instance of Bicycle, you can call its inherited description computed property to see how its numberOfWheels property has been updated:
```swift
let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")
// Bicycle: 2 wheel(s)
```


If a subclass initializer performs no customization in phase 2 of the initialization process, and the superclass has a zero-argument designated initializer, you can omit a call to super.init() after assigning values to all of the subclass’s stored properties.

This example defines another subclass of Vehicle, called Hoverboard. In its initializer, the Hoverboard class sets only its color property. Instead of making an explicit call to super.init(), this initializer relies on an implicit call to its superclass’s initializer to complete the process.

```swift

```

1. class Hoverboard: Vehicle {
2. var color: String
3. init(color: String) {
4. <s