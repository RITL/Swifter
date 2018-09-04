//: Playground - noun: a place where people can play

import UIKit

//MARK:  柯里化(Currying)


// add
func addOne(num: Int) -> Int {
    return num + 1
}

// 柯里化的add
func addTo(_ adder: Int) -> (Int) -> Int {
    
    return { num in
        return num + adder
    }
}

let addTwo = addTo(2)
let result = addTwo(6)


/// 比较大小
func greaterThan(_ comparer: Int) -> (Int) -> Bool {
    return { $0 > comparer }
}

let greaterThan10 = greaterThan(10)//大于10
let _ = greaterThan10(13)
let _ = greaterThan10(9)

/// 柯里化是一种量产相似方法的好办法，可以通过柯里化一个方法模板来避免写出很多重复代码，也方便了今后的维护。


/// 使用柯里化安全改造并利用target-action

protocol TargetAction {
    
    /// 执行Selector
    func performAction()
}


struct TargetActionWrapper <T: AnyObject> : TargetAction {
    
    weak var target: T?//调用方法
    let action: (T) -> () -> ()//执行
    
    func performAction() {
        if let t = target {
            action(t)()
        }
    }
}

enum ControlEvent {
    
    case TouchUpInside
    case ValueChanged
}


class Control {
    var actions = [ControlEvent : TargetAction]()
    
    func setTarget<T: AnyObject>(target: T,action:@escaping(T)->() ->(),controlEvent: ControlEvent){
        actions[controlEvent] = TargetActionWrapper(target: target, action: action)
    }
    
    
    func removeTargetForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent] = nil
    }
    
    func performActionForControlEvent(controlEvent: ControlEvent){
        actions[controlEvent]?.performAction()
    }
}


let r:Range = 1..<3


