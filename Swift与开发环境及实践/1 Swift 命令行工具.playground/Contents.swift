//: Playground - noun: a place where people can play

import UIKit

/*
 Swift 的 REPL (Read-Eval-Print Loop)环境可以让我们使用 Swift 进行简单的交互式编程
 也就是说每输入一句语句就立即执行和输出
 这在很多解释型的语言中是很常见的，非常适合用来对语言的特性进行学习
 
 要启动 REPL 环境，就要使用 Swift 的命令行工具
 它是以 xcrun 命令的参数形式存在的
 首先需要确认使用的 Xcode 版本是是否是 6.1 或者 以上
 如果不是的话，可以再 Xcode 设置里 Locations 中的 Command Line Tools 一项中进行选择
 然后就可以在命令行中输入 exrun swift 来启动 REPL 环境了
 */

/*
 要指出的是， REPL 环境只是表的像是即时的解释执行
 但是其实质上还是每次输入代码后进行编译在运行
 这就限制了我们不太可能在 REPL 环境中做很复杂的事情
 */


/*
 
Last login: Fri Aug 31 15:09:32 on ttys003
➜  ~ xcrun swift
Welcome to Apple Swift version 4.1.2 (swiftlang-902.0.54 clang-902.0.39.2). Type :help for assistance.
    1> let arr = [1,2,3,4,5]
arr: [Int] = 5 values {
    [0] = 1
    [1] = 2
    [2] = 3
    [3] = 4
    [4] = 5
}
2> let a1 = arr[2]
a1: Int = 3
 
*/

/*
 另一个用法是直接将一个 .swift 文件作为命令行工具的输入
 这样里面的代码也会被自动的编译和执行
 
 我们甚至还可以在 .swift 文件最上面加上命令行工具的路径
 然后将文件权限改为可执行
 之后就可以直接执行这个 .swift 文件了
 */

/*
 hello.swift 文件中:（放到了桌面）
 
 #!/usr/bin/env swift
 print("hello world")

 
 //进行运行
 ➜  desktop chmod 755 hello.swift
 ➜  desktop ./hello.swift
 hello world
 */

/*
 这些特性与其他的解释性语言表现的完全一样
 */

/*
 相对于直接用 swift 命令执行
 Swift 命令行工具的另一个常用的地方是直接脱离 Xcode 环境进行编译和生成可执行的二进制文件
 
 我们可以使用 swiftc 来进行编译:
 */

// MyClass.swift
class MyClass {
    let name = "Xiaoming"
    func hello(){
        print("Hello \(name)")
    }
}

// main.swift
let object = MyClass()
object.hello()

// 终端:
/*
➜  desktop swiftc MyClass.swift main.swift
➜  desktop ./main
Hello Xiaoming
 */

/*
 利用这个方法，就可以用 Swift 写出一些命令行的程序了
 
 最后说明一个 swift 命令行工具的使用案例是 生成汇编级别的代码
 有时候想要确认经过优化后的汇编代码实际上做了什么
 
 swiftc 提供了参数来生成 asm 级别的汇编代码:
 swiftc -O hello.swift -o hello.asm
 */

/*
 再结合像是 Hopper 这样的工具，就能够了解编译器具体做了什么工作。
 */

