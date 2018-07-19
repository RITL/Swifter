//: Playground - noun: a place where people can play

import UIKit

// 声明一个Swift的方法的时候，一般不去指定参数前面的修饰符，而是直接声明参数

func incrementor0(variable: Int) -> Int {
    return variable + 1
}

// 如果想对增加后的变量做点什么，又不想引入一个新的变量的话，很可能写出如下：

/********错误代码**********/

// 直接编译错误

//func incrementor1(variable: Int) -> Int {
//    variable += 1
//    print("\(variable)")
//    return variable
//}

/******************/

// Swift 是一门讨厌变化的语言。
// 在有可能的地方，都被默认认为是不可变的，都是用let进行声明的
// 这样不仅可以确保安全，也能在编译器的性能优化上更有作为。
// 在方法的参数上也是如此，不写修饰符的话，默认情况下所有的参数都是let的
// 上面的代码等效为:

//func incrementor2( variable: let Int) -> Int {
//    variable += 1
//    print("\(variable)")
//    return variable
//}

// 要想编译正确，改动如下:

// 在Swift2.2中可以在类型前可以追加修饰符，但Swift4.0(目前编译环境)下是不允许的，已经废弃了，只能做以下修改
func incrementor3(variable: Int) -> Int {
    var num = variable;
    num += 1
    return num
}

let number3 = incrementor3(variable: 3)

// 在函数内部直接修改值
func incrementor4(variable: inout Int)  {
    variable += 1
}

var number4 = 4;
incrementor4(variable: &number4)
print("\(number4)")


// Int 是一个值类型
// & 这种格式类似C中取地址的符号
// inout 相当于在函数内部创建了一个新的值，然后在函数返回时将这个值赋给&修饰的变量
// 这与引用类型的行为是不同的。




// 实现一个可以累加任意数字的 +N 器
func makeIncrementor(addNumber: Int) -> ((inout Int) -> ()) {
    func incrementor(variable: inout Int) -> () {
        variable += addNumber
    }
    return incrementor
}

let incrementor5 = makeIncrementor(addNumber: 5)
var number5 = 5
incrementor5(&number5)
print(number5)

// 外层的makeIncrementor 的返回里也需要在参数的类型前面明确指出修饰词(inout),以符合内部的定义
// 否则将无法编译通过

