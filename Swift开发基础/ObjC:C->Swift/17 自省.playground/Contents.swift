//: Playground - noun: a place where people can play

import UIKit

/*
 程序设计和人类哲学所面临的同一个很重大的课题就是解决 "我是谁" 这个问题。
 在这学历，这个问题属于自我认知的范畴
 而在程序设计时，这个问题设计到自省(Introspection)
 */

/*
 向一个对象发出询问，已确定它是不是属于某个类，这个操作就成为自省
 
 在 ObjC 中因为 id 这样的可以指向任意对象的指针的存在(严格来说 ObjC 的指针类型都是可以任意转向和转换的，他们只不过是帮助编译器理解代码而已)
 
 经常需要向一个对象询问它是不是属于某个类:
 
 [obj1 isKindOfClass: [ClassA class]];
 [obj2 isMemberOfClass: [ClassB class]];
 
 - isKindOfClass: 判断 obj1 是否是 ClassA 或者其子类的实例对象；
 而 isMemberOfClass: 则对 obj2 做出判断，而且仅当 obj2 的类型为 ClassB 时返回为真
 */

/*
 这两个方法是 NSObject 的方法，所以我们在 Swift 中如果写的是 NSObject 的子类的话
 直接使用这两个方法是没有任何问题的:
 */

class ClassA: NSObject {}
class ClassB: NSObject {}

let obj1: NSObject = ClassB()
let obj2: NSObject = ClassB()

obj1.isKind(of: ClassA.self) //true
obj1.isMember(of: ClassA.self) //false

/*
 在 ObjC 中我们几乎所有的类都会是 NSObject 的子类
 而在 Swift 的世界里，处于性能考虑，只要是有可能，应该更倾向于选择写非 NSObject 子类的 Swift 原生类型
 */

// #  对于那些不是 NSObject 的类

/*
 首先明确一点
 为什么需要在运行时区确定类型
 因为有泛型支持， Swift 对类型的推断和记录是完备的
 因此在绝大多数情况下，使用 Swift 类型都应该是在编译期间就确定的
 如果在写的代码中经常需要检查和确定 AnyObject 到底是什么类的话，几乎就意味着代码设计出了问题
 (或者 你正在写一些充满各种 “小技巧”的代码)
 */

class ClassC {}
class ClassD: ClassC {}

let obj3: AnyObject = ClassD()
let obj4: AnyObject = ClassD()

obj3.isKind(of: ClassC.self) //true
obj4.isMember(of: ClassC.self) //false


/*
 在 Swift 中对于 AnyObject 使用最多的地方应该就是那些返回 id 的 CocoaAPI了。
 
 为了快速确定类型， Swift 提供了一个简洁的写法:
 对于一个不确定的类型，我们现在可以使用 is 来进行判断
 is 在功能上相当于原来的 isKindOfClass
 可以检查一个对象是否属于某类型或其子类型
 
 is 和原来的区别主要在于亮点，首先他不仅可以用于 class 类型上
 也可以对 Swift 的其他像是 struct 或 enum 类型进行判断。
 */

class ClassE {}
class ClassF: ClassE {}

let obj5: AnyObject = ClassB()

if obj5 is ClassE {
    print("属于 ClassE")
}

if obj5 is ClassF {
    print("属于 ClassF")
}

/*
 编译器将对这种检查进行必要性的判断:
 
 如果编译器能够唯一确定类型，那么 is 的判断就没有必要
 编译器将会抛出一个警告，来提示你并没有转换的必要。
 */

let string = "String"
if string is String {//warning: 'is' test is always true
    //Do something
}








