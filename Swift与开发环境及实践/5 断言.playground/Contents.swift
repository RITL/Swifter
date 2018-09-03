//: Playground - noun: a place where people can play

/*
 断言(Assertion)在 Cocoa 开发里一般用来检查输入参数是否满足一定条件
 并对其进行“论断”
 
 这是一个编码世界中的哲学问题，代码的使用者很难做到在不知道实现细节的情况下去对自己的输入进行限制。
 大多数时候编译器可以帮助我们进行输入类型的检查
 但是如果代码需要在特定的输入条件下才能正确运行的话
 这种更细致的条件就难以控制了
 
 在超过边界条件的输入的情况下
 我们的代码可能无法正确工作，这就需要我们在代码实现中进行一些额外的工作
 */

/*
 一种容易想到的做法是在方法内部使用 if 这样的条件控制来检测输入
 如果遇到无法继续的情况，就提前返回或者抛出错误
 
 但是这样的做法无疑增加了 API 使用的复杂度
 也导致了很多运行时的额外开销
 
 对于像判定输入是否满足各种条件的运用情景
 我们有更好的选择，那就是断言
 */

/*
 Swift 为我们提供了一系列 assert 方法来使用断言，其中最常用的一个是:
 
 public func assert(_ condition: @autoclosure () -> Bool, _ message: @autoclosure () -> String = default, file: StaticString = #file, line: UInt = #line)
 
 */

/*
 在使用时，最常见的情况是给定条件和一个简单的说明
 
 举一个在温度转换时候的例子
 想要把摄氏温度转为开尔文温度的时候
 因为绝对零度永远不能达到，所以不可能接受一个小于 -273.15摄氏度的温度作为输入:
 */

func convertToKelvin(_ celsius: Double) -> Double {
    let absoluteZeroInCelsius = -273.15
    assert(celsius > absoluteZeroInCelsius, "输入的摄氏温度不能低于绝对零度")
    return celsius - absoluteZeroInCelsius
}

let roomTemperature = convertToKelvin(27)
// roomTemperature = 300.15

let tooCold = convertToKelvin(-300)
// 运行时错误:
// assertion failed
// 输入的摄氏温度不能低于绝对零度 : file {YOUR_FILE_PATH}, line {LINE_NUMBER}

/*
 在遇到无法处理的输入时，运行会产生错误，保留堆栈，并抛出我们预设的信息，用来提醒调用这段代码的用户
 
 断言的另一个优点是它是一个开发时的特性
 只有在 Debug 编译的时候有效
 而在运行时是不被编译执行的
 因此断言并不会消耗运行时的性能
 
 这些特点使得断言成为面向程序员的在调试开发阶段非常合适的调试判断
 而在代码发布的时候，也不需要可以去将这些断言手动清理掉好，很方便
 
 虽然默认情况下只在 Release 的情况下断言才会被禁用
 但是有时候我们可能出于某些目的希望断言在调试开发时也暂时停止工作
 或者在发布版本中也继续有效
 
 我们可以通过显式的添加编译标记达到这个目的
 
 在对应 target 的 build Settings 中，在 Swift Compiler - Custom Flags 中的
 Other Swift Flags 中添加 -assert-config Debug 来强制启用断言
 或者 -assert-config Release 来强制禁用断言
 
 当然，除非有充足的理由，否则并不建议做这样的改动
 如果需要在 Release 发布时在无法继续时将程序强制终止的话，应该选择使用 fatalError.
 
 #####
 原来在 ObjC 中使用的断言函数 NSAssert 在 Swift 中已经被彻底移除
 和我们永远的说再见了。
 #####
 
 
 */

