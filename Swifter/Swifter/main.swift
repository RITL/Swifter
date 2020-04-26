//
//  main.swift
//  Swifter
//
//  Created by YueWen on 2018/7/16.
//  Copyright © 2018年 YueWen. All rights reserved.
//

import Foundation


//MARK: 11

//var arr1 = [1,2,3,4,5]
//let subarr1 = arr1[[0,2,3]]
//
//arr1[[0,2,3]] = [-1,-3,-4]
//
//print("\(arr1)")

//let sequece = "hello".map{ ($0,1) }

//uniquingKeysWith

//print(sequece)
//let d = Dictionary(sequece, uniquingKeysWith: { (value1, value2) -> Int in
//    print("value1 = \(value1),value2 = \(value2)")
//    return value1 + value2
//})

//print("d = \(d)")

//
//Dictionary("hello".map {($0,1)}), { (value1, value2) -> _ in
//
//    print("value1 = \(value1),value2 = \(value2)")
//
//    return value1
//}


//protocol MyProtocol {
//    func test()
//}
//
//
//extension MyProtocol {
//     func test() {
//        print("test in MyProtocol extension")
//    }
//}
//
//
//class MyClass {
//
//}
//
//extension MyClass: MyProtocol {
//
//    @objc func test() {
//        print("test in MyClass extension")
//    }
//}
//
//class MyClass1 : MyClass {
//
//    override func test() {
//        print("test in Myclass1")
//    }
//}
//
//func model(type: Int) -> MyClass {
//
//    if type == 1 {
//        return MyClass()
//    }
//
//    return MyClass1()
//}
//
//let model1 = model(type: 1)
//let model2 = model(type: 2)
//model1.test()
//model2.test()
//

//var num = 0
//DispatchQueue.global().async {
//    for _ in 1...10000 {
//        num += 1
//    }
//}
//
//for _ in 1...10000 {
//    num += 1
//}
//
//print(num)


//var hight = DispatchQueue.global(qos: .userInitiated)
//var low = DispatchQueue.global(qos: .utility)
//
//low.async {
//    for i in 0...10 {
//        print(i)
//    }
//}
//
//hight.async {
//    for i in 100...110 {
//        print(i)
//    }
//}
//
//DispatchSemaphore(value: 1)
//

//let multiTasks = BlockOperation()
//
//multiTasks.completionBlock = {
//    print("所有任务完成")
//}
//
//multiTasks.addExecutionBlock {
//    print("任务1");sleep(1)
//}
//
//multiTasks.addExecutionBlock {
//    print("任务2");sleep(2)
//}
//
//multiTasks.addExecutionBlock {
//    print("任务3");sleep(3)
//}
//
//multiTasks.start()
//
//@objcMembers class A: NSObject {
//
//}

fileprivate extension String {
    
    
    /// subString
    /// - Parameters:
    ///   - start: 开始的位置
    ///   - maxEnd: 最大的结束位置,如果不足，取中间的最大字符串
    /// - Returns: 如果
    func metroSubString(start: Int, maxEnd: Int) -> String {
        // 开始的位数大于最大长度
        guard start < count else { return "" }
        // 截取字符串
        return (self as NSString).substring(with: NSRange(location: start, length: min(count - 1, maxEnd)))
    }
}



