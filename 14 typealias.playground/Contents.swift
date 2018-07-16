//: Playground - noun: a place where people can play

import UIKit

// 比如计算二维平面上的距离和位置的时候，一般使用Double来表示距离，用CGPoint来表示位置

func distance0(from point: CGPoint,to anotherPoint: CGPoint) -> Double {
    
    let dx = Double(anotherPoint.x - point.x)
    let dy = Double(anotherPoint.y - point.y)
    
    return sqrt(dx * dx + dy * dy)
}

let origin0: CGPoint = CGPoint(x: 0, y: 0)
let point0: CGPoint = CGPoint(x: 1, y: 1)

let d0: Double = distance0(from: origin0, to: point0)


//运行没问题，但是阅读与维护的时候总是觉得哪里不对

typealias Location = CGPoint
typealias Distance = Double

func distance(from location: Location,to anotherLocation: Location) -> Distance {
    
    let dx = Distance(anotherLocation.x - location.x)
    let dy = Distance(anotherLocation.y - location.y)
    
    return sqrt(dx * dx + dy * dy)
}



let origin: Location = Location(x: 0, y: 0)
let point: Location = Location(x: 1, y: 1)

let d: Distance = distance(from: origin, to: point)


// 设置到泛型时，情况就稍微不太一样了。
// 首先，typealias是单一的，也就是说你必须置顶将某个特定的类型通过typealias赋值为新名字，而不是将整个类型进行重命名

// Wrong!
class Person<T> {}
//typealias Worker = Person
//typealias Worker = Person<T>

//如果在别名中也引入泛型，是可以对应的
typealias Worker<T> = Person<T> // This is OK

// 当泛型类型确定性得到保证后，显然别名也是可以使用
typealias WorkId = String
typealias Worker1 = Person<WorkId>

// 如果某个类型同时实现多个协议组合时。
// 可以使用&符链接几个协议，然后给他们一个更符合上下文的名字，增强代码可读性
protocol Cat { }
protocol Dog { }
typealias Pat = Cat & Dog
