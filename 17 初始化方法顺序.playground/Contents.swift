//: Playground - noun: a place where people can play

import UIKit

// 与ObjC不同，Swift的初始化方法需要保证类型的所有属性都被初始化。
// 所以初始化方法的调用顺序很有讲究。
// 在某个类的子类中，初始化方法里语句的顺序并不是随意的，需要保证在当前子类实力的成员初始化完成后才能调用父类的初始化方法:

//Example:

class Cat0 {
    var name: String
    init() {
        name = "Cat"
    }
}

class Tiger0: Cat0 {
    let power: Int
    override init() {
        power = 10
        super.init()
        name = "Tiger"
    }
}


// 一般来说，子类的初始化顺序是：

// 1. 设置子类自己需要初始化的参数: power = 10
// 2. 调用父类的相应的初始化方法: super.init()
// 3. 对父类中的需要改变的成员进行设置: name = "Tiger"

// 其中第三步是根据具体情况决定的，如果在子类中不需要对父类的成员做出改变的话，就不存在第三步
// 在这种情况下，Swift会自动地父类的对应init方法进行调用，第2步的super.init() 也是可以不用写(实际上还是会调用的，只不过是为了简便Swift帮我们完成了)

class Cat {
    var name: String
    init() {
        name = "Cat"
    }
}

class Tiger: Cat {
    let power: Int
    override init() {
        power = 10
        // 如果不需要改变name的话
        // 虽然没有显式地对 super.init() 进行调用
        // 由于这是初始化的最后，Swift 替自动完成
    }
}
