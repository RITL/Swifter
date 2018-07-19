//: Playground - noun: a place where people can play

import UIKit

// Swift的方法是支持默认参数的，也就是说在声明方法的时候，可以给某个参数指定一个默认使用的值
// 在调用方法时传入了这个参数，就是用传入的参数，如果缺少这个输入参数，就直接使用设定的默认值进行调用。

// 在与其他很多语言的默认参数相比，Swift中的默认参数限制更少，并没有所谓"默认参数之后不能再出现无默认值的参数"这样的规则(- - PHP)

//Example:

func sayHello1(str1: String = "Hello",str2: String,str3: String){
    print(str1 + str2 + str3)
}

func sayhello2(str1: String,str2: String,str3: String = "World"){
    print(str1 + str2 + str3)
}

// 以上写法都是合法的

// 其他不少语言只能使用后面一种写法，将默认参数作为方法的最后一个参数。
// 在调用的时候，如果想要使用默认值的话只要不传入相应的值就可以了。
//Example:

sayHello1(str2: " ", str3: "World")
sayhello2(str1: "Hello", str2: " ")
// 都是Hello World


// NSLocalizedString

//func NSLocalizedString(key: String,
//                       tableName: String? = default,
//                       bundle: Bundle = default,
//                       value: String = default,
//                       comment: String) -> String

// 默认参数写的是 default，这是含有默认参数的方法所生成的swift调用接口。
// 当制定一个编译时就能确定的变量来作为默认参数的取值时，这个取值时隐藏在方法实现内部，而不应该暴露给其他部分。
// 比如sayHello1 当成接口暴露:
//func sayHello1_1(str1: String? = default,str2: String,str3: String);

// Swift的断言也类似
//func assert(_ condition: @autoclosure () -> Bool,
//            _ message: @autoclosure () -> String = default,
//                file: StaticString = #file,
//                line: UInt = #line)
