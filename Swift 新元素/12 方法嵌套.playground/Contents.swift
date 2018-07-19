//: Playground - noun: a place where people can play

import UIKit

// 方法成为了一等公民，可以将方法当成变量或者参数来使用。
// 更进一步，甚至可以再一个方法中定义新的方法。

// Example:
// 写一个网络请求的类Request,可能面临着将请求的参数编码到url里的任务。
// 因为输入的参数可能包括单个的值，字典或者数组，为了结构漂亮和保持方法短小，我们可能将情况分开:

func appendQuery0(url: String,
                 key: String,
                 value: AnyObject) -> String {
    if let dictionary = value as? [String: AnyObject]{
        return appendQueryDictionary0(url: url, key: key, value: dictionary)
    }else if let array = value as? [AnyObject] {
        return appendQueryArray0(url: url, key: key, value: array)
    }else {
        return appendQuerySingle0(url: url, key: key, value: value)
    }
}


func appendQueryDictionary0(url: String,
                           key: String,
                           value: [String: AnyObject]) -> String {
    //...
    return ""
}

func appendQueryArray0(url: String,
                      key: String,
                      value: [AnyObject]) -> String {
    
    return ""
}

func appendQuerySingle0(url: String,
                       key: String,
                       value: AnyObject) -> String {
    
    return ""
}

// 三个方法都只会在第一个方法中被调用，它们和Request没有直接的关系，所以将它们放到 appendQuery 中会是一个更好的组织形式

func appendQuery(url: String,
                 key: String,
                 value: AnyObject) -> String{
    
    func appendQueryDictionary(url: String,
                               key: String,
                               value: [String: AnyObject]) -> String {
        //...
        return ""
    }
    
    func appendQueryArray(url: String,
                          key: String,
                          value: [AnyObject]) -> String {
        
        return ""
    }
    
    func appendQuerySingle(url: String,
                           key: String,
                           value: AnyObject) -> String {
        
        return ""
    }
    
    if let dictionary = value as? [String: AnyObject]{
        return appendQueryDictionary(url: url, key: key, value: dictionary)
    }else if let array = value as? [AnyObject] {
        return appendQueryArray(url: url, key: key, value: array)
    }else {
        return appendQuerySingle(url: url, key: key, value: value)
    }
}

// 虽然Swift提供了不同的访问权限，但有些方法我们完全不希望在其他地方被直接使用。
//
// 一方面希望灵活地提供一个模板来让使用者可以通过模板制定想要的方法。
// 另一方面不希望暴露太多实现细节，或者甚至让使用者可以直接调用到模板。

// Example:

func makeIncrementor(addNumber: Int) -> ((inout Int) -> Void) {
    
    func incrementor(variable: inout Int) -> Void {
        variable += addNumber
    }
    
    return incrementor
}







