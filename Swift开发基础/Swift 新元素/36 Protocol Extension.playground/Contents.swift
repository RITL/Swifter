//: Playground - noun: a place where people can play

// Swift2 中引入了一个非常重要的特性，那就是 protocol extension.

// 在Swift1.x中，extension仅只能作用在实际类型上(也就是class,struct等等)，而不能拓展一个protocol.
// 在Swift中，标准库的功能基本都是基于protocol来实现的

// 举个最简单的例子:
// 每天使用的Array 就是遵循了 Collection 这个protocol.
// Collection 可以说是 Swift 中非常重要的协议，除了 Array以外，像是Dictionary 和 Set 也都实现了这个协议所定义的内容。

// 在protocol不能被拓展的时候，想要为实现了某个协议的所有类型添加一些另外的共通的功能时，会非常麻烦。
// 一个很好的例子是Swift 1.x时像是map 或者 filter 这样的函数。

// 大体说，会有两种思路进行添加。

// 第一种方式是在协议中定义这个方法，然后在所有实现了这个协议的类型中都去实现一遍。
// 这样没有一个这样的类型，就需要写一份类似甚至相同的方法，这显然是不可取的，不仅麻烦，而且完全没有可维护性。

// 另一种方法就是在全局范围实现一个接受该protocol的实例的方法，相比于前一种方式，只需要维护一份代码，显然要好不少，但是缺点在于在全局作用域中引入了只和特性protocol有关的东西，并不符合代码设计的美学。

// 作为妥协，Apple在Swift 1.x中采用的是后一种，也就是全局方法，如果尝试寻找的话，可以在Swift 1.x的标准库的全局scope中找到像是map 和filter这样的方法。

// 在Swift2中这个问题被彻底解决了。
// 现在可以对一个已有的protocol进行拓展，而拓展中实现的方法将作为实现拓展的类型的默认实现。

//Example:
protocol MyProtocol {
    func method()
}

extension MyProtocol {
    func method() {
        print("Called")
    }
}

// 具体的实现这个协议的类型中，即使什么都不写，也可以通过编译。
// 进行调用的话，会直接使用 extension 中的实现:

struct MyStruct: MyProtocol {
    
}

MyStruct().method() // Called

// 当然如果需要在类型中进行其他实现的话，可以像以前那样在具体类型中添加这个方法:

struct MyStruct1: MyProtocol {
    
    func method() {
        print("Called in struct1")
    }
}

MyStruct1().method() //Called in struct1

// 也就是说，Protocol extension 为 protocol 中定义的方法提供了一个默认的实现。
// 有了这个特性以后，之前被放在全局环境中的接受 Collection 的map方法，就可以移动到 Collection 的协议拓展中去了

//extension Collection {
//     public func map<T>(_ transform: (Self.Element) throws -> T) rethrows -> [T]
//}

// 在日常开发中，另一个可以用到 Protocol extension 的地方是 optional 的协议方法。
// 通过提供protocol 的 extension, 为 protocol 提供了默认实现，相当于变相的将protocl中的方法设定为optional.

// 对于 protocol extension 来说，有一种非常让人迷惑的情况，就是协议的拓展中实现了协议里没有定义的方式的情况。

//Example:

protocol A1 {
    func method1() -> String
}

extension A1 {
    func method1() -> String {
        return "hi"
    }
}

struct B1: A1 {
    func method1() -> String {
        return "hello"
    }
}

// 在使用的时候，无论将实例的类型为A1还是B1,因为实现只有一个，所以没有任何疑问，调用方法时的输出都是hello

let b1 = B1() // b1 is B1
b1.method1()

let a1: A1 = B1() // a1 is A1
a1.method1()


// 如果在协议里之定义了一个方法，而在协议拓展中实现了额外的方法的话，事情就变得有趣起来了。

//Example:

protocol A2 {
    func method1() -> String
}

extension A2 {
    func method1() -> String {
        return "hi"
    }
    
    func method2() -> String {
        return "hi"
    }
}

// 拓展中除了实现协议定义的 method1 之外，还定义了一个协议中不存在的方法 method2.
// 尝试实现这个协议

struct B2: A2 {
    func method1() -> String {
        return "hello"
    }
    
    func method2() -> String {
        return "hello"
    }
}

// B2中实现了 method1 和 method2.
// 进行调用
let b2 = B2()

b2.method1() // Hello
b2.method2() // Hello

// 结果在意料之中，虽然在Protocol extension中已经实现了这两个方法，但是他们只是默认的实现，在具体实现协议的类型中可以对默认实现进行覆盖，这非常合理。
// 但是如果稍微改变

let a2 = b2 as A2

a2.method1() // Hello
a2.method2() // hi

// a2 和 b2 是同一个对象，只不过通过as告诉编译器我们在这里需要的类型是A2.
// 但是这个时候在这个同样的对象上调用同样的方法调用却得到了不同的结果

// 对 a2 调用method2 实际上是协议拓展中的方法被调用了，而不是 a2 实例中的方法被调用。
// 解释:
// 对于method1，因为他在protocol 中被定义了，因此对于一个被声明为遵循协议的类型的实例（也就是对于a2）来说，可以确定实例必然实现了 method1，可以放心大胆地用动态派发的方式使用最终的实现（不论他是在类型中的具体实现还是在协议拓展中的默认实现）
// 但是对于method2,只是在协议拓展中进行了定义，没有任何规定说他必须在最终的类型中被实现。
// 在被调用时，无法确定安全，也就不会去进行动态派发，而是转而编译期间就确定的默认实现。

// 在这里例子中，可能会觉得无所谓，因为实际中估计并不会有人将一个已知类型转回协议类型。
// 但是要考虑到如果一些泛型API中有类似的直接拿到一个协议类型的结果的时候，调用它的拓展方法时就需要特别的小心了
// 一般来说，如果有这样的需求的话，可以考虑将这个协议类型再转回实际的类型，然后进行调用。


// 整理一下相关的规则:


//# 如果类型推断得到的是实际的类型:
//-  那么类型中的实现将被调用；如果类型中没有实现的话，那些协议拓展中的默认实现将被使用。

//# 如果类型推断得到的是协议，而不是实际类型
//-  并且方法在协议中进行了定义，那么类型中的实现将被调用；如果类型中没有实现，那么协议拓展中的默认实现被使用。
//-  否则（也就是方法没有在协议中定义），拓展中的默认实现将被调用









