//: Playground - noun: a place where people can play

// 在很多脚本中(Perl,Ruby等),都有类似0..3或者0...3这样的Range操作符，用来简单的指定一个从X开始连续计数到Y的发美味哦。

// 最基础的用法是两边指定数字
// 0...3 表示从0开始到3为止并包含3个数字的范围，将其称为全闭包的范围操作
// 在某些时候(比如操作数组的index时),更常用的是不包括最后一个数字的范围。
// 在Swift中被用一个看起来有些奇怪，但是表达的意义很清晰的操作符来定义，写作0..<3 (都写小于号了)，自然是不包括最后的3的意思

for i in 0...3 {
    print(i, terminator: " ")
}

import Foundation

// Swift中对这两个操作符的定义

/// 返回一个闭环的range,包括最小值以及最大值
//func ...<Pos: ForwardIndexType>(minimum: Pos,maximum: Pos) -> Range<Pos>

/// 返回一个闭环的range,包括开始以及结束的值 start <= end
//func ...<Pos: ForwardIndexType>(start: Pos, end: Pos) -> Range<Pos> where Pos: Comparable

/// 返回一个半开的range,包含最小值但是不包含最大值
//func ..<<Pos: ForwardIndexType>(minimum: Pos,maximum: Pos) -> Range<Pos>

/// 返回一个半开的range,包含开始值但是不包含结束值
//func ..<<Pos: ForwardIndexType>(start: Pos, end: Pos) -> Range<Pos> where Pos: Comparable

/// 返回一个闭环的环，从开始一直到结束
//func ...<T: Comparable>(start: T, end: T) -> ClosedInterval<T>

/// 返回一个半开的环，从开始到结束
//func ..<<T: Comparable>(start: T, end: T) -> HalfOpenInterval<T>

// 不难发现，这几个方法都是支持泛型的。
// 除了常用的输入Int 或者 Double, 返回 Range以外，还有一个接收Comparable的输入，并返回ClosedInterval 或者 HalfOpenInterval的重载。
// 在Swift中，除了数字以外另一个实现了 Comparable的基本类型就是 String。
// 就是说，可以通过...或者..<来连接两个字符串。

//Example:

let test = "helLo"
let interval = "a"..."z"
for c in test {
    if !interval.contains(String(c)) {
        print("\(c) 不是小写字母")
    }
}


// 日常开发中，可能会需要确定某个字符串是不是有效的ASCII字符，与上面很相似
// 可以使用 \0...~ 这样的 ClosedInterval 来进行
// \0 和 ~ 分别是 ASCII 的第一个和最后一个字符













