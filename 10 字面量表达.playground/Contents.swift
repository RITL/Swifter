//: Playground - noun: a place where people can play

// 所谓字面量，就是指像特定的数字，字符串或者是布尔值
// 能够直截了当的指出自己的乐行，并为变量进行赋值的值
let aNumber = 3
let aString = "Hello"
let aBool = true

// 其中还过得3 Hello true都是字面量

// Array 和 Dictionary 在使用简单的描述赋值的时候，使用的也是字面量
let anArray = [1,2,3]
let aDictionary = ["key1": "Value1","key2": "Value2"]


// ExpressibleByBooleanLiteral 比较简单的协议

enum MyBool: Int {
    case myTrue, myFalse
}

extension MyBool: ExpressibleByBooleanLiteral {
    
    typealias BooleanLiteralType = Bool
    
    init(booleanLiteral value: Bool) {
        self = value ? .myTrue : .myFalse
    }
}


let myTrue: MyBool = true
let myFalse: MyBool = false

print("\(myTrue.rawValue)")// 0
print("\(myFalse.rawValue)")// 1


// ExpressibleByStringLiteral


//class Person {
//    let name: String
//    init(name value: String) {
//        self.name = name
//    }
//}

// 如果想通过string赋值来生成Person对象，进行改写

class Person: ExpressibleByStringLiteral {
    let name: String
    init(name value: String) {
        self.name = value
    }
    
    typealias StringLiteralType = String
    
    // 所有定义的init前面都要加上 required 关键词
    // 这是 ·初始化方法的完备性需求决定· 的
    // 用来确保类型安全
    
    
    // 由于很多重复的self.name 赋值的代码，这是我们不愿意看到的。
    // 一个改善的方式是在这些初始化方法中调用原来的init(name value :String)
    // 这种情况需要加 convenience
    
    required convenience init(stringLiteral value: String) {
        self.init(name: value)
    }
    
    required convenience init(extendedGraphemeClusterLiteral value: String){
        self.init(name: value)
    }
    
    required convenience init(unicodeScalarLiteral value: String){
        self.init(name: value)
    }
}

let p: Person = "xiaoming"
print("\(p.name)")


// 在上面的person例子中，没有像MyBool 中那样，使用一个 extension 的方法 扩展类，使其可以用字面量来赋值
// 因为在 extension 中，不能定义 required的初始化方法。
// 我们无法为现有的非 final 的 class 添加字面量表达式



