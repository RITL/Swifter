//: Playground - noun: a place where people can play

import UIKit

// Swift 的 for...in 可以用在所有实现了 Sequence 的类型上
// 首先实现 InteratorProtocol
// 实现反向的 iterator 和 sequence



//let index = 1
let arr = [0,1,2,3,4]

//print("111")


for i in ReverseSequence(array: arr) {
    print("Index \(i) is \(arr[i])")
}


let map = ReverseSequence(array: arr).map { $0 + 1 }


