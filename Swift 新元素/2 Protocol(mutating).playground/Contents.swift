import UIKit

// Protocol

protocol Vehicle
{
    var numberOfWheels: Int {get}
    var color: UIColor{get set}
    
    mutating func changedColor()
}

// 使用mutating修饰方法，在该方法中可以修改struct或者enum的变量

struct MyCar: Vehicle {
    
    let numberOfWheels: Int = 4
    var color = UIColor.blue
    
    mutating func changedColor() {
        color = .red
    }
    
// 不使用mutating修饰方法，在该方法中则不能修改sruct或者enum的变量
//    func changedColor() {  //报错
//        color = .red
//    }
}



