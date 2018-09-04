//: Playground - noun: a place where people can play

import UIKit

var someArray = [1,2,3]
let unOh = someArray.withUnsafeBytes { (ptr)  in
    // ptr 只在这个 block 中有效
    // 不过完全可以将它返回给外部世界:
    return ptr
}

// 稍后
print(unOh[10])//不安全喽
// 代码可以编译，但是天知道它最后会做什么
// 方法名字里已经警告了这是不安全的，所以对此要自己负责啦。
