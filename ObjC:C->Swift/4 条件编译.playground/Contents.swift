//: Playground - noun: a place where people can play

// 在C系语言中，可以使用 #if 或者 #ifdef 之类的编译条件分值来控制哪些代码需要编译，而哪些代码不需要。
// Swift中没有宏定义的概念，因此不能使用 #ifdef 的方法来检查某个符号是否经过宏定义。
// 但是为了控制编译流程和内容，Swift还是为我们提供了几种简单的机制来根据需求定制编译内容的。

// 首先是 #if 这一套编译标记还是存在的，使用的语法也和原来没有区别:

#if /*<condition>*/ os(macOS)
#elseif /*<condition>*/ os(iOS)
#else
#endif

// 当然，#elseif 和 #else 是可选的

// 但是这里表达式里的condition并不是任意的。
// SWift内建了集中平台和架构的组合，来帮助我们为不同的平台偏移不同的代码
// 具体:

// os()   macOS,iOS,tvOS,watchOS,linux
// arch()  x86_64 arm arm64 i386
// swift  >=某个版本

// 这些方法和参数都是大小写敏感的。
// 举个例子，如果统一在iOS平台和Mac平台的关于颜色的API的话，一种方法就是配合 typealias 进行条件编译

#if os(macOS)
import AppKit
typealias Color = NSColor
#elseif os(iOS)
import UIKit
typealias Color = UIColor
#endif

// 虽然Swift现在只能在上面列出的平台上运行，但是 os() 的可选用参数还包括:
// FreeBSD Windows Android
// 也许在不久的将来就能够在这些平台上看到Swift的身影

// 另外对于 arch() 的参数需要说明的是 arm 和 arm64 两项分别对应 32位CPU 和 64位 CPU的真机情况
// 而对于模拟器，相应地32位设备的模拟器和64位设备的模拟器所对应的分别是 i385和x86_64,他们也是需要分开对待的

// 另一种方式就是对自定义的符号进行条件编译，比如我们需要使用同一个target完成同一个app的收费版和免费版两个版本，并且希望再点击某个按钮时收费版本执行功能，而免费版本弹出提示的话，可以使用类似下面的方法:

class TestView: UIView {
    
    @IBAction func someButtonPressed(sender: AnyObject){
        #if FREE_VERSION
        // 弹出购买提示，导航至商店等
        #else
        // 实际功能
        #endif
    }
}

// 在这里用FREE_VERSION这个编译符号来代表免费版本。
// 为了使之有效，需要在项目的编译选项中进行设置，在项目的Build Settings中，找到Swift Complier - Customm Flags,并在其中的Other Swift Flags 加上 -D FREE_VERSION 就可以了。


