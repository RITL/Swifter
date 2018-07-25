//: Playground - noun: a place where people can play

// 在Swift1.2后，我们可以使用类变量了，所以Swift中的单例也有了比较理想的创建方式。

//## Swift1.2之前

// 单例是一个在Cocoa中很常用的模式了。对于一些希望能在全局方便访问的实例，或者在app的生命周期中只应该存在一个的对象，我们一般都会是用单例来存储和访问。
// 在ObjC中单例的公认的写法类似下面:

/*
 + (instance)sharedInstance {
 
    static id manager = nil;
    static dispatch_once_t onceToken;
 
    dispatch_once(&onceToken.^{
        manager = self.new;
    });
 
    return manager;
 }

 */

// 使用GCD中的dispatch_once_t可以保证里面的代码只被调用一次，一次保证单例在线程上的安全。
// 因为在Swift中可以无缝直接使用 GCD,所以可以很方便的把类似方式的单例用Swfit进行改写(Swift3.0中溢出了dispatch_once)

//class Manager {
//    class var shareManager: Manager {
//        struct Static {
//            static var onceToken: dispatch_once_t = 0
//            static var staticInstance: Manager? = nil
//        }
//
//        dispatch_once(&Static.onceToken){
//            Static.staticInstance = Manager()
//        }
//        return Static.staticInstance!
//    }
//}

// 这样的写法没有问题，但是在Swift中有一个更简单的保证线程安全的方式，是let.
// 把上面的写法简化一下:

class Manager {
    class var shareManager: Manager {
        struct Static {
            static let staticInstance: Manager = Manager()
        }
        return Static.staticInstance
    }
}

// 还有另一种更受大家欢迎，并被认为是Swift1.2之前的最佳实践的做法。
// 由于Swift1.2之前 class 不支持存储式的 property，我们想要使用一个只存在一份的属性时，就只能将其定义在全局的scope中。
// 值得庆幸的是，在Swift中是有访问级别的控制的，我们可以在变量定义前面加上 private 关键字，是这个变量只在当前文件中可以被访问。
// 这样就可以写出一个没有嵌套的，语法上也更简单好看的单例了:


class Manager1 {
    class var shared: Manager1 {
        return shareInstance
    }
}

private let shareInstance = Manager1()


//## Swift1.2中的改进

// Swift1.2之前还不支持例如 static let 和 static var这样的存储类变量。
// 但是在1.2中Swift添加了类变量的支持，因此单例可以进一步简化。

// 将上面全局的sharedInstance拿到class中，这样结构上就更紧凑和合理了。

// 在Swift1.2以及之后，如果没有特别的需求，推荐使用下面这样的方式来写一个单例

class Manager2 {
    static let shared = Manager2()
    private init() { }
}

// 这种写法不仅简介，而且保证了单例的独一无二。
// 在初始化类变量的时候，Apple将会把这个初始化包装在一次swift_once_block_invoke中，以保证它的唯一性。
// 不仅如此，对于所有的全局变量，Apple都会在底层使用这个类似dispatch_once的方式来确保只以lazy的方式初始化一次。

// 另外，我们在这个类型中加入了一个私有的初始化方法，来覆盖默认的公开初始化反法国，这让项目中的其他地方不能通过init来生成自己的Manager实例，也保证了类型单例的唯一性。
// 如果需要的是类似 default 的形式的单例(也就是说这个类的使用者可以创建自己的实例)的话，可以去掉这个私有化init方法。



