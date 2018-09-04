//: Playground - noun: a place where people can play

/*
 无并发，不编码。
 
 而只要一说到多线程或者并发的代码，可能就很难绕开对于锁的研究
 简单来说，为了在不同线程中安全地访问同一个资源，我们需要这些访问顺序进行
 
 Cocoa 和 ObjC 中加锁的方式有很多，但是其中在日常开发中最常用到的应该是 @synchronized
 这个关键字可以用来修饰一个变量，并为其自动加上和解除互斥锁
 
 这样可以保证变量在作用范围内不会被其他线程改变
 */

// 举个例子，如果我们有一个方法接受参数，需要这个方法是线程安全的话，就需要在参数上加锁

/*
- (void)myMethod:(id)anObj {
    @synchronized(anObj){
        //在括号内持有 anObj 锁
    }
}
 */

/*
 如果没有锁的话，一旦 anObj 的内容被其他线程修改的话，这个方法的行为很可能就无法预测了。
 
 但是加锁和解锁都是要消耗一定性能的，因此我们不太可能为所有的方法都加上锁。
 另外其实在一个 app 中可能会涉及到多线程的部分是有限的，我们也没有必要为所有东西加上锁
 
 过多的锁不仅没有意义，而且对于多线程编程来说，可能会产生很多想死锁这样的陷阱，也难以调试
 因此在使用多线程时，我们应该尽量将保持简单作为第一要务
 */

/*
 虽然这个方法很简单好用，但是很不幸的是在 Swift 中它已经不存在了
 其实 @synchroized 在幕后做的事情是调用了 objc_sync 中的 objc_sync_enter 和 objc_sync_exit 方法
 并且加入了一些异常判断
 
 因此，在 Swift 中，如果忽略掉那些异常的话，想要一个 lock 一个变量的话，可以这样写:
 */
import UIKit
func myMethod1(anObj: AnyObject){
    objc_sync_enter(anObj)
    
    //在 enter 和 exit 之间持有 anObj 锁
    
    objc_sync_exit(anObj)
}

/*
 更进一步，如果喜欢以前的那种形式，甚至可以写一个全局的方法，并接受一个闭包
 来将 objc_sync_enter 和 objc_sync_exit 封装起来:
 */

func synchronized(_ lock: AnyObject, closure: () -> ()){
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}

// 再结合 Swift 的尾随闭包的语言特性，这样，使用起来就和 ObjC 很像了

func myMethodLocked(anObj: AnyObject){
    synchronized(anObj) {
        // 在括号内持有 anObj 锁
    }
}

// 举一个具体的例子，比如我们想要某个类实现一个线程安全的 setter，可以这样进行重写:

class Obj {
    var _str = ""
    var str: String {
        get {
            return _str
        }
        set {
            synchronized(self){
                _str = newValue
            }
        }
        // 下略
    }
}
