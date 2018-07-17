//: Playground - noun: a place where people can play

// 在深入初始化方法之前，不妨再想想Swift中的初始化想要达到一种怎么样的目的。

// 在ObjC中，init 方法是非常不安全的:
// 没有人保证init只能被调用一次，也没有人保证在初始化方法调用以后实例的各个变量都完成初始化
// 甚至在初始化里使用属性进行设置的话，还可能造成各种问题
// Apple 明确说明不应该在init中使用属性来访问，但也并不是编译器强制的，但还是会有很多开发者犯错误 -- （- -我犯错误了）

// Swift有超级严格的初始化方法.
// 一方面: Swift 强化了designated初始化方法的地位。
// Swift中不加修饰的init方法都需要在方法中保证所有非Optional的实例变量被赋值初始化，而在子类中也强制(显式或者隐式地)调用super版本的designated初始化，所以无论走何种路径，被初始化的对象总是可以完成完整的初始化的。

//Example:

class ClassA {
    let numA: Int
    init(num: Int){
        numA = num
    }
}

class ClassB: ClassA {
    let numB: Int
    
    override init(num: Int) {//这里区别于上一章的super.init()
        numB = num + 1
        super.init(num: num)
    }
}

// 在init里面可以对let的实例变量进行赋值，这是初始化方法的重要特点。
// 在Swift中let声明的值是常量，无法被写入赋值，对于构建线程安全的API十分有用。
// 因为Swift的init只可能被调用一次，所以init中我们可以为常量进行赋值，而不会引起任何线程安全的问题



// 与designated初始化方法对应的是在init前加上convenience关键词的初始化方法。
// 这类方法是Swift初始化方法中的”二等公民“，只作为补充和提供使用上的方便。
// 所有的convenience初始化方法都必须调用同一类中的designated初始化完成设置
// 另外convenience的初始化方法是不能被子类重写或者从子类中以super方式被调用的。


//Example:

class ClassC {
    let numC: Int
    init(num: Int) {
        numC = num
    }
    
    convenience init(bigNum: Bool) {
        self.init(num: bigNum ? 1000 : 1)
    }
}

class ClassD: ClassC {
    
    let numD: Int
    override init(num: Int) {
        numD = num + 1
        super.init(num: num)
    }
}

// 只要在子类中实现重写了父类convenience方法所需要的init方法的话，在子类中也就可以使用父类的convenience 初始化方法。

let anObj = ClassD(bigNum: true)
// anObj.numC = 10000 anObj.numD = 10001

//看到初始化方法永远遵循以下两个原则
// 1. 初始化路径必须保证对象完全初始化，可以通过调用本类型的designated方法来得到保证
// 2. 子类的designated初始化方法必须调用父类的designated方法，以保证父类也完成初始化


// 对于希望子类中一定实现的designated的初始化方法，可以通过 required 关键字进行限制，强制子类对这个方法重写实现。
// 最大的好处就是可以保证依赖于某个designated初始化方法的convenience一直被使用。

// Example:
// 如果希望init(num: Int）声明为必须，这样在子类调用init(bigNum: Bool)时就始终能找到一条完全初始化的路径了

class ClassE {
    let numE: Int
    required init(num: Int) {
        numE = num
    }
    
    convenience init(bigNum: Bool) {
        self.init(num: bigNum ? 10000 : 1)
    }
}

class ClassF: ClassE {
    let numF: Int
    required init(num: Int) {
        numF = num + 1
        super.init(num: num)
    }
}

// 不仅仅是对designated初始化方法，对于convenience的初始化方法
// 也可以加上required以确保子类对其进行了实现
// 这对要求子类不直接使用父类中convenience初始化方法时会非常有帮助









