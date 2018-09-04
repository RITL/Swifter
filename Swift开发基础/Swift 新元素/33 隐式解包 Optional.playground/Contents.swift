//: Playground - noun: a place where people can play

// 相对于普通的 Optional 值，在 Swift 中还有一种特殊的 Optional,在对它的成员或者方法进行访问时，编译器会帮助我们自动进行解包，这就是 ImplicitlyUnwraooedOptional.

// 在声明的时候，可以通过在类型后面加上一个感叹号（!）这个语法糖来告诉编译器我们需要一个可以隐式解包的 Optional 值:

class MyClass {
    
    func foo(){
        
    }
    
}

var maybeObject: MyClass!

// 首先需要明确的是: 隐式解包的 Optional 本质上与普通的 Optional 值并没有任何不同，只是我们在对这类变量的成员或方法进行访问的时候，编译器会自动为我们在后面插入解包符号 ！

//Example: 对于一个隐式解包的下面的两种写法是等效的:
var maybeObject1: MyClass! = MyClass()
maybeObject1!.foo()
maybeObject1.foo()


// 如果maybeObject1 是 nil 的话那么这两种不加检查的写法的调用都会导致程序崩溃。
// 如果maybeObject1 是普通 Optional 的话，我们这只能使用第一种显式的感叹声的写法，这能提醒我们也许这里应该使用 if let 的Optional Binding的形式来处理
// 对于隐式解包来说，后一种写法看起来就好像我们操作的 maybeObject1 确实是 MyClass 类的实例，不需要对其检查就可以使用(当然实际上这不是真的)。

// 为什么一项以安全著称的Swift会存在隐式解包并可以写出让人误认为能直接访问的这种危险写法呢？

// 因为ObjC中Cocoa的所有的类型变量都可以指向nil,有一部分Cocoa的API中在参数或者返回时即使被声明为具体的类型，但是还是有可能在某些特定的情况下并没有被加以区别，因为ObjC里向nil发送消息并不会有什么不良影响。
// 在将Cocoa API从ObjC转为Swift的module声明的自动化工具里，是无法判定是否存在nil的可能的，因此也无法决定哪些类型应该是实际类型，而哪些类型应该声明为 Optional.

// 在这种自动化转换中，最简单粗暴的对应方式是全部转为Optional,然后让使用者通过Optional Binding来判断并使用。
// 虽然这是最安全的方式，但对于使用者来说是一件非常麻烦的事情，我猜不会有人喜欢每次用个API就在Optional和普通类型之间转来转去。
// 这时候，隐式解包的Optional就作为一个妥协方案出现了。
// 使用它隐式解包Optional的最大好处就是对于那些我们能确认的API来说，可以直接进行属性访问和方法的调用，就会很方便。
// 但是需要记住，隐式解包不意味着"这个变量不会是nil，你可以放心使用"这种暗示，只能说Swift通过这个特性给我们一种简便但是危险的使用方式罢了。

// 另外，在Apple的不断修改下，在Swift正式版本中，已经没有太多的隐式解包的API了。
// ObjC也加入了像是 nonnull 和 nullable 这样的修饰符，这样一来，那些真正有可能为nil的返回可以被明确定义为普通的Optional值，而那些不会是Optional的值，也根据情况转换为了确定的类型。
// 现在比较常见的隐式解包的Optional就只有使用Interface builder时建立的 IBOutlet了:

//import UIKit
//@IBOutlet weak var button: UIButton!

// 如果没有连接IB的话，对button的直接访问会导致应用崩溃，这样情况和错误在调试应用时是很容易被发现的问题。
// 在代码的其他部分，还是少用这样的隐式解包的Optional为好，很多时候多写一个Optional Binding 就可以规避掉不少应用崩溃的风险。







