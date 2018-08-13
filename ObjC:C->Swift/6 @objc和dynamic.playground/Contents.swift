//: Playground - noun: a place where people can play

/*
 虽说 Swift 语言的初衷是希望摆脱 ObjC 的沉重的历史包袱和约束，
 但是不可否认的是经过了二十多年的洗礼，
 Cocoa 框架在就烙上了不可磨灭的 ObjC 的印记。
 
 无数的第三方库使用 Objctive-C 写成的，这些积累无论是谁都不能小觑。
 
 因此在最初的版本中，Swift 不得不考虑与 ObjC 的兼容。
 
 Apple采取的做法是允许在同一个项目中同时使用 Swift 和 ObjC 来进行开发。
 其实一个项目中的 ObjC 文件和 Swift 文件是处于两个不同世界中的，
 为了让他们能相互连通，需要添加一些桥梁。
 
 首先通过添加 {product-module-name}-Bridge-Header.h 文件
 并在其中填写想要使用的头文件名称
 就可以很容易的在 Swift 中使用ObjC代码了
 Xcode 简化了这个设定，甚至 Swift 项目中第一次导入 ObjC 文件时会主动弹框进行询问是否要自动创建这个文件，可以是非常方便了
 
 但是如果想要在 ObjC 中使用 Swift 的类型的时候，事情就复杂了一些
 如果是来自外部的框架，那么这个框架与ObjC项目肯定不是出在同一个 target 中，我们需要对外部的 Swift module 进行导入
 这个其实和使用 ObjC 的原来的 Framework 是一样的，对于一个项目来说，外界框架是由 Swift 写的还是 ObjC 写的，两者并没有太大区别
 可以通过 使用2013年新引入的 @import 来引入 module:

 ```
 @import MySwiftKit;
 
 ```
 之后就可以正常使用这个 Swift 写的框架了
 
 
 如果想要在ObjC里使用的是同一个项目中的Swift的原文件的话，可以直接导入自动生成的头文件 {product-module-name}-Swift.h 来完成。
 比如项目的 target 叫做 MyApp 的话，就需要在 ObjC 文件中写:
 
 ```
 #import "MyApp-Swift.h"
 
 ````
 但这只是故事的开始:
 
 
 ObjC 和 Swift 在底层使用的是两套完全不同的机制，Cocoa 中的 ObjC 是基于运行时的，从骨子里遵循了 KVC 以及动态派发。
 而 Swift 为了追求性能，如果没有特殊的需要的话，是不会再运行时来决定这些的。
 就是说，Swift 类型的成员或者方法在编译时就已经决定，而运行时便不再需要经过一次查找，，而可以直接使用。
 
 显而易见，这到来的问题是如果要使用 ObjC 的代码或者特性调用纯 Swift 的类型时候，会因为找不到所需要的这些运行时信息，导致失败
 
 解决起来很简单，在 Swift 类型文件中，可以将需要暴露给 ObjC 使用的任何地方(包括类，属性和方法等)的声明前加上 @objc 修饰符。
 
 这个步骤只需要对那些不是继承自 NSObject 的类型进行，如果用 Swift 写的 class 是继承自 NSObject 的话
 Swift 会默认自动为所有的非 private 的类和成员加上 @objc
 这就是说，对一个 NSObject 的子类，只需要导入相应的头文件就可以在 ObjC 里使用这个类了
 
 @objc 修饰符的另一个作用是为 ObjC 侧重新声明方法或者变量名字
 虽然绝大部分时候自动转换的方法名已经足够好用
 比如会将 Swift 中类似 init(name: String)) 的方法转换成 -initWithName:(NSString *)name 这样
 但是有时候还是期望 ObjC 里使用和 Swift 中不一样的方法名或者类的名称

*/

// 比如 Swift 里这样的一个类:
import Foundation

class 我的类: NSObject {
    func 打招呼(名字: String){
        print("哈喽,\(名字)")
    }
}

我的类().打招呼(名字: "小名")

/*
 
 在 Swift2.0 中，Apple 在从 Swift 导出头文件是引入了一个叫做 SWIFT_CLASS_NAMED 的宏来对原来Swift中的内容进行标记。
 这个宏使用LLVM的标记来对目标类的类型做出了限制，但是同时引入了不允许非 ASCII 编码的问题。
 下面的代码在 Swift1.x 环境下可以通过，但是在 Swift2 中引入会导致 Paramter of 'swift_name' attribute must be an ASCII identifier string 的编译错误，这应该是 Swift2.0 中的一个预期之外的倒退
 */

// ObjC 的话是无法使用中文来进行调用的，因此必须使用 @objc 将其转为 ASCII 才能在 ObjC 里访问:

@objc(MyClass1)
class 我的类1: NSObject {
    
    @objc(greeting:)
    func 打招呼(名字: String){
        print("哈喽,\(名字)")
    }
}

/*
 这样，在ObjC里就能调用 [[MyClass new] greeting:@""] 这样的代码了
 
 即使是 NSObject 的子类， Swift 也不会在被标记为 private 的方法或者成员上自动加 @objc，以保证尽量不使用动态派发来提高代码执行效率
 如果确定使用这些内容的动态特性的话，需要手动给他加上 @objc 修饰
 */

/*
 但需要注意的是: 添加 @objc 修饰符并不意味着这个方法或者属性会变成动态派发， Swift 依然可能会将其优化为静态调用
 如果需要和 ObjC 里动态调用时相同的运行时特性的话，需要使用的修饰符是 dynamic
 
 一般情况下在做 app 开发是应该用不上，但是在施展一些像动态替换方法或者运行时再决定实现这些的”黑魔法“的时候，就需要用到 dynamic 修饰符了

 */

// 关于 Swift 和 ObjC 混动的一个好消息是，随着 Swift 的发展， Apple 正在努力改善 SDK，在 ObjC 中追加了 nonnull 和 nullable，以及泛型数组和字典等，其实都是为了使 SDK 更加适合 Swift 来使用所做的努力，还是很有希望在不久的未来能够摆脱这些妥协和束缚的。
 

