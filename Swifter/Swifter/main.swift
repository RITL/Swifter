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

let sequece = "hello".map{ ($0,1) }

//uniquingKeysWith

print(sequece)
let d = Dictionary(sequece, uniquingKeysWith: { (value1, value2) -> Int in
    print("value1 = \(value1),value2 = \(value2)")
    return value1 + value2
})

print("d = \(d)")

//
//Dictionary("hello".map {($0,1)}), { (value1, value2) -> _ in
//
//    print("value1 = \(value1),value2 = \(value2)")
//
//    return value1
//}


protocol MyProtocol {
    func test()
}


extension MyProtocol {
     func test() {
        print("test in MyProtocol extension")
    }
}


class MyClass {

}

extension MyClass: MyProtocol {
    
    @objc func test() {
        print("test in MyClass extension")
    }
}

class MyClass1 : MyClass {
    
    override func test() {
        print("test in Myclass1")
    }
}

func model(type: Int) -> MyClass {

    if type == 1 {
        return MyClass()
    }

    return MyClass1()
}

let model1 = model(type: 1)
let model2 = model(type: 2)
model1.test()
model2.test()

