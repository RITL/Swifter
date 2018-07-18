//: Playground - noun: a place where people can play

import UIKit
import Foundation

// 之前的正则表达式中，实现了 ~= 操作符进行简单的正则匹配。
// 虽然Swift中内有内置的正则表达式支持，但有一个和正则匹配相似的特性内置于Swift - 模式匹配

// 从概念上讲: 正则匹配是模式匹配的一个子集，但Swift里现在的模式匹配还是很初级，也很简单，只能支持最简单的相等匹配和范围匹配。
// 在Swift中，使用~=来表示模式匹配的操作符。

//func ~=<T: Equatable>(a: T,b: T) -> Bool
//func ~=<T> (lhs: _OptionalNilComparionType, rhs: T?) -> Bool
//func ~=<I: IntervalType>(pattern: I,value: T.Bound) -> Bool

// 从上至下在操作符左右两边分别接受可以判等的类型，可以与nil比较的类型，以及一个范围输入和某个特定值，返回值很明了，都是是否匹配成功的Bool值

// 强大的: Switch

//#1 可以判等的类型的判断

let password = "afdsadas"

switch password {
    case "afdsadas": print("密码通过")
    default: print("验证失败")
}

//#2 对Optional的判断

let num: Int? = nil
switch num {
    case nil: print("没值")
    default: print("\(num!)")
}

//#3 对范围的判断
let x = 0.5
switch x {
    case -1.0...1.0: print("区间内")
    default: print("区间外")
}

// Swift的switch就是使用了~=操作符进行模式匹配，case指定的模式作为左参数，而等待匹配的被switch的元素作为操作符的右侧参数。
// 只不过这个操作是由Swift隐式地完成
// 比如在switch中做case判断的时候，完全可以使用自定义的模式匹配方法来进行判断，有时候这会让代码变得非常简单，具有条理。
// 只需要按照需求重载 ~= 操作符就好了

//Example:
// 正则表达式匹配

// 重载 ~= 操作符，接受一个 NSRegularExpression 作为模式，去匹配输入的String:

func ~=(pattern: NSRegularExpression,input: String) -> Bool {
    return pattern.numberOfMatches(in: input, options: [], range: NSRange(location: 0, length: input.count)) > 0
}

// 为了简单期起见，添加一个将字符串转为 NSRegularExpression的操作符

prefix operator ~/ //在左边的时候起作用

prefix func ~/(pattern: String) throws -> NSRegularExpression {

    return try NSRegularExpression(pattern: pattern, options: [])

}

let contact = ("http://yuexiaowen.com","yuexiaowen108@gmail.com")
let mailRegex: NSRegularExpression?
let siteRegex: NSRegularExpression?

mailRegex = try ~/"^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
siteRegex = try ~/"^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"

switch contact {
    case (siteRegex!,mailRegex!): print("同时拥有有效的网站和邮箱")
    case (_,mailRegex!): print("只拥有有效的邮箱")
    case (siteRegex!,_): print("只拥有有效网站")
    default: print("嘛都没有!")
}
