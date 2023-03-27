

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

만약 논리적으로 '값 없는 상태'가 허용되는 (initialization 과정에서 설정될 수 없거나 어떤 시점에 값이 없을 수 있는 상황) stored property 를 가지는 경우, property 를 optional type 으로 선언하자. optional type 의 properties 는 자동으로 nil 로 초기화되며, 이는 property 가 initialization 과정 중 값이 없는 상태가 의도된 경우를 의미한다. 

아래 예시에서는 optional String type 의 'response' property를 갖는 SurveyQuestion 이라는 class 를 정의한다.

<br>

```swift
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
// Prints "Do you like cheese?"
cheeseQuestion.response = "Yes, I do like cheese."
```

survey question 에 대한 응답은 묻기 전까지 알 수 없으며, 따라서 response property 는 optional String 으로 선언되어있다. 새로운 SurveyQuestion 이 초기화 될 때 기본 값으로 nil 을 가지며, '값 없음' 을 의미한다.

<br>

### Assigning Constant Properties During Initialization

<br>

 initialization 가 끝날 때까지 명확한 값을 갖게된다면, 과정 도중 constant property 에 값을 할당할 수 있다.  constant property 에 값이 할당되면, 그 후에는 변경될 수 없다.

<br>


>NOTE
>
>class instances 의 경우, constant property 는 해당 instance 를 만든 class 에 의해서만 initialization 도중 변경될 수 있다. subclass 에 의해서는 변경될 수 없다. 

You can revise the SurveyQuestion example from above to use a constant property rather than a variable property for the text property of the question, to indicate that the question doesn’t change once an instance of SurveyQuestion is created. Even though the text property is now a constant, it can still be set within the class’s initializer:

SurveyQuestion 예제를 아래와 같이 question 에 대해 variable 이 아닌 constant property 를 갖도록 변경할 수 있고, 이는 SurveyQuestion 의 instance 가 생긴 후로는 변경되지 않을 것을 의미한다. text property 가 constant 이지만 여전히 class's initializer 내에서 값이 정해질 수 있다.

```swift
class SurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()
// Prints "How about beets?"
beetsQuestion.response = "I also like beets. (But not with cheese.)"
```


# Default Initializers

Swift provides a default initializer for any structure or class that provides default values for all of its properties and doesn’t provide at least one initializer itself. The default initializer simply creates a new instance with all of its properties set to their default values.

This example defines a class called ShoppingListItem, which encapsulates the name, quantity, and purchase state of an item in a shopping list:

Swift 는 어떠한 structure 나 class 에 대해(모든 properties 에 대해 default values 가 있고 initializer 가 자체로 주어지지 않은) default initializer 를 제공한다. Default initializer 는 단순히 모든 properties 가 default values 로 설정된 상태의 새로운 instance 를 생성시킨다. 
<br>

```swift
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()
```
<br>

ShoppingListItem class 의 모든 properties 가 default values 를 가지고있고, superclass 가 없는 base class 이므로, ShoppingListItem class 는 자동으로 default initializer 를 갖고, 이는 모든 properties 가 default values 을 갖는 새로운 instance 를 생성할 수 있게 한다. (name property 는 optional string 이므로 nil 을 기본값으로 갖는다.) 위 예시에서는 ShoppingListItem class 의 default initializer ShoppingListItem() 를 사용해서 새로운 instance 를 만들고, 'item' 에 그 instance 를 할당시킨다. 

<br>

### Memberwise Initializers for Structure Types

Structure types 는 만약 custom initializers 를 정의하지 않는다면, 자동으로 memberwise initializer 를 갖는다. Default initializer 와는 다르게, structure는 stored properties 가 default values 를 갖지 않더라도 memberwise initializer 를 받는다.

Memberwise initializer 는 새로운 structure instance 의 member properties 를 초기화시키는 간단한 방법이다. 새로운 instance 의 초기 값들은 '이름' 을 통해 memberwise initializer 로 전해진다. 

아래 예시에서는 width, height 두 properties 를 갖는 Size structure 를 정의한다. 두 properties 는 모두 기본값 0.0 을 가짐으로써 Double Type 으로 추론된다. 

Size structure 는 자동으로 init(width:height:) memberwise initializer 를 갖게되고, 새로운 Size instance 를 만들 때 사용할 수 있다.



```swift
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)
```

Memberwise initializer 를 호출할 때, default values 를 가지고 잇는 properties 에 대해서는 생략해도 된다. 위 예시에서 Size structure 는 두 height, width properties 모두에 대해 default value 를 가지고 있다. 따라서, 어떠한 property 도 생략해도 되고, 생략된 property 에 대해서는 default value 를 할당한다. 

<br>

```swift
let zeroByTwo = Size(height: 2.0)
print(zeroByTwo.width, zeroByTwo.height)
// Prints "0.0 2.0"

let zeroByZero = Size()
print(zeroByZero.width, zeroByZero.height)
// Prints "0.0 0.0"
```
<br>


# Initializer Delegation for Value Types

Initializer는 instance initialization의 일부를 수행하기 위해 다른 initializers 를 호출할 수 있다. 이 과정을 **initializer delegation** 이라고 부르며, 여러 initializers 간 중복되는 코드를 피하기 위함이다. 

<br>

Value type 인지, 또는 class type 인지에 따라서 initializer delegation 이 진행되는 rules, 그리고 어떤 형태의 delegation 이 허용될 지가 달라진다. Value types (structures, enumerations) 는 inheritance 를 지원하지 않으며, 따라서 initializer delegation process 는 그 자체에서 지원하는 initializer 에만 delegate 할 수 있으므로 비교적 단순하다. 그러나, Classes 의 경우 다른 classes 를 inherit 할 수 있다. 이는 classes 의 경우 inherit 한 모든 stored properties 가 initialization 과정 중 적당한 값으로의 할당이 보장되어야 하기 때문에 부수적인 responsibilities 가 필요하다는 것을 의미한다. 

<br>

Value types 의 경우, custom initializers 를 작성 할 때 같은 value type 내에서 다른 initializers 를 refer 하기 위해  self.init 를 사용한다. self.init 은 initializer 내에서만 호출할 수 있다.

<br>

만약 value type 에 대해 custom initializer 를 정의한다면, 더이상 default initializer(structure 의 경우 memberwise init) 를 해당 type 에 대해 사용할 수 없게된다. 이러한 제약은 더 복잡한 initializer 에서의 **추가적으로 필수적인 setup** 이 다른 사람이 automatic initializers 사용함으로써 수행되지 않는 것을 방지한다. 

<br>

>NOTE  
> 만약 본인의 custom value type 에 대해 default initializer 와 memberwise initializer, 그리고 custom initializers 모두 사용하고 싶은 경우, custom initializer 를 **extension** 에 작성하도록 하자. 

아래 예시에서는 사각형을 나타내는 custom structure **Rect** 를 정의한다. 이는 두개의 structures (Size, Point) 를 필요로 하며, 두 structure 모두 모든 properties 에 대해 default value로서 0.0 을 갖는다.

```swift
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
```

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