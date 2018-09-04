//: Playground - noun: a place where people can play

/*
 不知道是从什么时候开始
 “是否能通过 Category 给已有的类添加成员变量”就成为了一道 ObjC 面试中的常用题目
 不幸的消息是这个面试题目在 Swift 中可能依旧会存在
 */
 
/*
 得益于 ObjC 的运行时和 Key-Value Coding 的特性
 可以在运行时向一个对象添加值存储
 而在使用 Category 拓展现有的类的功能的时候
 直接添加实例变量这种行为是不被允许的
 这时候一般就使用  property 配合 Associated Object的方式
 将一个对象 “关联” 到已有的要拓展的对象上
 
 进行关联后，在对这个目标对象访问的时候
 从外界来看，就似乎是直接通过属性访问对象的实例变量一样，可以说非常方便
 */

/*
 在 Swift 中这样的方法依旧有效，只不过在写法上可能有些不同
 */

import UIKit

/*
func objc_getAssociatedObject(object: Any, key: UnsafePointer) -> Any?
 
func objc_setAssociatedObject(object: Any, key: UnsafePointer, Value: Any?, policy: objc_AssociationPolicy)
 */

/*
 这两个 API 所接受的参数也都 Swift 化了，并且因为 Swift 的安全性
 在类型检查上严格了不少
 因此我们有必要也进行一些调整
 
 在 Swift 中向某个 extension 里使用 Accociated Object 的方式将对象进行关联的写法是:
 */

class MyClass {
    
}

private var key: Void?

extension MyClass {
    var title: String? {
        get {
            return objc_getAssociatedObject(self, &key) as? String
        }
        
        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}

func printTitle(_ input: MyClass){
    if let title = input.title {
        print("Title: \(title)")
    }else {
        print("没有设置")
    }
}

let a = MyClass()
printTitle(a)
a.title = "Swifter.tips"
printTitle(a)

/*
 key 的类型在这里声明了 Void?
 并通过 & 操作符取地址 UnsafePointer<Void> 类型被传入
 这在 Swift 与 C 协作和指针操作时是一种很常见的用法
 
 关于 C 的指针操作和这些 unsafe 开头的类型的用法，可以查看 UnsafePointer
 */

