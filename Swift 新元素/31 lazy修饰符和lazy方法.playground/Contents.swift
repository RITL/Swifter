//: Playground - noun: a place where people can play

// 延时加载或者说延时初始化是很常见的优化方法，在构建和生成新的对象的时候，内存分配会在运行时耗费不少时间，如果有一种对象的属性和内容非常复杂的话，这个时间更是不可忽略。
// 另外，有些情况下我们并不会立即用到一个对象的所有属性，而是默认情况下初始化时，那些在特定环境下不被使用存储属性，也一样要被初始化和赋值，也是一种浪费。

// 在其他语言中延时加载的情况是非常常见的。
// 在第一次访问某个属性时，判断这个属性背后的存储是否已经存在，如果存在则直接返回，如果不存在则说明是首次访问，那么就进行初始化并存储后返回。
// 这样可以把这个属性的初始化时刻延迟，与包含它的对象的初始化时刻分开，也不会因为使用延时加载而造成什么性能影响

//Example:
// 作为最简单的例子:

/*
```ObjC
 
// classA.h
@property(nonatomic,copy) NSString *testString;

//classA.m
- (NSString *)testString {
    if (!_testString) {
        _testString = @"Hello";
        NSLog(@"只有首次访问输出");
    }
    return _testString;
}
 
 ```
 
 */

// 在初始化 ClassA对象后，_testString 是nil。
// 只有当首次访问testString属性时getter方法会被调用，并检查如果没有初始化的话，就进行复制。
// 为了方便确认，还在赋值是打印了一句log。
// 之后多次访问这个属性的话，因为_testString已经有值，因此将直接返回。

// Swift中使用在变量属性前加 lazy 关键字的方式简单的指定延时加载。
// 比如上面的代码在Swift中重写的话:

import Foundation

class ClassA {
    lazy var str: String = {
        let str = "Hello"
        print("只有首次访问输出")
        return str
    }()
}

// 在使用lazy作为属性修饰符时，只能声明属性是变量。
// 另外需要显式的指定属性类型，并使用一个可以对这个属性进行赋值的语句来在首次访问属性时运行。
// 如果多次访问这个实例的str属性的话，可以看到只有一次输出。

// 为了简化，如果不要做什么额外的工作的话，也可以对这个lazy的属性直接写赋值语句：
class ClassB {
    lazy var str: String = "Hello"
}

// 相比于ObjC中的实现方法，现在的lazy使用起来方便的多。

// 另外一个不太引人注意的是，在Swift标准库中，还有一组 lazy方法，他们的定义是:

//func lazy<S: Sequence>(s: S) -> LazySequence<S>
//func lazy<S: Collection>(s: S) -> LazyCollection<S> where S.Index: RandomAccessCollection
//func lazy<S: Collection>(s: S) -> LazyCollection<S> where S.Index: BidirectionalCollection
//func lazy<S: Collection>(s: S) -> LazyCollection<S> where S.Index: ForWardIndexType

// 这些方法可以配合像 map 或是 filter 这类接受闭包并进行运行的方法一起，让整个行为变为延时进行的。
// 在某些情况下这么做也对性能会有不小的帮助

//Example:
// 直接使用map时

let data = 1...3
let result = data.map { (i: Int) -> Int in
    
    print("正在处理\(i)")
    return i * 2
}

print("准备访问结果")
for i in result {
    print("操作后结果为\(i)")
    if i == 4 {
        print("中间断开，不需要遍历了")
        break
    }
}
print("操作完毕")


print("\n\n我是lazy优化分割线\n\n")

// 如果进行一次lazy操作的话，就能得到延时运行版本的容器

let data1 = 1...3
let result1 = data.lazy.map { (i) -> Int in
    print("正在处理\(i)")
    return i * 2
}
print("准备访问结果")
for i in result1 {
    print("操作后结果为\(i)")
    if i == 4 {
        print("中间断开，不需要遍历了")
        break
    }
}
print("操作完毕")

// 对于那些不需要完全运行，可能提前退出的情况，使用lazy来进行性能优化效果会非常有效。

