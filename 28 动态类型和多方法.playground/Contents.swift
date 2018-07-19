//: Playground - noun: a place where people can play

import UIKit

// Swift虽然可以通过 dynamicType(废弃了，使用type(of:)) 来获取一个对象的动态类型(也就是运行时的实际类型，而非代码置顶或编译器看到的类型)。
// 但是在使用中，Swift现在是不支持多方法的，就是说，不能根据对象在动态时的类型进行合适的重载方法调用。

//Example:
// Swift里可以重载同样名字的方法，而只需要保证参数类型不同:



class Pet {}
class Cat: Pet {}
class Dog: Pet {}

func printPet(_ pet:Pet){
    print("pet")
}

func printPet(_ cat: Cat){
    print("Meow")
}

func printPet(_ dog: Dog){
    print("Bark")
}

// 在对这些方法进行调用时，编译器将帮助我们找到最精确的匹配:

printPet(Pet())
printPet(Cat())
printPet(Dog())

// 对于Cat 或者 Dog 的实例，总是会寻找最合适的方法，而不会去调用一个通用的父类Pet的方法。
// 这一切的行为都是发生在编译时的

// 如果写了下面的代码

func printThem(_ pet: Pet,_ cat: Cat){
    printPet(pet)
    printPet(cat)
}

printThem(Dog(), Cat()) // Pet Meow // 不是运行时调用的Dog哦

// 打印是的Dog()的类型信息并没有被用到运行时选择合适的printPet(dog: Dog)版本的方法，而是被忽略掉，并采用了编译期间决定的Pet版本的方法。
// 因为Swift默认情况下是不采用动态派发的，所以方法的调用只能在编译时决定。

// 要想绕过这个限制，可能需要进行对输入类型做判断和转换:
func printThem1(_ pet: Pet,_ cat: Cat){
    if let aCat = pet as? Cat {
        printPet(aCat)
    }else if let aDog = pet as? Dog {
        printPet(aDog)
    }
    printPet(cat)
}














