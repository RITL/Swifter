//: Playground - noun: a place where people can play

import Foundation

// 在ObjC中，init方法除了返回self以外，其实和一个普通大哥实例方法没有太大的区别。
// 如果喜欢，甚至可以多次调用，这都没有限制。

// 一般来说，初始化方法失败(比如输入不满足要求无法正确初始化)的时候返回nil来通知这个初始化没有正确完成

// 在Swift中默认情况下初始化方法是不能写return语句来返回值的，也就是说我们没有机会初始化一个Optional的值。

//Example:

// ObjC

//NSURL *url = [[NSURL alloc] initWithString:@"ht tp://swifter。tips"];
//NSLog(@"%@",url);  //nil

// Swift
//let url = URL(string: "ht tp://swifter。tips")
//print(url)


extension Int {
    
    init?(fromString: String) {//在init后面追加?
        self = 0
        var digit = fromString.count - 1
        
        for c in fromString {//开始遍历
            
            var number = 0
            
            if let n = Int(String(c)){
                
                number = n
                
            } else {
                
                switch c {
                case "一": number = 1
                case "二": number = 2
                case "三": number = 3
                case "四": number = 4
                case "五": number = 5
                case "六": number = 6
                case "七": number = 7
                case "八": number = 8
                case "九": number = 9
                case "零": number = 0
                default: return nil
                }
            }
            
            self = self + number * Int(pow(10, Double(digit)))
            
            digit = digit - 1
        }
    }
}


let number1 = Int(fromString: "12") // (Some 12)
let number2 = Int(fromString: "三二五") // (Some 325)
let number3 = Int(fromString: "七9八") // (Some 798)
let number4 = Int(fromString: "吃了么") // nil
let number5 = Int(fromString: "1a4n") // nil
