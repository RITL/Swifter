//: Playground - noun: a place where people can play

// 我们经常会对array类型使用map方法，但这个方法能对数组中的所有元素应用某个规则，然后返回一个新的数组。
// 我们可以在 Collection(原来叫做: CollectionType) 的 extension 中找到这个方法

//extension Collection {
//     public func map<T>(_ transform: (Self.Element) throws -> T) rethrows -> [T]
//}

//Example:

let arr = [1,2,3]
let doubled = arr.map{
    $0 * 2
}


// 这很方便，而且在其他一些语言里面 map 可以说是很常见也很常用的一个语言特性。
// 因此次特性出现在Swift中，也赢得了iOS/Mac开发者们的欢迎。

// 假设现在有个需求，要将某个Int? 乘以2。
// 一个合理的策略是如果这个 Int? 有值的话，就取出值乘2， 如果是nil的话，就直接将nil赋给结果。
// 依照这个策略，可以写出如下代码：

let num: Int? = 3
var result: Int?

if let realNum = num {
    result = realNum * 2
}else {
    result = nil
}

// 其实还有更优雅简介的方式，那就是使用Optional的map.
// 不仅仅是array或者说Collection里面可以使用map,如果仔细看过 optional 的声明的话，会发现有一个map方法。

//public func map<U>(_ transform: (Wrapped) throws -> U) rethrows -> U?

// 这个方法能够很方便的对一个Optional值做变化和操作，而不必进行手动的解包。
// 输入会被自动用类似 Optional Binding 的方式进行判断，如果有值，则进入 transform 的闭包进行变换，并返回一个U?
// 如果输入就是nil的话，则直接返回值为nil的U?

let num1: Int? = 3
let result1 = num1.map{
    $0 * 2
}

// 如果了解过一些函数式编程的概念，可能会对这正符合函子(Functor)的概念。
// 不论是array 还是 Optional，它们拥有同样名称的 map 函数并不是命名上的偶然。
// 函子指的是可以被某个函数作用，并映射为另一组结果，而这组结果也是函子的值。
// Array 的map 和 Optional 的map 都满足这个概念，分别将 [Self.Generator.Element] 映射为[T]以及T?映射为U?。
// Swift 是一门非常适合函数式编程的思想来进行程序设计的语言。

