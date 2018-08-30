//: Playground - noun: a place where people can play

import UIKit

/*
 虽然不太被重视，但是 类簇 确实是 Cocoa 框架中广泛使用的设计模式直译
 简单来说类簇就是使用一个统一的公共的类来定制单一的接口
 然后在表面之下对应若干个私有类进行实现的方式
 
 这么做的最大的好处是避免的公开很多子类造成混乱
 一个最典型的例子是 NSNumber:
 有一系列的不同的方法可以从整数，浮点数或者布尔值来生成一个 NSNumber 对象
 而实际上他们可能会是不同的私有子类对象:
 
 NSNumber *num1 = [[NSNumber alloc] initWithInt:1];
 // __NSCFNumber
 
 NSNumber *num2 = [[NSNumber alloc] initWithFloat: 1.0];
 // __NSCFNumber
 
 
 NSNumber *num3 = [[NSNumber alloc] initWithBool: true];
 // __NSCFBoolean
 */

/*
 类簇在子类种类繁多，但是行为相对统一的时候对于简化接口非常有帮助。
 
 在 ObjC 中，init开头的初始化方法虽然打着初始化的名号
 但是实际做的事情和其他方法并没有太多的不同之处
 
 类簇在 ObjC 中实现起来也很自然，在所谓的“初始化方法”中将 self 进行替换
 根据调用的方式或者输入的类型，返回合适的私有子类对象就可以了
 
 但是 Swift 中的情况有所不同
 因为 Swift 拥有真正的初始化方法，在初始化的时候我们只能看到当前类的实例，并且要完成所有的配置
 也就是对于一个公共类来说，是不可能在初始化方法汇总返回其子类的信息的
 
 对于 Swift 中的类簇构建，
 */

/*:
 # 一种有效的方法是使用工厂方法来进行：
 例如下面的代码通过 Drinking 的工厂方法将可乐和啤酒两个私有类进行了类簇化:
 */

protocol Say {
    func say()
}

extension Say {
    func say() { print("Say1") }
}


class Drinking {
    typealias LiquidColor = UIColor
    var color: LiquidColor {
        return .clear
    }
    
    class func drinking(name: String) -> Drinking {
        var drinking: Drinking
        switch name {
        case "Coke": drinking = Coke()
        case "Beer": drinking = Beer()
        default: drinking = Drinking()
        }
        return drinking
    }
    
    func say() {
        print("Drinking1")
    }
}

extension Drinking : Say {}

class Coke: Drinking {
    override var color: Drinking.LiquidColor {
        return .black
    }
    
    override func say() {
        print("Coke1")
    }
}

class Beer: Drinking {
    override var color: Drinking.LiquidColor {
        return .yellow
    }
    
    override func say() {
        print("Beer1")
    }
}

let coke = Drinking.drinking(name: "Coke")
coke.color
coke.say()

let beer = Drinking.drinking(name: "Beer")
beer.color
beer.say()

/*:
 # 通过 获取对象类型 中提到的方法，可以确认 coke 和  beer 各自的动态类型非别是 Coke 和 Beer
 */

let cokeClass = NSStringFromClass(type(of: coke))
let beerClass = NSStringFromClass(type(of: beer))
