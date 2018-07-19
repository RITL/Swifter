//: Playground - noun: a place where people can play

import UIKit

//closure方式来传递参数

func doWork(block: ()->()){
    block()
//    print("返回")
}


//doWork {
//    print("work")
//}


// block的内容会在doWork返回前就完成


// 将block放到一个Dispatch中，让他在doWork返回后被调用
// @escaping 标记表明这个闭包会"逃逸"出该方法
func doWorkAsync(block: @escaping ()->()){
    DispatchQueue.main.async {//playground木有线程概念 - -
        block()
    }
//    print("返回")
}

doWorkAsync {
    print("work now!")
}


// 调用两个闭包调用的方法，会有一些行为的不同，闭包可以捕获其中的变量。
// 在doWork参数里没有逃逸行为的闭包，因为闭包的作用域不会超过函数本身，所以不需要担心闭包持有self等
// 接收escaping的doWorkAsync的有所不同。
// 由于需要确保闭包内的成员依然有效，如果闭包内引用了self及其成员，Swift将强制我们明确地写出self.

//Example:

class S {
    var foo = "foo"
    
    func method1() {
        doWork {
            print(foo)
        }
        foo = "bar"
    }
    
    func method2() {
        doWorkAsync {
            print(self.foo)//进行持有self
        }
        foo = "bar"
    }
    
    func method3() {
        doWorkAsync {
            [weak self] in //不再持有self
            print(self?.foo ?? "nil")
        }
        foo = "bar"
    }
}


S().method1()//foo
S().method2()//bar
S().method3()//nil

// 如果在协议或者父类中定义一个接受@escaping为参数方法，那么在实现协议和类型或者这个父类的子类中
// 对应的方法也必须被声明为@escaping 否则两个方法会被认为拥有不同的函数签名

protocol P {
    func work(b: @escaping ()->())
}

class C: P {
    func work(b: @escaping () -> ()) {
        DispatchQueue.main.async {
            print("in C")
            b()
        }
    }
}


//class C1: P {
//    func work(b: () -> ()) { //没有@escaping被视为两个不同的方法，所以不允许通过
//        ///....
//    }
//}
