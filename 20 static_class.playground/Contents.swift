//: Playground - noun: a place where people can play

import Foundation

// Swift 表示 类型范围作用域 这一概念有两个不同的关键词 分别是static 和 class
// 这两个关键词确实都表达了这个意思，但是在其他一些语言，包括Objective-C中，并不会特别地 区分 类变量/类方法和 静态变量/静态函数。
// 但在Swift的早期版本中，这两个关键字是不能混用的！

// 在非class的类型上下文中，统一使用static来描述类型作用域。
// 这包括在 enum 和 struct 中表述类型方法和类型属性时。
// 在这两个值类型中，可以在类型返回内声明并使用存储属性，计算属性和方法

// Example:
// static 适用的场景:

struct Point {
    let x: Double
    let y: Double
    
    // 存储属性
    static let zero = Point(x: 0, y: 0)
    
    // 计算属性
    static var ones: [Point] {
        return [Point(x: 1, y: 1),
                Point(x: -1, y: 1),
                Point(x: 1, y: -1),
                Point(x: -1, y: -1)]
    }
    
    // 类型方法
    static func add(p1: Point, p2: Point) -> Point {
        return Point(x: p1.x + p2.x, y: p1.y + p2.y)
    }
}
// enum的情况类似

// class关键字相比起来就明白很多了，是专门用在class类型的上下文中。
// 可以用来修饰类方法以及类的计算属性
// 但有一个例外，class中是不能出现class的`存储属性`的

class Bar { }

//class MyClass {
//    class var bar: Bar? //Class stored properties not supported in classes
//}

class MyClass0 {
    static var bar: Bar?
}

// 比较特殊的是 protocol
// 在Swift中，class struct 和 enum都是可以实现某个 protocol的。
// 如果想在protocol里定义一个类型域上的方法或者`计算属性`的话，应该使用static进行定义
// 在使用的时候，struct 或 enum 中仍然使用 static
// 而在class中里 即可以使用class 也可以使用 static

protocol MyProtocol {
    static func foo() -> String
}

struct MyStruct: MyProtocol {
    static func foo() -> String {
        return "MyStruct"
    }
}

enum MyEnum: MyProtocol {
    static func foo() -> String {
        return "MyEnum"
    }
}

class MyClass: MyProtocol {
    class func foo() -> String {
        return "MyClass.foo()"
    }
    
    static func bar() -> String {
        return "MyClass.bar()"
    }
}

// 任何时候使用 static 应该都是没有问题的
