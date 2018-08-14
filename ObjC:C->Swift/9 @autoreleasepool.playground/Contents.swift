//: Playground - noun: a place where people can play

/*
 Swift 在内存管理上使用的是自动引用计数(ARC)的一套方法
 在ARC中虽然不需要手动的调用像是 retain， release 或者是 autorelease 这样的方法来管理引用计数
 但是这些方法还是都会被调用--只不过是编译器在编译时在合适的地方帮我们加入了而已。
 
 其中 retain 和 release 都很直接，就是将对象的引用计数加一或者减一。
 但是 autorelease 就比较特殊一些，他会将接受该消息的对象放到一个预先建立的自动释放池(auto release pool)中。
 并在 自动释放池收到 drain 消失时将这些对象的引用计数器减一
 然后将他们从池子中一移除(这一过程形象的成为"抽干尺子")
 */

/*
 在 app 中，整个主线程其实是跑在一个自动释放池里的，
 消息时将这些对象 并且在这个主 Runloop 结束时进行 drain 操作。
 这是一种必要的延迟释放的方式，因为有时候需要确保在方法内部初始化的生成的对象在被返回后别人还能使用，而不是立即被释放掉。
 */

/*
 在 ObjC 中，建立一个自动释放池的语法很简单，使用 @autoreleasepool就行了。
 如果新建一个 ObjC 项目，可以看到 main.m 中就有刚才说到的整个项目的 autoreleasepool：
 */

/*
 int main(int argc, char * argv[]){
    @autoreleasepool {
        int retVal = UIApplicationMain(
            argc,
            argv,
            nil,
            NSStringFromClass([AppDelegate class]);
 
        return retVal;
    }
 }
 */


// 更进一步，其实 @autoreleasepool 在编译时会被展开为 NSAutoreleasePool，并附带 drain 方法的调用


/*
 而在 Swift 项目中，因为有了 @UIApplicationMain，不在需要 main 文件和 main 函数
 所以原来的整个程序的自动释放池就不存在了。
 即使我们使用 main.Swift 来作为程序入口是，也是不需要自己再添加自动释放池的。
 */


/*
 但是在一种情况下还是希望自动释放，那就是在对面一个方法作用于中要生成大量的 autorelease 对象的时候。
 */

// Swift1.0
/*
import Foundation

func loadBigData() {
    if let path = Bundle.main.path(forResource: "big", ofType: "jpg")
    
    for i in 1...10000 {
        let data = NSData.dataWithContentsOfFile(path,options: nil,error: nil)
        NSThread.sleepForTimeInterval(0.5)
    }
}
 */

// dataWithContentOfFile 返回的是 autorelease 的对象，因为一直处在循环中，因此他们将一直没有机会释放
// 如果数量太大而且数据太大的时候，很容易因为内存不足而崩溃

/*
 面对这种情况的时候，正确的处理方法是在其中加入一个自动释放池
 这样就可以在循环进行到某个特定的时候释放内存
 保证不会因为内存不足而导致应用崩溃
 在 Swift 中我们也是能使用 autoreleasepool 的，虽然语法上略有不同
 相比于原来在 ObjC 的关键字，现在他变成了一个接受闭包的方法:
 
 func autoreleasepool(code: () -> ())
 */

// 利用尾随闭包的写法，很容易就能在 Swift 中加入一个类似的自动释放池:

import Foundation

func loadBigData () {
    if let path = Bundle.main.path(forResource: "big", ofType: "jpg") {
        
        for _ in 1...10000 {
            autoreleasepool {
                let _ = try? NSData(contentsOfFile: path, options: [])
                 Thread.sleep(forTimeInterval: 0.5)
            }
        }
    }
}
// 这样改动以后，内存分配就没有什么忧虑了

/*
 这里每一次循环都生成一个自动释放池，虽然可以保证内存使用达到最小
 但是释放过于频繁也会带来潜在的性能忧虑
 一个折中的办法是将循环分隔开加入自动释放池，比如
 每10次循环对应一次自动释放，这样能减少带来的性能损失
 */

/*
 其实对于这个特定的例子，并不一定需要加入自动释放
 在 Swift 中更提倡的使用初始化方法而不是像上面那样的类方法来生成对象
 并且从 Swift1.1 开始，因为加入了返回 nil 的初始化方法，像上面例子中的那样的工厂方法都已经从 API 中删除了
 
 使用初始化方法的haul，就不需要面临自动释放的问题了，每次在超过作用域后，自动内内存管理都将为我们处理好内存相关的事情
 */



