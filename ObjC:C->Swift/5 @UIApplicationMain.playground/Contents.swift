//: Playground - noun: a place where people can play

// 因为Cocoa开发环境已经在新建一个项目时帮助我们进行了很多配置
// 这导致了不少刚接触iOS的开发者都存在基础比较薄弱的问题
// 其中一个很显著的现象就是很多人无法说清一个app启动的流程。

// 程序到底是怎么开始的，AppDelegate到底是什么，xib或者stortboard是怎么被加载到屏幕上的?
// 这一系列问题虽然在开发中不会每次都去关心和自己配置
// 但是如果能进行一些了解的话对于程序各个部分的职责的明确会很有帮助。

// 在C系语言中，程序的入口都是main函数。
// 对于一个ObjC的iOS app项目，在新建项目时，Xcode将帮我们准备好一个main.m文件
// 其中就有这个main函数

/*
 int main (int argc,char * argv[])
 {
    @autoreleasepool {
        return UIApplicationMain(argc,argv,nil,NSStringFromClass([AppDelegate class]));
    }
 }
 */

// 这里我们调用了UIKit的UIApplicationMain方法。
// 这个方法将根据第三个参数初始化一个UIApplication或者其子类的对象并开始接受事件(在这个例子中传入nil,意味着使用默认的Application)
// 最后一个参数置顶了AppDelegate类作为应用的委托，他被用来接受类似 didFinishLaunching 或者 didEnterBackground 这样的与应用生命周期相关的委托方法。
// 另外，虽然这个方法标明为返回一个nil,但其实他并不会真正返回。
// 它会一直存在于内存中，知道用户或者系统将其终止。

// 了解这些后，可以来看看Swift的项目中对应的情况了。
// 新建一个Swift的iOS app项目后，会发现所有文件中都没有一个像ObjC时那样的main文件，也不存在main函数。
// 唯一和main有关系的是在默认的AppDelegate类的声明上方有一个 @UIApplicationMain 的标签。

// 不说可能也已经猜到了，这个标签做的事情就是将被标注的类作为委托，去创建一个UIApplication并启动整个程序。
// 在编译的时候，编译器将寻找这个标记的类，并自动插入像main函数这样的模板代码。

// 如果把@UIApplicationMain去掉的话:
// Undefined symbols_main

// 说明找不到main函数了

// 在一般情况下，并不需要对这个标签做任何修改，但是当我们如果想要使用UIApplication的子类而不是他自己本身的话，就需要对这部分内容做点手脚了。

// 其实Swift的app也是需要main函数的，只不过默认情况下是@UIApplicationMain帮助我们自动生成了而已。
// 和C系语言的main.c或者main.m文件一样，Swift项目也可以有一个名字为main.swift特殊的文件。
// 在这个文件中，不需要定义作用于，而可以直接书写代码。
// 这个文件中的代码将作为main函数来执行
// 比如再删除@UIApplicationMain后，在项目中添加一个main.swift文件，然后加上这样的代码
/*
 UIApplicationMain(Process.argc,Process.unsafeArgv,nil,NSStringFromClass(AppDelegate))
 */

// 现在编译运行，就不会出现错误了。
// 当然还可以通过将第三个参数替换成自己的UIApplication子类，这样就可以轻易地做一些控制整个应用行为的二事情了。
// 比如将main.swift的内容换成:

import UIKit

class MyApplication: UIApplication {
    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        print("Event sent: \(event)")
    }
}

/*
UIApplicationMain(Process.argc, Process.unsafeArgv, NSStringFromClass(MyApplication), NSStringFromClass(AppDelegate))
*/

// 这样每次发送时间(比如点击按钮)时，都可以监听这个事件了。

