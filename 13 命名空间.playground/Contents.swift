//: Playground - noun: a place where people can play

import UIKit

// 与C#这样的显示在文件中指定命名空间的做法不同，Swift的命名空间是基于module而不是在代码中显式地指明。
// 每个module代表了Swift中的一个命名空间.
// 在同一个target里的类型名称还是不能相同。
// 在进行app开发时，默认添加到app的主target的内容都是出于同一个命名空间的，我们可以通过创建Cocoa(Touch)Framework的target的方法来新建一个module,这样就可以在两个不同的target中添加相同名字的类型了:


// MyFramework.swfit
// 这个文件存在于 MyFramework.framework中

//public class MyClass {
//    public class func hello(){
//        print("hello from framework")
//    }
//}


// MyApp.swift
// 这个文件存在于app的主target中
class MyClass {
    class func hello(){
        print("hello from app")
    }
}

//在使用时，如果出现可能冲突的时候，需要在类型名称前面加上module的名字(也就是target的名字)

MyClass.hello()

//MyFramework.MyClass.hello()




//MARK: 另一种

// 使用类型嵌套的方法来指定访问的范围。
// 常见做法是将名字重复的类型定义到不同的struct中，以此避免冲突。
// 这样在不使用多个module的情况下也能取得隔离同样名字的类型的效果

struct MyClassContainter1 {
    class MyClass {
        class func hello(){
            print("hello from MyClassContainter1")
        }
    }
}

struct MyClassContainter2 {
    class MyClass {
        class func hello(){
            print("hello from MyClassContainter2")
        }
    }
}

//使用时
MyClassContainter1.MyClass.hello()
MyClassContainter2.MyClass.hello()

// 不管哪种方式都和传统意义上的命名空间有所不同，把它叫做命名空间，更多的是一种概念的宣传
// 在实际使用中只要遵循这套规则的话，还是能避免不少不必要的麻烦，至少唾手可得的是我们不再需要给类名加上各种奇怪的前缀了
