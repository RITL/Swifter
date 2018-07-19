//: Playground - noun: a place where people can play

import UIKit

// 在看到一些协议的定义时，可能会注意到出现了首字母大写的Self出现在类型的位置上:

protocol IntervalType {
    
    func clamp(intervalToClamp: Self) -> Self
}

// 比如上面这个 IntervalType 的协议定义了一个方法，接收实现该协议的自身的类型，并返回一个同样的类型。

// 那么定义是因为协议其实本身是没有自己的上下文类型信息的，在声明协议的时候，并不知道最后究竟是什么样的类型来实现这个协议
// Swift中也不能在协议中定义泛型进行限制。
// 而在声明协议时，希望在协议中使用的类型就是实现这个协议本身的类型的话，就需要使用Self来进行指代。

// 在这种情况下，Self不仅指代的是实现该协议的类型本身，也包括了这个类型的子类。
// 从概念上来讲，Self十分简单，但是实际实现一个这样的方法却要稍微转个弯。


//Example:
// 假设实现一个Copyable的协议，满足这个协议的类型需要返回一个和接收方法调用的实例相同的拷贝。

// 一开始可能考虑的协议是这样的
protocol Copyable1 {
    func copy() -> Self
}
// 这样很直接明了，它应该做的是创建一个和接受这个方法的对象相同的东西，然后将其返回，返回的类型不应该发生变化，所以写了Self

/*

class MyClass1: Copyable1 {
    var num = 1

    func copy() -> Self {
        //TODO: 返回?
        //return
    }
}
 
 */

// 一开始可能会写出如下代码
/********** Wrong  *************/

/*

class MyClass2: Copyable1 {
    var num = 1
    
    func copy() -> Self {
        let result = MyClass2()
        result.num = num
        return result;
    }
}
 
 */


/**********  Wrong  *************/

// 显然返回的类型是有问题的，因为该方法要求返回一个抽象的、表示当前类型的Self,但是去返回了它的真实类型MyClass，这导致了无法编译
// 如果把方法声明中的Self改为MyClass，这样声明就和实际返回一样了，但是很快就发现，实现的方法又和协议中的定义又不一样了，依然不能编译

// 为了解决这个问题，需要的是通过一个和当前上下文无关的，又能够指代当前类型的方法进行初始化。
// 可以使用type(of:)来获取对象类型，通过它也可以进一步进行初始化，以保证方法与当前类型上下文无关，这样不论是MyClass还是它的子类，都能正确返回合适的类型满足Self的要求

/*

class MyClass3: Copyable1 {
    var num = 1
    
    func copy() -> Self {
        let result = type(of: self).init()
        result.num = num
        return result;
    }
}
 
 */

// 很不幸，上面这样还是无法通过编译，编译器如果想要构建一个Self类型的对象，需要有required关键字修饰的初始化方法，因为Swift必须保证当前类和其子类都能响应这个init方法。
// 另一个解决的方案是在当前类类的声明钱加final关键字，告诉编译器不会再有子类来继承这个类型.


class MyClass4: Copyable1 {
    var num = 1
    
    func copy() -> Self {
        let result = type(of: self).init()
        result.num = num
        return result;
    }
    
    required init() {
        
    }
}

// 验证


let object = MyClass4()
object.num = 100

let newObject = object.copy()
object.num = 1

print(object.num)
print(newObject.num)


// 对于MyClass的子类，copy()方法也能正确的返回子类的经过拷贝的对象了。
// 另外一个使用Self的地方就是在类方法中，使用起来很相似，核心在于保证子类也能返回恰当的类型。


// 个人思考: 感觉类比的话，可以稍微的理解成是ObjC的一个类对象


