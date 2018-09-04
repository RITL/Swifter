//: Playground - noun: a place where people can play

import UIKit

// 交换值

// 亘古的交换值
func swapMel<T>(a: inout T,b: inout T){
    let temp = a
    a = b
    b = temp
}

// 使用多元组
func swapMe2<T>(a:inout T,b: inout T){
    (a,b) = (b,a)
}


//比如Objc
// 将{0,0,100,100}切割成两部分{0,0,20,100} {20,0,80,100}
// 通过传址方式模拟多值返回
//CGRect rect = CGRectMake(0,0,100,100)
//CGRect small;
//CGRect large;
//CGRectDivide(rect,&small,&large,20,CGRectMinXEdge)


extension CGRect {
    
    //
    func divided(atDistance: CGFloat,from fromEdge: CGRectEdge) -> (slice: CGRect, remainder: CGRect) {
        
        //....
        return self.divided(atDistance: atDistance, from: fromEdge)
    }
}

//使用
let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
let (small,large) = rect.divided(atDistance: 20, from: .minXEdge)

