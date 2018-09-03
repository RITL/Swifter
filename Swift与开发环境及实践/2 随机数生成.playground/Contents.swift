//: Playground - noun: a place where people can play

import UIKit

/*
 随机数生成一直是程序员要面临的大问题之一
 在高中电脑课堂上就知道，由 CPU 时钟，进程和线程所构建出的世界中
 是没有真正的随机的
 
 在给定一个随机种子后，使用某些神奇的算法我们可以得到一组伪随机的序列
 */

/*
 arc4random 是一个非常优秀的随机数算法
 并且在 Swift 中也可以使用
 它会返回给我们一个任意证书
 我们想要在某个范围内的数的话，可以做模运算(%)取余数就行了
 
 但是有个陷阱，下面是错误的代码
 */

let diceFaceCount0 = 6
let randomRoll0 = Int(arc4random()) % diceFaceCount0 + 1
print(randomRoll0)

/*
 其实在 iPhone 5s 上完全没有问题，但是在 iPhone5 或者以下的设备中
 有时候 程序会崩溃，随机哦
 */

/*
 最让程序员郁闷的事情就莫过于有的时候会崩溃有时候又能良好运行。
 还好这里的情况比较简单，聪明的我们马上就能指出原因
 
 其实 Swift 的 Int 是和 CPU 架构有关的:
 在 32位的 CPU 上(也就是 iPhone 5 和前任们)，实际上他是 Int32
 而在 64为 CPU (iPhone5s 及 以后的机型)上是 Int64
 
 arc4random 所返回的值不管在什么平台上都是一个 UInt32
 于是在 32 位的平台上就有一半几率在进行 Int 转换时越界
 时不时的崩溃也就不足为奇了
 */

// 这种情况下，一种相对安全的做法是使用一个 arc4random 的改良版本:
//func acr4random_uniform(_ : UInt32) -> UInt32 

/*
 这个改良版本接收一个 UInt32 的数字 n 作为输入，将结果归一化到 0 到 n-1 之间
 只要我们的输入不超过 Int 的范围，就可以避免危险的转换:
 */
let diceFaceCount: UInt32 = 6
let randomRoll = Int(arc4random_uniform(diceFaceCount)) + 1
print(randomRoll)

/*
 最佳实践当然是为创建一个 Range 的随机数的方法
 这样我们就能在之后很容易的复用
 甚至设计类似与 Randomable 这样的协议了：
 */

func random(in range: Range<Int>) -> Int {
    let count = UInt32(range.upperBound - range.lowerBound)
    return Int(arc4random_uniform(count)) + range.upperBound
}

print("\n\n")
for _ in 0...2 {
    let range = Range<Int>(1...6)
    print(random(in: range))
}
