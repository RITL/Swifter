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


protocol MyProtocol {
    func test()
}


extension MyProtocol {

}


class MyClass {
    init() {

    }
}

extension MyProtocol {
    
}

//extension NSObject {
//     @objc dynamic func test() {
//        print("test in extension")
//    }
//}
//
//extension MyClass {
//
//    @objc dynamic func test() {
//        print("test in extension")
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
//
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
//
//let a = model(type: 1)
//print(a.self)
//a.test()
////let type = type(of: a)
//let D = (NSClassFromString("Swiftter.MyClass1"))
////print("D = \(D)")
//let b = model(type: 2)
//b.test()
//
