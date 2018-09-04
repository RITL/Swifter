//: Playground - noun: a place where people can play

// where关键字在Swift中非常强大，但是往往容易被忽略。
// 整理看一下where有哪些使用场合

//# switch语句，可以使用where来限定某些条件case:

let name = ["王小二","张三","李四","王二小"]

name.forEach {
    switch $0 {
    case let x where x.hasPrefix("王"):
        print("\(x)是笔者本家")
    default:
        print("你好,\($0)")
    }
}

// 这可以说是 模拟匹配 的标准用法了，对case条件进行限定可以让我们更灵活地使用swicth语句
print("\n")
// 在 for 中我们也可以使用where来做类似的条件限定:

let num: [Int?] = [48,99,nil]
let n = num.compactMap{$0} // 去除所有的nil
for score in n where score > 60 {
    print("及格啦.\(score)")
}
print("\n")
// 和for循环中类似，也可以对可选绑定进行条件限定。
// 在Swift 3 以后，if let 和 guard let 的条件不能再使用where,而是直接和普通条件判断一样，用逗号写在 if 和 guard 的后面:

num.forEach{
    if let source = $0,source > 60 {
        print("及格啦 -\(source)")
    }else {
        print(":{")
    }
}

// 这两种使用的方式可以额外的if来替代，这里只不过是让我们的代码更加易读了。
// 也有一些场合只有使用where才能准确表达，比如我们在泛型中想要对方法的类型进行限定的时候。

// 如果在标准库中对 RawRepresentable 协议定义 != 运算符定义时:

// public func !=<T: RawRepresentable>(lsh: T,rhs: T) -> Bool where T.RawValue: Equatable

// 这里限定了 T.RawValue 必须要遵守 Equatable 协议，这样才能通过对比 lhs 和 rhs 的 rawValue 是否相等.
// 如果没有where的保证的话，下面的代码就无法进行编译。
// 同时，也限定了那些 RawValue 无法判等的 RawRepresentable 类型不能判等。

//public func != <T: RawRepresentable>(lhs: T,rhs: T) -> Bool where T.RawValue: Equatable {
//    return lhs.rawValue != rhs.rawValue
//}

// 在Swift2.0中，引入了 protocol extension。
// 在有些时候，会希望一个协议拓展的默认实现只能在某些特定的条件下适用，这是就可以使用where关键字来进行限定。
// 标准库中中的协议拓展大量使用了这个技术来限定，比如 Sequence 的 sorted 方法就被定义在一个这样一个类型限制的协议拓展中:

//extension Sequence where Self.Iterator.Element : Comparable{
//
//    public func sorted() -> [Self.Iterator.Element]
//}

// 很自然，如果Sequence(比如一个 Array)中的元素是不可比较的，那么 sort 方法自然也就不能使用了。

let sortableArray: [Int] = [3,1,2,4,5]
let unsortableArray: [Any?] = ["hello",4,nil]
sortableArray.sorted()
//unsortableArray.sorted()//无法编译
// 这意味着 Swift 尝试使用带有闭包的 'sorted' 方法，并期望输入一种排序方式




