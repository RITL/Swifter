//import Foundation
//
//
// 定义一个`Sequence`
// 和`IteratorProtocol` 类似，制定一个`typelias Iterator`
// 以及提供一个返回 Iterator? 的方法 makeIterator()
public struct ReverseSequence<T>: Sequence {
    var array: [T]

    public init(array: [T]) {
        self.array = array
    }

    public typealias Iterator = ReverseIterator<T>

    public func makeIterator() -> ReverseIterator<T> {
        return ReverseIterator(array: self.array)
    }
}
