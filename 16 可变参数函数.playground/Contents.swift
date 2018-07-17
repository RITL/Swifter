//: Playground - noun: a place where people can play

import UIKit

// 可变参数函数指的是可以接受任意多个参数的函数，最熟悉的 `NSString` 的 `stringWithFormat:`

// NSString *string = [NSString stringWithFormat:@"Hello %@.Date.%@",@"Tom",NSDate.date];

// 这个方法的参数是可以任意变化的，参数的第一项是需要格式化的字符串，后面的参数都是第一个参数中填空。


// Example: 一个可变参数的函数只需要在声明类型后面加上`...`就可以了
func sum1(input: Int...) -> Int {
    return 1
}

// 输入的input在函数体内部将被作为数组[Int]来使用，完成上面的方法
// 可以使用传统的 for...in 做累加，但选择一种看起来更Swfit的方式:

func sum(input: Int...) -> Int {
    return input.reduce(0, +)
}

print(sum(input: 1,2,3,4,5))


// Swfit的可变参数十分灵活，在其他许多语言中，因为编译器和语言自身语法特性的限制，在使用可变参数时往往可变参数只能作为方法找那个的最后一个参数来使用，而不能先声明一个可变参数
// 然后在声明其他参数，因为编译器将不知道输入的参数应该从哪里截断。
// 这种限制在Swift中是不存在的，因为我们会对方法的参数进行命名，所以可以随意地放置可变参数的位置，而不必拘泥于最后一个参数：

func myFunc(numbers: Int...,string: String){
    
//    numbers.forEach { (number) in
//        for i in 0..<number {
//            print("\(i + 1): \(string)")
//        }
//    }
//
    numbers.forEach {
        for i in 0..<$0 {
            print("\(i + 1): \(string)")
        }
    }
}

//myFunc(numbers: 1,2,3,4, string: "Hello")

// 限制也会有，比如在同一个方法中只能有一个参数是可变的，比如可变参数都必须是同一种类型的。
// 对于后一个限制，如果想要同时传入多个类型的参数时就需要做一些变通
// 可变参数列表的第一个元素是等待格式化的字符串，在Swift中这回对应一个String类型，而剩下的参数应该是可以对应格式化标准的任意类型。
// 一种解决方法是使用Any作为参数类型，然后对接收到的数组的首个元素进行特殊处理
// 因为Swift提供了下划线_来作为参数的外部标签，来使调用时不再需要加上参数名字
// 在声明方法时指定第一个参数为一个字符串，然后跟一个匿名的参数列表，这样写起来的时候就像是所有参数都是在同一个参数列表中进行处理

//Example:
//extension NSString {
//    convenience init(format: NSString, _ args: CVarArg...) {
//        self.init()
//    }
//}

let name = "Tom"
let date = NSDate()
let string = NSString(format: "Hello %@. Date:%@", name,date)



