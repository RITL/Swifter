//: Playground - noun: a place where people can play

/*
 哈希表 或者说 散列表 是程序世界中的一种基础数据结构
 鉴于有太多的各种教程和资料已经将这个问题翻来覆去讲了无数遍
 
 简单的说，需要为判等结果为相同的对象提供相同的哈希值
 以保证在被用作字典的 key 时的确定性和性能
 
 在这里，主要说说在 Swift 里对于哈希的作用。
 */

/*
 在判等中提到
 Swift 中对 NSObject 子类对象使用 == 时要是该子类没有实现这个操作符重载的话将回滚到 -isEqual: 方法
 
 对于哈希计算，Swift 也采用了类似的策略
 Swift 类型中提供了一个叫做 Hashable 的协议，实现这个协议即可为该类型提供哈希支持:
 
 protocol Hashable : Equatable {
    var hashValue: Int { get }
 }
 */

/*
 Swift 的原生 Dictionary 中，key 一定是要实现了的 Hashable 协议的类型。
 像 Int 或者 String 这些 Swift 基础类型，已经实现了这个协议，因此可以用来作为 key 来使用
 比如 Int 的 hashValue 就是它本身:
 */
let num = 10
print(num.hashValue)

let str = "hello"
print(str.hashValue)

/*
 对于 ObjC ,熟悉的人可能知道 NSObject 中有一个 -hash 方法
 当我们对一个 NSObject 的子类的 -isEqual: 进行重写的时候，一般也需要将 -hash 方法重写
 以提供一个判等为真时返回同样哈希值的方法
 
 在 Swift 中，NSObject 也默认实现了 Hashable ,而且和判等的时候情况类似
 NSObject 对象的 hashValue 属性的访问将返回其对应的 -hash 的值
 */

/*
 所以在重写哈希方法时候所采用的策略，与判等的时候类似:
 对于非 NSObject 的类，需要遵守 hashable 并根据 == 操作符的内容给出哈希算法
 而对于 NSObject 的子类，需要根据是否需要在 ObjC 中访问而选择合适的重写方式
 去实现 Hashable 的 hashValue 或者直接重写 NSObject 的 -hash方法
 */

/*
 就是说，在 ObjC 中，对于 NSObject 的子类来说，其实 NSDictionary 的安全性是通过人为来保证的
 对于那些重写了判等但是没有重写对应的哈希方法的子类
 编译器并不能给出实质性的帮助
 
 在 Swift 中，如果使用非 NSObject 的类型和原生的 Dictionary
 并试图将这个类型作为字典的 key 的话，编译器将直接抛出错误。
 从这方面来说，如果尽量使用 Swift 的话，安全性将得到大大增加
 */

/*
 关于哈希值，另一个特别需要提出的是
 除非正在开发一个哈希散列的数据结构，否则不应该直接依赖系统所实现的哈希值来做其他操作。
 首先哈希的定义是单向的
 对于相等的对象或值，可以期待它们拥有相同的哈希
 但是反过来并不一定成立
 
 其次某些对象的哈希值很可能随着系统环境或者时间的变化而改变
 因此不应该依赖于哈希值来构建一些需要确定对象唯一性的功能
 绝大部分情况下，将会得到错误的结果。
 */


