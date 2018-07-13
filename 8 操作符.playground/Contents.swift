//: Playground - noun: a place where people can play

import UIKit

// 与ObjC不同，Swift支持重载操作符
// Example

struct Vector2D {
    var x = 0.0
    var y = 0.0
}

// 需求是两个 Vector2D 相加
let v1 = Vector2D(x: 2.0, y: 3.0)
let v2 = Vector2D(x: 1.0, y: 4.0)
let v3 = Vector2D(x: v1.x + v2.x, y: v1.y + v2.y)


// 如果一次还好，但一般情况我们会进行很多这种操作。

// 重载加号操作符
func +(left: Vector2D,right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}

let v4 = v1 + v2


// 点积运算 表示两个向量对应坐标的乘积的和

// 如果不加下面的定义操作符，会报错

precedencegroup DotProductPrecedence {
    associativity: none
    higherThan: MultiplicationPrecedence
}

infix operator +*: DotProductPrecedence


/*
 
 ***************************
 
 precedencegroup
 
 定义一个操作符的优先级。
 操作符优先级的定义和类型声明有些相似，一个操作符比需要属于某个特定的优先级
 
 Swift标准库中已经定义了一些常用的运算优先级组:
 加法：AdditionPrecedence
 乘法：MultiplicationPrecedence
 
 如果没有适合的运算符的优先级组，需要定义，如上
 
 ***************************
 
 associativity
 
 定义结合律，如果多个同类的操作符顺序出现的计算顺序
 
 比如常见的:
 加法和减法都是left，就是说多个加法同时出现按照从左到右的顺序计算
 点乘的结果是一个 Double，不能再会和其他点乘结合使用，所以这里使用的none
 
 ***************************
 
 higherThan
 
 运算的优先级，点击运算是优先于乘法运算的。
 
 除了higherThan，也支持使用lowerThan来指定优先级低于某个其他组
 
 ***************************
 
 infix
 
 表示定义的一个中位数操作符，即前后都是输入
 
 其他的修饰子还包括 prefix 和 postfix
 
 */


// 追加结束

func +*(left: Vector2D, right: Vector2D) -> Double {
    return left.x * right.x + left.y * right.y
}

let result = v1 +* v2


/*
 
 注意！
 
 Swift的操作符是不能定义在局部域中，因为至少会希望在全局范围使用自己的操作符，否则操作符也就失去了意义。
 来自不同的module的操作符是有可能冲突的，这对于库开发者来说是需要特别注意的地方。
 如果库中的操作符冲突的话，使用者是无法想解决类型名冲突那样通过制定库名字来进行调用的。
 在重载或者自定义操作符时，应当尽量将其作为其他某个方法的"简便写法"，而避免在其中实现大量逻辑或者提供独一无二的功能。
 这样即使出现了冲突，使用者也还可以通过方法名调用的方式使用库。
 运算符的命名也应当尽量明了，避免歧义和可能的误解。
 一个不被公认的操作符时存在冲突风险和理解难度的，不应该滥用这个特性。
 在使用重载或者自定义操作符时，需要再三权衡斟酌，确定是否真的需要这个操作符。

 */

