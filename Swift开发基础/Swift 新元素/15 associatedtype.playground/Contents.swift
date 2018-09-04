//: Playground - noun: a place where people can play

import UIKit

//Swift 协议中可以定义属性和方法，并要求满足这个协议的类型实现他们

protocol Food { }
struct Meat: Food { }
struct Grass: Food { }



protocol Animal_0 {
    func eat(_ food: Food)
}


//定义一个food协议和Animal协议，在Animal中有一个接收Food的eat:方法。
//当尝试创建一个具体的类型实现Animal协议时，必须实现这个方法

struct Tiger_0: Animal_0 {
    func eat(_ food: Food) {

    }
}

// 因为老虎不吃素，所以Tiger的eat中，我们很可能需要进行一些转换工作才能使用meat:

struct Tiger_1: Animal_0 {
    func eat(_ food: Food) {

        if let meat = food as? Meat {
            print("eat \(meat)")
        }else {
            fatalError("Tiger can only eat meat!")
        }

    }
}

let meat = Meat()
Tiger_1().eat(meat) //工作量交给了运行时，并且多余的转换没有意义

//如下代码是错误的:
// Meat实际上和协议中要求的Food并不能等价。

//struct Tiger: Animal {
//    func eat(_ food: Meat) {
//        print("eat \(food)")
//    }
//}

// 在协议中除了定义属性和方法外，还能定义类型的占位符，让实现协议的类型来置顶具体的类型。
// 使用 associatedtype 我们就可以在 Animal 协议中添加一个限定，让Tiger来指定食物的具体类型

protocol Animal_1 {
    associatedtype F
    func eat(_ food: F)
}


struct Tiger_2: Animal_1 {
    typealias F = Meat

    func eat(_ food: Meat) {
        print("eat \(meat)")
    }
}

// 在Tiger通过typealias具体指定F 为Meat之前，Animal协议中并不关系F的具体类型,只需要满足协议类型中的F和eat参数一致即可。
// 如此依赖，可以避免在Tiger的eat中进行判定和转换了。
// 这里忽略了被吃的必须是Food这个前提

// associatetype声明中可以使用冒号来指定类型满足某个协议
// 另外在Tiger中只要实现了正确类型的eat,F的类型就可以被推断出来，所以也不需要显式的声明F

protocol Animal {
    associatedtype F: Food
    func eat(_ food: F)
}

struct Tiger: Animal {

    func eat(_ food: Meat) {
        print("eat \(food)")
    }
}

struct Sheep: Animal {
    func eat(_ food: Grass) {
         print("eat \(food)")
    }
}

// 但是在添加associatedtype后，Animal协议就不能被当成独立的类型使用了。

//? 有一个函数来判断某个动物是否危险

//// Wrong!
//func isDangerous(animal: Animal) -> Bool {
//    if animal is Tiger {
//        return true
//    }else {
//        return false
//    }
//}

// protocol 'Animal' can only be used as a general constraint because it has Self or assicated type requirements

// 因为Swift需要在编译时确定所有类型，这里Animal包含了一个不确定的类型。所以随着Animal本身类型的变化，其中F将无法确定。(如果函数内部调用eat的情形，你将无法置顶eat参数的类型)
// 在协议加入了像是associatedtype 或者 Self的约束后，它将只能被用为泛型约束，而不能作为独立类型的占位使用，也失去了动态派发的特性

func isDangerous<T: Animal>(animal: T) -> Bool {
    if animal is Tiger {
        return true
    }else {
        return false
    }
}

