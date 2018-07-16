//: Playground - noun: a place where people can play

import UIKit

// 在Swift中，Array 和 Dictionary 实现了下标读写

var arr = [1,2,3]
arr[2]      // 3
arr[2] = 4  // arr = [1,2,4]

print("\(arr.enumerated())")


var dic = ["cat":"meow","goat":"mie"]
dic["cat"]    // { Some "meow" }
dic["car"] = "miao" // dic = ["cat":"miao","goat":"mie"]

// 字典通过下标访问到的结果是 一个Optional的值


//subscript (index: Int) -> T //接收单个Int类型的需要，返回一个单一的元素
//subscript (subRange: Range<Int>) -> Slice<T> // 一个表明范围的 Range<Int>,一组对应输入返回的元素



// 需求:
// 很难一次性的去除某几个特定位置的元素
// 比如在一个数组内，想去除index为0，2，3的元素。
// 很可鞥我们就会要去枚举数组，然后在循环里判断是否使我们想要的位置。
// 实现一个接受数组标作为下不熬输入的读取方法

extension Array {
    subscript(input: [Int]) -> ArraySlice<Element>{
        get {
            var result = ArraySlice<Element>()
            for i in input {
                assert(i < self.count,"Index out of range")
                result.append(self[i])
            }
            return result
        }

        set {
            for (index,i) in input.enumerated() {
                assert(i < self.count,"index out of range")
                self[i] = newValue[index]
            }
        }
    }
}

var arr1 = [1,2,3,4,5]

//Playground就是报错 - - Swifter项目中可以

//let _ = arr1[[0,2,3]] // [1,3,4]
//arr1[[0,2,3]] = [-1,-3,-4] // [-1, 2, -3, -4, 5]

// 极力不推荐如此使用！！！

