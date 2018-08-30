//: Playground - noun: a place where people can play

import UIKit

/*
 在 ObjC 时代，通常使用 -isEqualToString: 来在已经确定比较对象和待比较对象都是NSString  的时候进行字符串判等等
 
 在 Swift 中的 String 类型中是没有 -isEqualToString: 或者 -isEqual: 这样的方法的，
 因为这些毕竟是 NSObject 的东西
 
 在 Swift 中字符串内容判等，可以简单的使用 == 操作来进行
 */

let str1 = "快乐的字符串"
let str2 = "快乐的字符串"
let str3 = "开心的字符串"

str1 == str2
str1 == str3

/*
 在判等上 Swift 的行为和 ObjC 有着巨大的差别
 在 ObjC 中 == 这个符号的意思是判断两个对象是否指向了同一块内存地址
 其实很多时候这并不是我们经常所期望的判等
 我们更关系的往往还是对象的内容相同
 而这种意义的相等即时两个对象引用的不是同一块内存地址时，也是可以做到的
 */

/*
 ObjC 中我们通常对 -isEqual: 进行重写 或者更进一步去实现类似 -isEqualToString: 这样的 -isEqualToClass:的带有类型信息的方法来进行内容判等
 
 如果我们没有在任意子类重写 -isEqual: 的话，就调用这个方法时会直接使用 NSObject 中的版本，去直接进行 ObjC 的 == 判断
 */

/*
 在 Swift 中情况大不一样，Swift 里的 == 是一个操作符的声明
 在 Equatable 里声明了这个操作符的协议方法
 
 ```
 protocol Equatable {
    func ==(lhs: Self, rhs: Self) -> Bool
 }
 ```
 
 实现这个协议的类型需要定义适合自己类型的 == 操作符
 如果我们认为两个输入有相等关系的话，就应该返回 true
 
 实现了 Equatable 的类型就可以使用 == 以及 != 操作符来进行判定了
 (在实现时只需要实现 ==，!= 的话由标准库自动取反实现)
 
 这和原来的 ObjC 的 isEqual: 的行为十分相似
 
 比如在一个待办事项应用中，从数据库中取得带有使用 uuid 进行编号的待办条目，在实践中一般考虑就使用这个 uuid 来判定两个条目对象是不是同一条目。

 让这个表示条目的 TodoItem 类实现 Equatable 协议:
 */

class TodoItem {
    let uuid: String
    var title: String
    
    init(uuid: String, title: String) {
        self.uuid = uuid
        self.title = title
    }
}

extension TodoItem: Equatable {
    
}

func == (lhs: TodoItem, rhs: TodoItem) -> Bool {
    return lhs.uuid == rhs.uuid
}

/*
 对于 == 的实现并没有像实现其他一些协议一样将其放在对应的 extension 里，而是放在了全局的 scope 中
 这是合理的做法，因为应该需要在全局范围内都能使用 ==
 事实上， Swift 的操作符都是全局的。
 */

/*
 Swift 的基本类型都重载了自己对应版本的 ==，而对于 NSObject 的子类来说
 如果使用 == 并且没有对于这个子类的重载的话，将是转为调用这个类的 -isEqual: 方法
 
 这样如果这个 NSObject 子类原来就实现了 -isEqual: 的话
 直接使用 == 并不会造成它和 Swift类型的行为差异
 
 但是如果无法找到合适的重写的话，这个方法就将回滚到最初的 NSObject 里的实现
 对引用对象地址进行直接比较。
 
 因此对于 NSObject  的子类的判等有两种选择
 要么重载 == ,要么重写 -isEqual:
 
 如果在 Swift 中使用自己的类的话，两种方式是等效的；
 但是如果还需要在 ObjC 中使用这个类的话，因为 ObjC 不接收操作符重载，只能使用 -isEqual:
 这时就应该考虑使用第二种方式
 */

/*
 对于原来 ObjC 中使用 == 进行的对象指针的判定
 在 Swift 中提供的是另一个操作符 ===
 
 在 Swift 中 === 只有一种重载:
 func ===(lhs: AnyObject?, rhs: AnyObject?) -> Bool
 
 它用来判断两个 AnyObject 是否是同一个引用
 */

/*
 对于判等，和它紧密相关的一个话题就是 哈希
 如果在实际项目中需要重载 == 或者重写 -isEqual: 来进行判等的话
 很可能也会想看有关哈希的内容，重载了判等的话
 还需要提供一个可靠地哈希算法使得判等的对象在字典中作为 key 时不会发生奇怪的事情。
 */
