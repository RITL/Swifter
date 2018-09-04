//: Playground - noun: a place where people can play

// 作为一门先进的变成语言，Swift吸收了众多其他语言先进的语言的有点，但有一点确实让人略微失望，就是Swift至今为止没有在语言层面上支持 正则表达式

// 如果能使用 =~ 这样的符号来进行正则匹配

// 自定义 =~ 运算符
// 在Cocoa中可以使用 NSRegularExpression 来做 正则匹配

import Foundation

// 使用的时候，比如想匹配一个邮箱地址
let mailPattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
let matcher: RegexHelper
do {
    matcher = try RegexHelper(mailPattern)
}

let maybeMailAddress = "yuexiaowen108@gmail.com"

if matcher.match(maybeMailAddress){
    print("有效的邮箱地址")
}else {
    print("无效的邮箱地址")
}

// 实现=~

precedencegroup MathPrecedence {
    associativity: none
    higherThan: DefaultPrecedence
}

infix operator =~: MathPrecedence

func =~(lhs: String, rhs: String) -> Bool {
    do {
        return try RegexHelper(rhs).match(lhs)
    }catch {
        return false
    }
}

// 使用类似其他语言的正则表达式了

if "yuexiaowen108@gmail.com" =~ "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$" {
    print("有效的邮箱地址")
}else {
    print("无效的邮箱地址")
}




