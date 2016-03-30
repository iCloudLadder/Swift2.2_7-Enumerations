//: Playground - noun: a place where people can play

import UIKit


// >> 枚举

/*
 枚举为一组相关的值定义了一个共同的类型,使你可以在你的代码中以类型安全的方式来使用这些值。
 
 如果你熟悉 C 语言,你会知道在 C 语言中,枚举会为一组整型值分配相关联的名称。
 Swift 中的枚举更加灵活,不必给每一个枚举成员提供一个值。如果给枚举成员提供一个值(称为“原始”值),则该值的类型可以是字符串,字符,或是一个整型值或浮点数。
 此外,枚举成员可以指定任意类型的关联值存储到枚举成员中,就像其他语言中的联合体(unions)和变体(variants)。
 每一个枚举成员都可以有适当类型的关联值。
 
 在 Swift 中,枚举类型是一等(first-class)类型。
 它们采用了很多在传统上只被类(class)所支持的特性,
 例如计算型属性(computed properties),用于提供枚举值的附加信息,实例方法(instance method s),用于提供和枚举值相关联的功能。
 
 枚举也可以定义构造函数(initializers)来提供一个初始值;可以在原始实现的基础上扩展它们的功能;还可以遵守协议(protocols)来提供标准的功能。

 */




// 1. 枚举的语法

// 使用 enum 关键词来创建枚举并且把它们的整个定义放在一对大括号内:
enum SomeEnumeration {
 // 枚举定义放在这里
}

// 例
enum CompassPoint {
    case North
    case South
    case East
    case West
}
/*
 与 C 和 Objective-C 不同,Swift 的枚举成员在被创建时不会被赋予一个默认的整型值。
 在上面的 CompassPoint 例子中, North , South , East 和 West 不会被隐式地赋值为 0 , 1 , 2 和 3 。
 相反,这些枚举成员本身就是完备的值,这些值的类型是已经明确定义好的 CompassPoint 类型。
 */



// 多个成员值可以出现在同一行上,用逗号隔开:
enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}


// 每个枚举定义了一个全新的类型。

// 像 Swift 中其他类型一样,它们的名字(例如 CompassPoint 和 Planet )必须 以一个大写字母开头。
// 给枚举类型起一个单数名字而不是复数名字,以便于读起来更加容易理解:

var directionToHead = CompassPoint.West

// 一旦确定了 变量 的枚举类型就可以省略 . 前面的枚举类型名
directionToHead = .East




// 2. 使用Switch匹配枚举

switch directionToHead {
case .North:
    print("Lots of planets have a north")
case .South:
    print("Watch out for penguins")
case .East:
     print("Where the sun rises")
case .West:
    print("Where the skies are blue")
}

// 在判断一个枚举类型的值时, switch 语句必须穷举所有情况。否则编译不通过。
// 也可以使用 default 来涵盖一些其他没有穷举的枚举成员
let somePlanet = Planet.Earth
switch somePlanet {
case .Earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}








// 3. 关联值

/*
 你可以为 Planet.Earth 设置一个常量或者变量,并在赋值之后查看这个值。
 然而,有时候能够把其他类型的关联值和成员值一起存储起来会很有用。
 这能让你连同成员值一起存储额外的自定义信息,并且你每次在代码中使用该枚举成员时,还可以修改这个关联值。
 
 你可以定义 Swift 枚举来存储任意类型的关联值,如果需要的话,每个枚举成员的关联值类型可以各不相同。
 枚举的这种特性跟其他语言中的可识别联合(discriminated unions),标签联合(tagged unions),或者变体(variants)相似。
 */


//  Barcode 的枚举,它的一个成员值是具有 (Int,Int,Int,Int) 类型关联值的 UPCA ,另一个成员值是具有 String 类型关联值的 QRCode 。
enum Barcode {
    case UPCA(Int, Int, Int, Int) // 条形码
    case QRCode(String)  // 二维码
}

// 可以使用任意一种条形码类型创建新的条形码,例如:
 var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)
// 同一个商品可以被分配一个不同类型的条形码,例如:
productBarcode = .QRCode("ABCDEFGHIJKLMNOP")

// 可以使用一个 switch 语句来检查不同的条形码类型。
// 然而,这一次,关联值可以被提取出来作为 switch 语句的一部分。你可以在 的 case 分支代码中提取每个关联值作为一个常量(用   前缀)或者 作为一个变量(用 前缀)来使用:

switch productBarcode {
case .UPCA(let numberSystem, let manufacturer, let product, let check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case .QRCode(let productCode):
    print("QR code: \(productCode).")
}

// 如果一个枚举成员的所有关联值都被提取为常量,或者都被提取为变量,为了简洁,你可以只在成员名称前标注 一个 或者 :
switch productBarcode {
    case let .UPCA(numberSystem, manufacturer, product, check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
    case let .QRCode(productCode):
    print("QR code: \(productCode).")
}









// 4. 原始值

// 作为关联值的替代选 择,枚举成员可以被默认值(称为原始值)预填充,这些原始值的类型必须相同。

// 枚举类型 ASCIIControlCharacter 的原始值类型被定义为 Character ,并设置了一些比较常见的 ASCII 控制字 符。
enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

/*
 ***** 原始值和关联值是不同的。
    原始值是在定义枚举时被预先填充的值,像上述三个 ASCII 码。
    对于一个特定的枚举成员,它的原始值始终不变。
 
    关联值是创建一个基于枚举成员的常量或变量时才设置的值,枚举成员的关联值可以变化。
 
 */



// 4.1 原始值的隐式赋值

/*
 在使用原始值为整数或者字符串类型的枚举时,不需要显式地为每一个枚举成员设置原始值,Swift 将会自动为 你赋值。
 
 例如,当使用整数作为原始值时,隐式赋值的值依次递增 1 。如果第一个枚举成员没有设置原始值,其原始值将 为0。
 */
enum Planet1: Int {  // 2     3      4      5        6      7        8
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

// 当使用字符串作为枚举类型的原始值时,每个枚举成员的隐式原始值为该枚举成员的名称。

enum CompassPoint1: String {
    case North, South, East, West
} //  "North","South","East","West"



// 4.2 使用枚举成员的 rawValue 属性可以访问该枚举成员的原始值:
let earthsOrder = Planet1.Earth.rawValue
let sunsetDirection = CompassPoint1.West.rawValue


// 4.3  使用原始值初始化枚举实例

// 如果在定义枚举类型的时候使用了原始值,那么将会自动获得一个初始化方法,这个方法接收一个叫做 的参数,参数类型即为原始值类型,返回值则是枚举成员或 。
// 你可以使用这个初始化方法来创建一个新的枚举实例。
// **** 原始值构造器是一个可失败构造器,因为并不是每一个原始值都有与之对应的枚举成员。

// possiblePlanet 是 Planet1？ 可选类型，因为并非所有值都可以找到一个匹配的行星。
let possiblePlanet = Planet1(rawValue: 7)


// 若找位置为 9 的行星， 原始值构造器返回的可选 Planet1 值将是 nil
let positionToFind = 9
if let somePlanet = Planet1(rawValue: positionToFind) {
    switch somePlanet {
    case .Earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}










// 5. 递归枚举
/*
 递归枚举(recursive enumeration)是一种枚举类型,它有一个或多个枚举成员使用该枚举类型的实例作为关联值。
 使用递归枚举时,编译器会插入一个间接层。你可以在枚举成员前加上 indirect 来表示该成员可递归。
 */



enum ArithmeticExpression {
    case Number(Int)
    indirect case Addition(ArithmeticExpression, ArithmeticExpression)
    indirect case Multiplication(ArithmeticExpression, ArithmeticExpression)
}

// 也可以在枚举类型开头加上 indirect 关键字来表明它的所有成员都是可递归的:
indirect enum ArithmeticExpression1 {
    case Number(Int)
    case Addition(ArithmeticExpression, ArithmeticExpression)
    case Multiplication(ArithmeticExpression, ArithmeticExpression)
}

// hanoi 河内塔问题
// f(n) = 2*f(n-1) + 1
indirect enum HanoiExpression {
    case Number(Int)
    case Addition(HanoiExpression, HanoiExpression)
    case Multiplication(HanoiExpression, HanoiExpression)
    case f(HanoiExpression)
    
    static func hanoi(expression: HanoiExpression) -> Int {
        switch  expression {
        case .Number(let value):
            return value
        case .Addition(let left, let right):
            return hanoi(left) + hanoi(right)
        case .Multiplication(let left, let right):
            return hanoi(left) * hanoi(right)
        case f(let number) where hanoi(number) == 1:
            return hanoi(number)
        case f(let number) where hanoi(number) > 1:
            return hanoi(.Addition(.Multiplication(.Number(2), .f(.Number(hanoi(number) - 1))), .f(.Number(1))))
        default:
            return hanoi(.Number(0)) // or return 0
        }
    }
    
}

func hanoiSteps(number: Int) -> Int {
    return HanoiExpression.hanoi(.f(.Number(number)))
}


hanoiSteps(6)

// 1  2  3  4  5  6
// 1  3  7  15 31 63






















