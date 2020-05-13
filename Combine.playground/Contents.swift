import UIKit
import Combine

var str = "Hello, playground"

/// PassthroughSubject
let publisher = PassthroughSubject<Int, Never>()

publisher.send(1)
publisher.send(2)
publisher.send(completion: .finished)

print("开始订阅啦")
publisher.sink(
    receiveCompletion: { (complete) in
    print(complete)
}) { (value) in
    print(value)
}

publisher.send(3)
publisher.send(completion: .finished)
/// result：
/// 开始订阅啦
/// finished


let publisher1 = CurrentValueSubject<Int, Never>(0)

publisher1.value = 1
publisher1.value = 2
publisher1.send(completion: .finished)

print("开始订阅")
publisher1.sink(
    receiveCompletion: { (completion) in
    print(completion)
}) { (value) in
    print(value)
}
/// result：
/// 开始订阅啦
/// finished


let publisher2 = CurrentValueSubject<Int, Never>(0)

print("开始订阅")
publisher2.sink(
    receiveCompletion: { (completion) in
    print(completion)
}) { (value) in
    print(value)
}
publisher2.value = 1
publisher2.value = 2
publisher2.send(3)
publisher2.send(completion: .finished)
print("--- \(publisher2.value) ---")

// result：
// 开始订阅
// 0
// 1
// 2
// 3
// finished
// --- 3 ---
