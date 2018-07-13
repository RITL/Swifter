import Foundation


/// Start
// 定义一个实现 IteratorProtocol 协议的类
// IteratorProtocol 需要指定一个 typealias Element
// 以及提供一个返回 Element? 的方法 next()

/*
 public protocol IteratorProtocol {
 
 /// The type of element traversed by the iterator.
 associatedtype Element
 public mutating func next() -> Self.Element?
 }
 */

/// 实现一个反向的iterator和sequence

public class ReverseIterator<T>: IteratorProtocol {

    public typealias Element = T

    var array: [Element]
    var currentIndex = 0

    /// 初始化方法
    public init(array: [Element]) {
        self.array = array
        currentIndex = array.count - 1//逆序
    }

    public func next() -> Element? {//便利的下一个，nil表示结束
        if currentIndex < 0 {
            return nil
        }
        else {
            let element = array[currentIndex]
            currentIndex -= 1
            return element
        }
    }
}
