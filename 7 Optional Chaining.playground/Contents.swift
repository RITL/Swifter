//: Playground - noun: a place where people can play

import UIKit


// 使用 Optional Chaining 可以摆脱不必要的判断和取值 使用的时候需要小心陷阱
// Optional Chaining 是随时都有可能提前返回nil
// 使用Optional Chaining 所得到的东西都是 Optional的

class Toy {//玩具
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Pet {//宠物
    var toy: Toy?
}


class Child {//小孩
    var pet: Pet?
}


// 获得小明的宠物的玩具的名字，通过 Optional Chaining

let xiaoming = Child()
let toyName = xiaoming.pet?.toy?.name

// 虽然最后访问的是name,并且在Toy的定义中被定义为一个确定的String而非String?
// 但拿到的 toyName其实还是一个String?的类型
// 由于在Optional Chaining 中在任意一个?.的时候都可能遇到nil而提前返回

// Optional Binding
if let _ = xiaoming.pet?.toy?.name {
    //OK 太好了，小名有宠物，宠物也有一个玩家
}

//MARK: BUT!

extension Toy {
    func play() {
        //...
    }
}

xiaoming.pet?.toy?.play()

// 除了小名，也去还有小红小李小张等等
// 抽象，做一个闭包:传入一个child，如果小朋友有宠物，宠物也有玩具，就去玩

/*** Wrong! ***/

let w_playClosure = { (child: Child) -> () in child.pet?.toy?.play() }

// 无意义

// 对于play()的调用上。定义的时候没有写play()的返回，表示方法返回Void.

/******/

// 对于Optional Chaining 以后，得到一个Optional的结果

let playClosure = { (child: Child) -> ()? in child.pet?.toy?.play() }

// 返回将是一个()?  使用的时候可以通过 Optional Binding 来判定是否调用成功

if let _: () = playClosure(xiaoming) {
    print("开心")
}else {
    print("没有玩具可以玩 :(")
}
