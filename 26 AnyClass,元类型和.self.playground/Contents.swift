//: Playground - noun: a place where people can play

// 在 Swift 中能够表示"任意"这个概念的出了 Any 和 AnyObject 以外，还有一个 AnyClass。
// AnyClass 在Swift中被一个 typealias 所定义

// typealias AnyClass = AnyObject.Type

// 通过 AnyObject.Type 这种方式所得到的是一个元类型(Meta)。
// 在声明时总是在类型的名称后面加上.Type
// 比如 A.Type 代表的是A这个类型的类型。
// 可以声明一个元类型来存储A这个类型本身，而在从A中取出其类型时，可能使用到.self

class A { }
let typeA: A.Type = A.self

// 在 Swift 中，.self可以用在类型后面获得类型本身，也可以用在某个实例后面取得这个实例本身。
// 前一种方法可以用来获得一个表示该类型的值，这在某些时候会很有用。
// 后者因为拿到的实例本身，所以暂时似乎没有太多需要这么使用的案例

// AnyObject.Type 或者说 AnyClass 所表达的东西其实并没有什么奇怪，就是任意类型本身
// 对于B类型的取值，也可以强制让它是一个AnyClass

class B {
    class func method(){
        print("Hello")
    }
}

let typeB: B.Type = B.self
typeB.method()

//比如:

let anyClass: AnyClass = B.self
(anyClass as! B.Type).method()


//# 意义

// 对于单个独立的类型来说，完全没有必要关系它的元类型，但是元类型或者元编程的概念可以变得非常灵活和强大，在编写某些框架性的代码时会非常方便。

// 比如想要传递一些类型的时候，就不需要不断地去改动代码了。

//Example:
// 用代码声明的方式获取了 MusicViewController 和 AlbumViewController的元类型
// 但其实这一步骤完全可以通过读入配置文件之类的方式来完成。
// 将这些元类型存入数组并且传递给别的方式来进行配置这一点上，元类型变成就很难被替代了

import UIKit

class MusicViewController: UIViewController {
    
}

class AlbumViewController: UIViewController {
    
}

let usingVCTypes: [AnyClass] = [MusicViewController.self,AlbumViewController.self]

func setupViewControllers(_ vcTypes: [AnyClass]){
    for vcType in vcTypes {
        if vcType is UIViewController.Type {
            let vc = (vcType as! UIViewController.Type).init()
            print(vc)
        }
    }
}

setupViewControllers(usingVCTypes)


// 这样一来，完全可以搭好框架，使用SDL进行配置，就可以在不触及Swift编码的情况下，很简单的完成一些列复杂的操作
// 在Cocoa API中也常遇到一个需要AnyClass的输入，这是也应该使用.self的方式来获取所需要的元类型
//Example:
let tableView = UITableView()
tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")


// .Type 表示的是某个类型的元类型，而在Swift中，除了class，struct和enum这三个类型外，还可以定义Protocol
// 对于Protocol来说，有时候也会想取得协议的元类型
// 可以在某个 protocol 的名字后使用.Protocol来获取，使用方法和.Type是类似的。

// 个人思考: .Type 就是像一个类的类型(重点是类型)(是一个类对象的类型) .self就是获得这个类的类型(重点在于获得)(一个类对象)













