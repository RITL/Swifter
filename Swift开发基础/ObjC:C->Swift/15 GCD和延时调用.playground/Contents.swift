//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

/*
 GCD 是一种非常方便的使用多线程的方式
 
 通过使用 GCD，可以在确保尽量简单的语法的前提下进行灵活的多线程变成
 在 ‘复杂必死’的多线程编程中，保持简单就是避免错误的金科玉律。
 
 在 Swift 中是可以无缝使用 GCD 的 API的，而且得益于闭包特性的加入，使用起来比 ObjC 中更加简单方便。
 
 Swift3 中更是抛弃了传统的基于 C 的 GCD API
 采用了更为吸纳进的书写方式。

 */

// Example:

// 创建目标队列
let workingQueue = DispatchQueue(label: "my_queue")

// 派发到刚创建的队列中， GCD 会负责进行线程调度
workingQueue.async {
    print("努力工作")
    Thread.sleep(forTimeInterval: 2) // 模拟两秒的执行时间
    
    DispatchQueue.main.async {
        // 返回主线程更新 UI
        print("结束工作，更新UI")
    }
}


/*:
 因为 UIKit 是只能在主线程工作的
 
 如果在主线程进行繁重的工作的话，就会导致 app 出现 ‘卡死’的现象:
 UI 不能更新，用户输入无法响应等等，是非常糟糕的用户体验
 
 为了避免这种情况的出现，对于繁重(如图像加滤镜等)或会很长时间才能完成的(如从网络下载图片)处理
 我们应该把它们放到后台线程进行，这样在用户看来UI还是可以交互的，也不会出现卡顿
 
 在工作进行完成后，需要更新 UI 的话，必须回到主线程进行
 */


/*
 日常的开发工作中，经常会遇到这样的需求:
 在xx秒后执行某个方法。
 
 比如切换界面 2秒后开始播一段动画，或者提示框出现 3秒后自动消失等等
 
 在以前的 ObjC 中，可以使用一个 NSObject 的实例方法
 - performSelector:withObject:afterDelay:
 来指定若干时间后执行某个 selector
 
 在 Swift2.0 之前，如果新建一个 Swift 的项目
 并且视图使用这个方法的话，会发现这个方法并不存在
 
 虽然 Swift2 中虽然这一系列 performSelector 的方法被加回了标准库
 但是由于 Swift 中创建一个 selector 并不是一件安全的事情(需要通过字符串来创建，这在之后代码改动时会很危险)
 所以最好尽可能的话避免使用这个方法。
 
 另外，原来的 performSelector: 这套东西在 ARC 下并不是安全的
 ARC 为了确保参数在方法运行期间的存在，在无法准确确定参数内存情况的时候
 会将输入参数在方法开始时先进行 retain,然后 release
 
 而对于 performSelector: 这个方法并没有机会被调用的方法指定参数
 于是被调用的 selector 的输入有可能会是指向位置的垃圾内存地址
 然后...HOHO,要命的是这种崩溃还不能每次重现，No 调试 ^_^
 */

/*
 但是如果不论如何，都还想继续做延时调用的话:
 最容易想到的是使用 Timer 来创建一个若干秒后调用一次的计时器
 
 但是这么做需要创建新的对象，和一个本来并不相干的 Timer 扯上关系
 同时也会用到 ObjC 的运行时特性去查找方法等等
 总觉得有点笨重
 
 其实 GCD 里有一个很好用的延时调用 可以加以利用写出很漂亮的方法来
 那就是 asyncAfter
 */

let time: TimeInterval = 2.0
DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
    print("2s 后输出")
}

/*
 代码非常简单，并没有什么值得详细说明的
 只是每次写这么多的话也挺累的，在这里可以稍微将他封装的好用一些，最好再加上取消的功能。
 
 在 iOS 8 中 GCD 得到了惊人的进化，现在可以通过一个闭包封装到 DispatcthWorkItem 对象中，
 然后对其发送 cancel，来取消一个正在等到执行的 block
 
 取消一个任务这样的特性，这在以前是 NSOperation 的专利，但是现在使用 GCD 也能达到同样的目的了。
 
 这里不使用这个方法，而是通过捕获一个 cancel 标识变量来实现 delay call 的取消
 整个封装也去有点长
 
 */

// 想在 2秒 以后干点什么:
delay(2) { print("2秒后输出") }

// 想要取消的话，可以先保留一个 Task 的引用，然后调用 cancel:

let task = delay(5){ print("拨打110") }

// 仔细想一想
// 还是取消为妙
cancel(task)
