//: Playground - noun: a place where people can play

import Foundation

// Swift中常用的原生容器有三种: Array Dictionary Set

/*
struct Array <Element> : RandomAccessCollection,MutableCollection {
    //...
}

struct Dictionary<Key: Hashable,Value> : Collection,ExpressibleByDictionaryLiteral {
    // ...
}

public struct Set<Element : Hashable> : SetAlgebra,Hashable,Collection,ExpressibleByArrayLiteral {
    
    // ...
}
 */

// 他们都是泛型的，就是说在一个集合中只能放同一个类型的元素
//Example:

let numbers = [1,2,3,4,5]
// numbers 的类型是 [Int]

let strings = ["Hello","world"]
// strings 的类型是 [String]


// 如果要把不相关的类型放到同一个容器类型中的话，需要做一些转换工作:
// Example:

let mixed: [Any] = [1,"two",3]

// 转换为[NSObject]
let objectArray = [1 as NSObject, "two" as NSObject, 3 as NSObject]

// Warning:
// 这样转换会造成部分信息的损失，从容器中取值时只能得到信息完全丢失后的结果，在使用时还需要进行一次类型转换。
// 其实这是再无其他可选方案后的最差选择:
// 因为使用这样的转换的话，编译器就不能给出提供警告信息了。
// 可以随意的将任意对象添加进容器，也可以将容器中取出的值转换为任意类型，这是十分危险的事情:

let any = mixed[0] //any 类型
let nsObject = objectArray[0] //NSObject 类型

// Any其实不是具体的某个类型
// 在容器类型泛型的帮助下，不仅可以在容器中添加同一具体类型的对象，也可以添加实现同一协议的类型的对象。
// 绝大多数情况下，想要放入一个容器中的元素或多或少都会有某些共同点，这就使得用协议来规定容器类型就会很有用

// 比如上面的例子 希望打印出容器内的元素的 description，可能更倾向于将数组声明为[CustomStringConvertible]的

let mixed1: [CustomStringConvertible] = [1, "two", 3]

for obj in mixed1 {
    print(obj.description)
}

// 这种方法虽然也损失了一部分类型信息，但相对于Any 或者 AnyObject 还是改善了很多，再对于对象中存在某种共同特性的情况下，无疑是最方便的。

// 另一种做法就是使用 enum 可以带有值的特点，将类型信息封装到特定的 enum 中。

enum IntOrString {
    case IntValue(Int)
    case StringValue(String)
}

let mixed2: [IntOrString] = [IntOrString.IntValue(1),
                             IntOrString.StringValue("two"),
                             IntOrString.IntValue(3)]

for value in mixed2 {
    switch value {
    case let .IntValue(i):
        print(i * 2)
    case let .StringValue(s):
        print(s.capitalized)
    }
}

// 通过这种方法，在完整的编译时保留了不同类型的信息。
// 甚至可以进一步为 IntOrString 使用字面量转换的方法编写简单的获取方式





