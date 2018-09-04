//: Playground - noun: a place where people can play

import UIKit

/*
 Options 或者在 ObjC 中的 NS_OPTIONS，在 Swift 中是怎样的形式
 
 在 ObjC 中，有很多需要提供某些选项的 API
 他们一般用来控制 API 的具体的行为配置等。
 */

// 举个例子，常用的 UIView 动画的 API 在使用时就可以进行选项置顶:
/*
 [UIView animateWithDuration:0.3
    delay:0.0
    options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{
 
    //...
 } completion:nil];
 
 */

/*
 我们可以使用 | 或者 & 这样的按位逻辑符对这些选项进行操作
 这是因为一般来说在 ObjC 中的 Options 的定义都是类似这样的按位错开的
 
 ```
 typedef NS_OPTIONS(NSUInteger, UIViewAnimationOptions) {
    UIViewAnimationOptionLayoutSubviews            = 1 <<  0,
    UIViewAnimationOptionAllowUserInteraction      = 1 <<  1,
    UIViewAnimationOptionBeginFromCurrentState     = 1 <<  2,

    //...
 
    UIViewAnimationOptionTransitionFlipFromBottom  = 7 << 20,
 }
 
 ```
 
 通过一个 typedef 的定义，可以使用 NS_OPTIONS 来把 UIViewAnimationOptions 映射为每一位都是不同的一组 NSUInteger
 不仅是这个动画的选项如此，其他的 Option 值也都遵循着相同的规范映射到整数上
 如果不需要特殊的什么选项的话，可以使用 kNilOptions 作为输入，他被定为数字 0:
 
 enum {
    kNilOptions = 0
 };
 */

/*
 在 Swift 中，对于原来的枚举类型 NS_ENUM 我们有新的 enum 类型来对应
 但是原来的 NS_OPTIONS 在 Swift 里显然没有枚举类型那样中套
 并没有直接的原生类型来进行定义
 原来的 Option 值现在被映射为了满足 OptionSetType 协议的 struct 类型
 以及一组静态的 get 属性：
 
 
 public struct UIViewAnimationOptions : OptionSet {
 
    public init(rawValue: UInt)
    public static var layoutSubviews: UIViewAnimationOptions { get }
    public static var allowUserInteraction: UIViewAnimationOptions { get }
    // ...
    public static var transitionFlipFromBottom: UIViewAnimationOptions { get }

 }
 */

/*
 这样一来，我们就可以用和原来类似的方法为方法置顶选项了
 用 Swift 重写上面的 UIView 动画的代码的话
 就可以使用这个新的 struct 的值
 在使用时，可以用生成集合的方法来置顶符合"或"逻辑多个选项:
 */

UIView.animate(withDuration: 0.3,
               delay: 0.0,
               options: [.curveEaseIn,.allowUserInteraction],
               animations: {},
               completion: nil)

/*
 OptionSetType 是实现了 SetAlgebraType的
 因此我们可以对两个集合进行各种集合运算，包括并集(union)、交集(intersect)等等
 另外，对于不需要选项输入的情况，也就是对应原来的 kNilOptions，现在我们直接使用一个空的集合表示
 */

UIView.animate(withDuration: 0.3,
               delay: 0.0,
               options: [],
               animations: {},
               completion: nil)

/*
 要实现一个 Options 的 struct 的话，可以参照已有的写法建立类并实现 OptionSetType
 因为基本上所有的 Options 都是很相似的，所以最好是准备一个 snippet 以快速重用
 */

struct YourOption: OptionSet {
    let rawValue: UInt
    static let none = YourOption(rawValue: 0)
    static let option1 = YourOption(rawValue: 1)
    static let option2 = YourOption(rawValue: 1 << 1)
    // ...
}


