//: Playground - noun: a place where people can play

import UIKit

// MARK: @autoclosure 将依据表达式自动地封装成一个闭包（closure）
// 不支持含参数的闭包，只有() -> T形式的参数才能使用这个特性简化


// 传统
func logIfTrue(_ predicate: ( )-> Bool){
    if predicate() {
        print("True")
    }
}

logIfTrue({ return 2 > 1 })

//or

logIfTrue({ 2 > 1})

//or

logIfTrue{ 2 > 1 }


//@autoclosure

func logIfTrue2(_ prediacate: @autoclosure () -> Bool){
    if prediacate() {
        print("True2")
    }
}

logIfTrue2(2 > 1)


// MARK: ?? 对nil进行条件判定

var level: Int?
var startLevel = 1

var currentLevel = level ?? startLevel


/// 模拟实现
func ??<T>(optional: T?,defaultValue: @autoclosure () -> T) -> T {
    switch optional {
        case .some(let value)://如果存在值，则不进行defaultValue的计算(比如获取某些值 需要大量计算获得 避免了资源浪费)
            return value
        case .none:
            return defaultValue()
        }

}


// && 类似下面这个实现  || 同理
//func test_and<T: BooleanLiteralType>(lhs: T,@autoclosure rhs: () throws -> Bool) rethrows -> Bool {
//
//    if lhs {
//        return true
//    }
//
//    var error: NSError
//    var result: Bool?
//
//    do {
//        result = try rhs()
//    } catch let error1 as NSError {
//        error = error1
//        print("\(error.userInfo)")
//    }
//    return result!
//}


