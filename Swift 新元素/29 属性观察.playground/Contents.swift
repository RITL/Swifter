//: Playground - noun: a place where people can play

import UIKit

// 属性观察（KVO）是Swift一个很特殊的特征，利用属性观察可以在当前类型内监视对于属性的设定，并做出一些响应。
// Swift提供了两个属性观察的方法，分别是 willSet 和 didSet

// 使用两个方法很简单，只要在属性声明的时候添加相应的代码块，就可以对将要设定的值和已经设定的值进行监听了.

class MyClass {
    var date: NSDate {
        willSet {
            let d = date
            print("即将将日期从\(d)设定至\(newValue)")
        }
        
        didSet {
            print("已经将日期从\(oldValue)设定至\(date)")
        }
    }
    
    init() {
        date = NSDate()
    }
}


let foo = MyClass()
foo.date = NSDate()

// 在 willSet 和 didSet 中分别可以使用newValue 和 oldValue 来获取将要设定的和已经设定的值。
// 属性观察的一个重要用处是作为设置值的验证，比如上面的例子中我们不希望date超过当前时间1年以上的话，可以将didSet修改一下

class MyClass1 {
    let oneYearInSeconds: TimeInterval = 365 * 24 * 60 * 60
    var date: NSDate {
        
        willSet {
            let d = date
            print("即将将日期从\(d)设定至\(newValue)")
        }
        
        didSet {
            if date.timeIntervalSinceNow > oneYearInSeconds {
                print("设定的时间太晚了！")
                date = NSDate().addingTimeInterval(oneYearInSeconds)
            }
            
            print("已经将日期从\(oldValue)设定至\(date)")
        }
    }
    
    init() {
        date = NSDate()
    }
}

let foo1 = MyClass1()
foo1.date = foo1.date.addingTimeInterval(100_000_000)

// 初始化方法对属性的设定，以及在willSet 和 didSet 中对属性的再次设定都不会再次触发属性观察的调用
// 一般来说这会是所需要的行为，可以放心使用能够

// 在Swift中声明的属性包括存储属性和计算属性两种
// 其中存储属性将会在内存中实际分配地址对属性进行存储，而计算属性则不包括背后的存储，只是提供set和get两种方法.
// 在同一类型中，属性观察和计算属性是不能同时共存的。
// 也就是说，想在一个属性定义中同时出现set 和 willSet 或 didSet 是一件办不到的事情。

// 计算属性中，可以通过改写set中的内容来达到和 willSet 或 didSet 同样的属性观察的目的

// 如果没法改动这个类，又想通过属性观察做一些事情的话，可能就需要子类化这个类，并且重写他的属性了。
// 重写的属性并不知道父类属性的具体实现情况，而只从父类属性中继承名字和类型，因此在子类的重载属性中是可以对父类的属性任意的添加属性观察的，而不用在意父类中到底是存储属性还是计算属性:

//Example:

class A {
    var number: Int {
        get {
            print("get")
            return 1
        }
        
        set { print("set") }
    }
}

class B: A {
    override var number: Int {
        willSet {
            print("willSet")
            
        }
        didSet {
            print("didSet")
        }
    }
}

// 调用number的set方法
let b = B()
b.number = 0

// 输出
// get
// willSet
// set
// didSet


// set 和对应的属性观察的调用都是预想之中。
// 但要注意: get首先给调用了一次。
// 因为实现了 didSet， didSet中会用到 oldValue,而这个值需要在set动作之前进行获取并存储待用，否则将无法确保正确性。
// 如果不实现didSet的话，这次get操作也将不存在。
