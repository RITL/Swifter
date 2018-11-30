////: Playground - noun: a place where people can play
//
//// @selector 是 ObjC 时代的一个关键字，它可以将一个方法转换并赋值给一个SEL类型，它的表现很类似一个动态的函数指针。
//// 在ObjC时，selector非常常用，从设定target-action，到自举询问是否响应某个方法，再到置顶接收通知时需要调用的方法等等，都是由selector来负责的
//
//// 在ObjC里生成一个selector的方法一般是这个样子的:
//
///*
//```ObjC
//
// - (void) callMe {
//
// }
//
// - (void)callMeWithParam:(id)obj{
//
// }
//
// SEL someMethod = @selector(callMe);
// SEL anotherMethod = @selector(callMeWithParam:)
//
//```
// */
//
//// 一般为了方便，很多人会选择使用@selector，但是如果要追求灵活的话，可能会更愿意NSSelectorFromString的版本 - 因为可以在运行时动态生成字符串，从而通过方法的名字来调用到对应的方法。
//
//// 在Swift中没有@selector，取而代之，从Swift2.2开始使用#selector来从暴露给ObjC的代码中获取一个selector。
//// 类似的，在Swift中对应原来SEL类型的是一个叫做Selector的结构体
//
//import Foundation
//import UIKit
//
//// Swift等效写法
////@objc func callMe() {
////
////}
//
////@objc func callMeWithParam(obj: AnyObject) {
////
////}
//
////let someMethod = #selector(callMe)
////let anotherMethod = #selector(callMeWithParam(obj:))
//
//
//// 和ObjC时一样，记得在callMeWithParam后面加上冒号，这才是完整的方法名字。
//// 多个参数的方法名也和原来类似
//
//// 最后需要注意的是，selector其实是ObjC runtime的概念。
//// 在Swift4中，默认情况下所有的Swift方法都是ObjC中都是不可见的，所以需要在这类方法前面加上@objc关键字，将这个方法暴露给ObjC才能进行使用。
//
//// 在Swift3和之前的版本，Apple为了更好地ObjC兼容性，会自动对NSObject的子类的非私有方法进行推断并为在幕后为它们自动加上@objc.
//// 但这需要每次Swift代码变动时都重新生成ObjC所使用的头文件，这将造成Swift与ObjC混编时速度大幅恶化。
//// 另外Swift3中，私有方法也只在Swift中可见，在调用selector时会遇到一个unrecognized selector方法
//
/////// 错误代码
//private func callMe() {
//
//}
//
////Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(callMe), userInfo: nil, repeats: false)
//
//// 争取的做法是在private前面加上@objc关键字
//
//// @objc private func callMe() {
////
////}
////
////Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(callMe), userInfo: nil, repeats: false)
//
//
//// 同理，如果现在想要ObjC能使用Swift的类型或者方法的话，也需要进行相应的标记。
//// 对于单个方法，在前面添加@objc。
//// 如果想让整个类型在 ObjC 可用，可以在类型前面添加 @objcMembers
//
//// 最后值得一提的是，如果方法名字在方法所在的域内是唯一的话，我们可以简单地只是用方法的名字来作为#selector的内容。
//// 相比于前面带有冒号的完整的形式来说，这么写起来会方便一些:
////let someMethod = #selector(callMe)
////let anotherMethod = #selector(callmeWithParam)
////let method = #selector(trun)
//
//// 但是如果在一个作用域中存在同样名字的两个方法，即时他们的函数签名不同，Swift编译器也不允许编译通过。
//
////@objc func commonFunc() {
////
////}
////
////@objc func commonFunc(input: Int) -> Int {
////    return input
////}
////
////let method = #selector(commonFunc) //编译错误，因为commonFunc有歧义
//
//// 对于这种问题,可以通过将方法进行强制转换来使用
//
////let method1 = #selector(commonFunc as ()->())
////let method2 = #selector(commonFunc as (Int) -> Int)
//


//====装饰者模式（Decorate Pattern）====
//开放关闭原则：类应该对扩展开放，对修改关闭
//在不修改代码的情况下进行功能扩展
//装饰者模式：动态地将责任附加到对象上。若要扩展功能，装饰着提供了比继承更有弹性的替代方案。

///=================定义基类==========================
/// 饮料基类
class Beverage {
    var description: String
    
    init(description: String = "Unknown Beverage") {
        self.description = description
    }
    
    func getDescription() -> String {
        return description
    }
    
    func cost() -> Double {
        return 0.0
    }
}

/// 调料基类
class CondimentDecorator: Beverage {
    override func getDescription() -> String {
        return ""
    }
}



///=================实现不同的咖啡==============
/// 浓缩咖啡
class Espresso: Beverage {
    init() {
        super.init(description: "浓缩咖啡")
    }
    
    override func cost() -> Double {
        return 1.99
    }
}

class HouseBlend: Beverage {
    init() {
        super.init(description: "星巴克杜绝调配咖啡：综合咖啡")
    }
    
    override func cost() -> Double {
        return 0.99
    }
}



/// ============实现各种调料===========
///摩卡
class Mocha: CondimentDecorator {
    var beverage: Beverage
    init(beverage: Beverage) {
        self.beverage = beverage
    }
    
    override func getDescription() -> String {
        return "摩卡, " + beverage.getDescription()
    }
    
    override func cost() -> Double {
        return beverage.cost() + 0.29
    }
}

/// 牛奶
class Milk: CondimentDecorator {
    var beverage: Beverage
    init(beverage: Beverage) {
        self.beverage = beverage
    }
    
    override func getDescription() -> String {
        return "牛奶, " + beverage.getDescription()
    }
    
    override func cost() -> Double {
        return beverage.cost() + 0.59
    }
}



/**
 *  使用
 */
//创建浓缩咖啡
var espresso: Beverage = Espresso()

/**
 *  用户点了一杯牛奶摩卡浓缩咖啡
 */
espresso = Milk(beverage: espresso)     //加牛奶
espresso = Mocha(beverage: espresso)    //加Mocha

espresso.getDescription()
espresso.cost()




