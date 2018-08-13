//: Playground - noun: a place where people can play

// 不管在什么语言中，内存管理的内容都很重要

/*
 Swift 是自动管理内存的，也就是说，不再需要操心内存的申请和分配
 当我们通过初始化创建一个对象时，Swift 会替我们管理和分配内存
 
 而释放的原则遵循了自动引用计数(ARC)的规则:
 当一个对象没有引用的时候，其内存将会被自动回收
 
 这套机制从很大程度上简化了我们的编码，只需要保证在合适的时候将引用置空(比如超过作用域，或者手动置为 nil 等)，就可以保证内存使用不出现问题、
 
 但是，所有的自动引用计数机制都有一个从理论上无法绕过的限制，就是循环引用（retain cycle）的情况
 */


//MARK: 什么是引用循环

//Example: 假设有两个类 A 和 B，之中分别有一个存储属性持有对象:
import Foundation

class A: NSObject {
    let b: B
    
    override init() {
        b = B()
        super.init()
        b.a = self
    }
    
    deinit {
        print("A deinit")
    }
}

class B: NSObject {
    var a: A? = nil
    
    deinit {
        print("B deinit")
    }
}

/*
 在 A 的初始化方法中，生成了一个 B 的实例并将其存储在属性中
 然后又将 A 的 实例赋值b.a.
 这样 a.b 和 b.a 将在初始化的时候形成一个引用循环
 当有第三方调用初始化了 A， 然后即使即刻将其释放， A 和 B 两个类实例的 deinit 方法也不会被调用，说明他们并没有被释放
 */

var obj: A? = A()
obj = nil
// 内存没有被释放

/*
 即使 objc 不再持有 A 的这个对象， b 中的 b.a 依然引用着这个对象，导致她无法释放。
 而进一步， a 中也持有着 b, 导致 b 也无法释放。
 在将 obj 设为 nil之后，在代码里再也拿不到对于这个对象的引用了，所以除非是杀掉整个进程，已经无法将它释放了
 So sad.....
 */


//MARK: 在 Swift 里防止循环引用

/*
 为了防止这种人神共愤的悲剧发生，必须要给编译器一点提示，表明我们不希望他们相互持有
 一般习惯希望“被动”的一方不要去持有"主动"的一方
 在这里 b.a 里对 A 的实例的持有是由 A 的方法设定的
 在之后直接使用也是 A 的实例，因此认为 b 是被动的一方
 */

// 可以将上面的 class B 的声明改为：
class B1: NSObject {
    weak var a: A? = nil
    
    deinit {
        print("B deinit")
    }
}

/*
 在 var a 前面加上了weak，向编译器说明我们不希望持有 a
 这时，当 obj 指向 nil时，这个被释放的实例上对 b 的引用 a.b 也随着这次释放结束了作用于域，所以 b 的引用也将归零，得到释放
 */

// 添加了 weak 后的输出:
/*
    A deinit
    B deinit
 */


/*
 在 Swift 中除了 weak 以外，还有另一种冲着编译器叫喊着类似的 ”不要引用我“的标识符，那就是 unowned
 
 他们的区别:
 如果一直是写 ObjC 过来的，那么从表面的行为来说 unowned 更像以前的 unsafe_unretained, 而 weak 就是以前的 weak
 
 用通俗的话说，就是 unowned 设置以后即使他原来引用的内容已经被释放了，他仍然会保持对已经释放了的对象一个”无效的“引用，他不能是 Optional 值，也不会被指向 nil
 如果尝试调用这个引用的方法或者访问成员属性的话,程序就会崩溃
 
 而 weak 则友好一些，在引用的内容被释放后，标记为 weak 的成员将会自动地变成 nil（因此标记为 @weak 的变量一定需要的是 Optional值）
 
 关于两者使用的选择，Apple 给我们的建议是如果能够确定在访问是不会已被释放的话，尽量使用unowned，如果存在被释放的可能，那就选择用 weak
 */


// 结合实际编码中的使用来看看选择。
// 日常工作中一般使用弱引用的最常见的场景有两个:
// 1、设置 delegate 时
// 2、在 self 属性存储为闭包时，其中拥有对 self 引用时

/*
 前者是 Cocoa 框架的常见设计模式，比如有一个负责网络请求的类，实现了发送请求以及接受请求结果的任务
 其中这个结果是通过实现请求类的 protocol 的方式来实现的，一般设置 delegate 为 weak
 */

@objc protocol RequestHandler {
    @objc func requestFinish()
}

class Request {
    weak var delegate: RequestHandler!
    
    func send() {
        //发送请求
        //一般来说会将req的引用传递给网络框架
    }
    
    func gotResponse(){
        //请求返回
        delegate?.requestFinish()
    }
}

class RequestManager: RequestHandler {
    
    @objc func requestFinish() {
        print("请求完成")
    }
    
    func sendRequest(){
        let req = Request()
        req.delegate = self
        
        req.send()
    }
}

/*
 req 中以 weak 的方式持有了 delegate，因为网络请求是一个异步请求，很可能会遇到用于不愿意等待而选择放弃的情况。
 这种情况下一般都会将 RequestManager 进行清理器，所以我们其实是无法保证在拿到返回时作为 delegate 的 RequestManager 对象是一定存在的。
 因此使用了 weak，而非 unowned，并在调用前进行了判断
 */



//MARK: 闭包和循环引用

/*
 另一种闭包的情况稍微复杂一些:
 闭包中对任何其他元素的引用都是会被闭包自动持有的
 如果在闭包中写了 self 这样的东西的话，那其实也就在比包内持有了当前的对象
 
 这里就出现了一个在实际开发中比较隐蔽的陷阱:
 如果当前的实例直接或者间接的对这个闭包又有引用的话，就形成了一个 self->闭包->self 的循环引用
 */

//Example:
class Person {
    let name: String
    lazy var printName: ()->() = {
        print("The name is \(self.name)")
    }
    
    init(personName: String) {
        name = personName
    }
    
    deinit {
        print("Person deinit\(self.name)")
    }
}

var xiaoMing: Person? = Person(personName: "Xiaoming")
xiaoMing!.printName()
xiaoMing = nil

// xiaoMing 没有被释放

/*
 printName 是 self 的属性，会被 self 持有，而它本身又在闭包内持有 self
 这导致了 xiaoMing 的 deinit 在自身超过作用域后还是没有被调用，也就是没有被释放
 为了解决这种闭包内的循环引用，需要在闭包开始的时候添加一个标注，来表示这个闭包内的某些要素应该以何种特定的方式来使用
 */

// 可以将printName修改为:
class Person1 {
    let name: String
    
    lazy var printName: ()->() = {
        [weak self] in
        if let strongSelf = self {
             print("The name is \(strongSelf.name)")
        }
    }
    
    init(personName: String) {
        name = personName
    }
    
    deinit {
        print("Person deinit\(self.name)")
    }
}

// 这样内存释放就正确了

/*
 如果可以确定整个过程中 self 不会被释放的话，可以将上面的 weak 改为 unowned
 这样就不再需要 strongSelf 的判断
 但是如果在过程中 self 被释放了而printName这个闭包没有释放的话（比如生成 Person 后，某个外部变量持有了 printName，随后这个 Person 对象被释放了，但是printName已然存在并可能被调用）
 使用 unowned 将造成崩溃
 所以还是根据实际的需求来决定时使用 weak 还是  unowned
 */

// 这种闭包参数的位置进行标注的语法结构是将要标注的内容放在原来参数的前面，并使用中括号括起来。
// 如果有多个需要标注的元素的话，在同一个中括号内用逗号隔开:

/*

// 标注前
{ (number: Int) -> Bool in
    
    //...
    
    return true
}

//标注后
{ [unowned self, weak someObject](number: Int) -> Bool in
    
        return true
}
 
 */




