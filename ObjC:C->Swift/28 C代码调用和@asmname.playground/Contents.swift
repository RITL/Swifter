//: Playground - noun: a place where people can play

import UIKit

/*
 如果导入了 Darwin 的 C 库的话，就可以在 Swift 中无缝地使用 Darwin 中定义的 C 函数了
 他们涵盖了绝大多数 C 标准库中的内容
 可以说程序设计提供了丰富的工具和基础
 
 导入 Darwin 十分简单，只需要加上 import Darwin 即可，
 但事实上， Foundation 框架又包含了 Darwin 的导入
 而我们在开发 app 时肯定会使用 UIKit 或者 Cocoa 这样的框架
 他们又导入了 Foundation ，因此在平时开发时并不需要特别做什么
 就可以使用这些标准的 C 函数了
 很让人开心的一件事情是 Swift 在导入时为我们将 Darwin 也进行了类型的自动转换对应
 比如对于 三角函数 的计算输入和返回都是 Swift 的 Double 类型，而非 C 的类型:
 */


// func sin(_ x: Double) -> Double

/*
 使用起来也很简单，因为这些函数都是定义在全局的，所以只需要直接调用就可以了:
 */
//sin(M_PI_2) //deprecated
sin(Double.pi / 2)

/*
 而对于第三方的 C 代码，Swift 也提供了协同使用的方法
 我们知道，SWift 中调用 ObjC 代码非常简单，只需要将合适的有文件暴露在 {product-module-name}-Bridging-Header.h 文件中就行了
 而如果我们想要调用非标准库的 C 代码的话
 可以遵循同样的方式，将 C 代码的头文件在桥接的头文件中进行导入:
 */

/*

// Test.h
int test(int a);
 
// Test.c
int test(int a){
    return a + 1;
}

//Module-Bridging-Header.h
#import "Test.h"

//File.swift
func testSwift(input: Int32){
    let result = test(input)
    print(result)
}

testSwift(1) // 2
 */

/*
 另外甚至还有一种不需要解除头文件和 Bridging-Header 来导入 C 函数的方法
 那就是使用 Swift 中的一个隐藏的符号 @asmname.
 
 @asmname 可以通过方法名字将某个 C 函数直接映射为 Swift 中的函数
 
 比如上面的例子，我们可以将 test.h 和 Module-Bridging-Header.h 都删掉
 然后将 swift 文件中改为下面这样，也是可以正常使用的
 */

// File.swift
// 将 C 的 test 方法映射为 Swift 的 c_test 方法

/* :

 ````
 
@asmname("test") func c_test(a: Int32) -> Int32

func testSwift(input: Int32){
    let result = test(input)
    print(result)
}

testSwift(input: 1) // 2
 
 ```
 
 */

/*
 这种导入在第三方 C 方法与系统库重名导致调用发生命名冲突时
 可以用来为其中之一的函数重新命名以解决问题
 当然也可以利用 Module 名字 + 方法名字的方式来解决这个问题
 */

/*
 除了作为非头文件方式的导入之外
 @asmname 还承担这和 @objc 的 “重命名 Swift 中类和方法名字”类似的任务
 这可以将 C 中不认可的 Swift 程序元素字符重命名为 ascii 码，以便在 C 中使用。
 */
