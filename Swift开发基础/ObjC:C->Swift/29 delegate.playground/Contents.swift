//: Playground - noun: a place where people can play

import UIKit

/*
 Cocoa 开发中协议-委托 (Protocol-delegate) 模式是一种常用的设计模式
 它贯穿于整个 Cocoa 框架中，为代码之间的关系清理和解耦合做出了不可磨灭的贡献
 */

/*
 在 ARC 中，对于一般的 delegate,我们会在声明中将其指定为 weak
 在这个 delegate 实际的对象被释放的时候，会被重置回 nil
 
 这可以保证即使 delegate 已经不存在时
 我们也不会由于访问到已被回收的内存而导致崩溃
 
 ARC 的这个特性杜绝了 Cocoa 开发中一种非常常见的崩溃错误
 说是就万千程序员于水火之中也毫不为过。
 */

// 在 Swift 中当然也会希望这么做，但是当做下面尝试的时候，编译器不会让我们通过

protocol MyClassDelegate1 {
    func method()
}

class MyClass1 {
    weak var delegate: MyClassDelegate1?
}

class ViewController: UIViewController,MyClassDelegate1 {
    //...
    var someInstance: MyClass1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        someInstance = MyClass1()
        someInstance.delegate = self
    }
    
    func method() {
        print("Do something")
    }
}

// 'weak'must not be applied to non-class-bound 'MyclassDelegate'

/*
 这是因为 Swift 的 protocol 是可以被除了 class 以外的其他类型遵守的
 而对于 struct 或是 enum 这样的类型，本身就不通过引用计数来管理内存
 所以也不可能用 weak 这样的 ARC 的概念来进行修饰。
 */

/*
 想要在 Swift 中使用 weak delegate
 就需要将protocol 限制在 class 内
 */

/*
 #1
 将protocol 声明为 ObjC 的，这可以通过在 protocol 前面加上 @objc 关键字来达到
 ObjC 的 protocol 都只有类能实现，因此使用 weak 来修饰就合理了
 */
@objc protocol MyClassDelegate2 {
    func method()
}

/*
 #2
 另一种可能更好的办法是在 protocol 的声明的名字后面加上 class
 这可以为编译器显式地指明这个 protocol 只能由 class 来实现
 */

protocol MyClassDelegate3: class {
     func method()
}

// 相比起添加 @objc
// 后一种方法更能表现出问题的实质
// 同时也避免了过多的不必要的 ObjC 兼容，可以说是一种更好的解决方式。
