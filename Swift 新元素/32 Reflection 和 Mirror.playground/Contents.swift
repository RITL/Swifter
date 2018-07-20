//: Playground - noun: a place where people can play

// 熟悉Java的人可能会知道反射(Reflection).
// 这是一种在运行时检测、访问或者修改类型的行为的特性。
// 一般的静态语言类型的结构和方法的调用等都是需要在编译时决定，开发者能做的很多时候只是使用控制流(比如if 或者 switch) 来决定做出怎么样的设置或者调用那个方法。
// 而反射特性可以有机会在运行的时候通过某些条件实时的决定调用的方法，或者甚至向某个类型动态地设置甚至加入属性及方法，是一种非常灵活和强大的语言特性。

// ObjC中不太会经常提及到"反射"这样的词语，因为ObjC的运行时比一般反射还要灵活和强大.
// 很多人已经习以为常的像是通过字符串生成类或者selector,并且进而生成对象或者调用方法等，其实都是反射的具体表现。
// 而在Swift中其实就算抛开ObjC的运行时部分，在纯Swift范畴内也存在有反射相关的一些内容，只不过相对来说功能要弱得多。

// 这部分内容并没有公开的文档说明，所以随时可能发生变动，或者甚至存在今后被从Swift的可调用标准库中去掉的可能(Apple已经干过这种事情，最早的时候Swift中甚至有隐式的类型转换 __conversion,但是因为太过危险，而被彻底去除了。现在隐式转换必须使用 字面量转换 的方式进行了)。
// 在实际项目中，也不建议使用这种没有文档说明的API,不过有时候如果能稍微知道Swift中也存在这样的可能性的话，也去会有帮助(指不定哪天Apple就扔出一个完整版的反射功能呢)

// Swift中所有的类型都实现了 _Reflectable 这是一个内部协议。可以通过_reflect来获取任意对象的一个镜像，这个镜像对象包含类型的基本信息。
// 在Swift2.0之前，这是对某个类型的对象进行探索的一个方法。
// 在Swift2.0之后，这些方法已经从公开的标准库中移除了，取而代之，我们可以使用 Mirror 类型来做类似的事情

//Example:
struct Person {
    let name: String
    let age: Int
}

let xiaoMing = Person(name: "XiaoMing", age: 16)
let r = Mirror(reflecting: xiaoMing) // r 是 MirrorType

print("xiaoming 是 \(r.displayStyle!)")
print("属性个数:\(r.children.count)")
for child in r.children {
    print("属性名: \(String(describing:child.label)),值: \(child.value)")
}

// print
/*
 xiaoming 是 struct
 属性个数:2
 属性名: Optional("name"),值: XiaoMing
 属性名: Optional("age"),值: 16
 */

// 通过 Mirror 初始化得到的结果包含的元素的描述都被集合在 children 属性下，如果有心可以到Swift标准库中查找它的定义，实际上是一个Child的集合，而child则是一对键值的多元组
// public typealias Child = (label: String?, value: Any)
// public typealias Children = AnyCollection<Mirror.Child>

// AnyForwardCollection 是遵守 CollectionType 协议的，因此可以简单地使用 count 来获取元素的个数，而对于具体的代表属性的多元组，则使用下标进行访问。
// 再对于例子中，每个child都是具有两个元素的多元组，其中第一个是属性名，第二个是这个属性所存储的值。
// 需要特别注意的是，这个值都可能是多个元素组成嵌套的形式(例如属性值是数组或者字典的话，这个就是这样的形式)

// 如果觉得一个个打印太过于麻烦，也可以简单地使用 dump 方法来通过获取一个对象的镜像并进行标准输出的方式将其输出出来。
// 比如对上面的对象 xiaoMing:

print("\n")
dump(xiaoMing)

// 这部分内容很可能随着版本而改变。

// 对于一个从对象反射出来的 Mirror, 它所包含的信息是完备的。
// 就是说可以在运行时通过Mirror的手段了解一个Swift类型(NSObject也可以)的实例的属性信息。
// 该特征最容易想到的应用的特性就是为任意model对象生成对应的JSON描述。
// 可以对等待处理的对象的Mirror值进行深度优先的访问，并按照属性的valueType将他们归类到不同的格式化中

// 另一个常见的应用场景是类似对Swift类型的对象做的想ObjC中的KVC样的valueForKey:的取值。
// 通过比较取到的属性的名字和想要取得key值就行了

//Example:

func valueFrom(_ object: Any, key: String) -> Any? {
    
    let mirror = Mirror(reflecting: object)//获得object的镜像对象
    
    for child in mirror.children {// 遍历
        
        let (targetKey, targetMirror) = (child.label,child.value)// 获得label value
        
        if key == targetKey { //如果label与key对应上
            
            return targetMirror //返回value
        }
    }
    
    return nil//找不到
}


// 接上面的xiaoming

if let name = valueFrom(xiaoMing, key: "name") as? String {
    print("\n")
    print("通过 key 得到值: \(name)")
}


// 在现在的版本中，Swift的反射特征并不是很强大，只能对属性进行读取，还不能对其设定，不过希望能在将来的版本中获得更为强大的反射特性。

// 另外需要特备注意的是:
// 虽然理论上讲反射特性应用到实际的 app 制作中是可行的，但是这一套机制设计的最初目的使用户 REPL 和 Playground 中进行输出的。
// 所以最好遵循 Apple 这一设定，只在 REPL 和 Playground 中用它来对一个对象进行深层次的探索，而避免将它用在 app 制作中 -- 因为永远不知道什么时候他们就会失效或者被大幅改动。











