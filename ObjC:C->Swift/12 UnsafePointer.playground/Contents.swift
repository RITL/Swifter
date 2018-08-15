//: Playground - noun: a place where people can play

/*
 Swift 本身从设计上来说是一门非常安全的语言，在 Swift 的思想中，所有的引用或者变量的类型都是确定并且正确对应它们的实际类型的
 无法进行任意的类型转换，也不能直接通过指针做出一些出格的事情
 
 这种安全性在日常的程序开发中对于避免不必要的 bug, 以及迅速而且稳定的找出代码错误是非常有帮助的。
 但是凡事都有领面性，再高安全的同时，Swift 也相应的丧失了部分的灵活性。
 */

/*
 现阶段想要完全抛弃 C 的一套东西还是相当困难的，特别是在很多上古级别的 C API 框架还在使用(或者间接使用)
 开发者，尤其是偏向较底层的框架的开发者不得不面临着与 C API 打交道的时候，还是无法绕开指针的概念
 而指针在 Swift 中其实并不被鼓励，语言标准中也是完全没有与指针完全等同的概念的。
 
 为了与庞大的 C 系帝国进行合作， Swift 定义了一套对 C 语言指针的访问和转换方法
 那就是 UnsafePointer 和它的一些列变体。
 
 对于使用 C API 时如果遇到接受内存地址作为参数，或者返回是内存地址的情况
 在 Swift 里面会将他们转为 UnsafePointer<Type>的类型
 
 */

//Example:
/*
 void method(const int *num){
    printf("%d",*num);
 }
 */

// 对应 Swift 方法应该是:
func method(_ num: UnsafePointer<CInt>){
    print(num.pointee)
}

/*
 这个 tip 所说的 UnsafePointer，就是 Swift 中专门针对指针的转换。
 对于其他的 C 中基础类型，在 Swift 中对应的类型都遵循统一的命名规则:
 在前面加上一个字母 C 并将原来的第一个字母大写:
 比如 int, bool 和 char 的对应类型分别是 CInt, CBool 和 CChar.
 在上面的 C 方法中，我们接受一个 int 的指针，转换到 Swift 里所对应的就是一个 CInt 的 UnsafePointer 类型。
 
 这里原来的 C API中已经指明了输入的 num 指针的不可变的（const）
 因此在 Swift 中我们与之对应的是 UnsafePointer 这个不可变版本
 */

/*
 如果是一个普通的可变指针的话，我们可以使用 UnsafeMutablePointer 来对应:
 
 | C API | Swift API|
 |:----|:----|
 | const Type * |  UnsafePointer |
 | Type * |  UnsafeMutablePointer |
 */

/*
 在 C 中，对某个指针进行取值使用的是 *, 而在 Swift 中可以使用 memory 属性来读取响应内存的内容
 通过传入指针地址进行方法调用的时候就都比较相似了
 都是在前面加上 & 符号
 C 的版本和 Swift 的版本只在声明变量的时候有所区别:
 */

//C
//int a = 123;
//method(&a)

//Swift
var a: CInt = 123
method(&a)

/*
 遵守这些原则，使用 UnsafePointer 在 Swift 中进行 C API 的调用应该就不会有很大问题了。
 */

/*
 另外一个重要的课题是如何在指针的内容和实际值之间进行转换
 比如如果由于某种原因需要涉及到直接使用 CFArray 的方法来获取数组中元素的时候，会用到这个方法:
 
 func CFArrayGetValueAtIndex(theArray: CFArray!, idx: CGIndex) -> UnsafePointer<Void>
 
 因为 CFArray 中是可以存放在任意对象的，所以这里的返回是一个任意对象的指针
 相当于 C 中的 void*
 这显然不是我们想要的
 Swift 中为我们提供了一个强制转换的方法 unsafeBitCase
 
 通过下面的代码，可以看到应当如何使用类似这样的 API，将一个指针强制按位转成所需类型的对象:
 */
import Foundation
let arr = NSArray(object: "meow")
let str = unsafeBitCast(CFArrayGetValueAtIndex(arr, 0), to: CFString.self) //meow

/*
 unsafeBitCast 会将第一个参数的内容按照第二个参数的类型进行转换
 而不关系实际是不是可行，这也正是 UnsafePointer 的不安全所在
 因为不必遵守类型转换的检查，而拥有了在指针层面直接操作内存的机会
 */


/*
 Apple 将直接的指针访问冠以 Unsafe 的前缀，就是提醒我们:
 这些东西不安全，亲们能不用就不用了吧(Apple 另一个重要的原因是如果避免指针的话可以减少很多系统漏洞)
 
 在日常开发中，确实不太需要经常和这些东西打交道(除了传入NSError指针这个历史遗留问题以外，而且在 Swift 2.0 中也已经使用一场极致提到了 NSError)
 总之，尽可能地在高抽象层级编写代码，会是高效和正确的有力保证。
 
 无数先辈已经用血淋淋的教训告诉我们，要避免去做这样的不安全的操作
 除了确实知道在做什么
 */


