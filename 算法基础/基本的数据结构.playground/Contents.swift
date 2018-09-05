//: Playground - noun: a place where people can play

/*:
 ## 数组
 
 数组是最基本的数据结构
 在 Swift 中，以前 ObjC 时代中将`NSMutableArray`和`NSArray`分开的做法
 被统一到了唯一的数据结构 -- `Array`
 虽然看上去就一种数据结构，其实它的实现有三种:
 
 - `ContiguousArray`: 效率最高，元素分配在连续的内存上，
 如果数组是值类型(栈上操作)，则 Swift 会自动调用 Array 的这种实现，
 如果重视效率，推荐声明这种类型，尤其是在大量元素是类时，这样做效果会更好
 
 - `Array`: 会自动桥接到 ObjC 的 `NSArray`上，
 如果是值类型，其性能与 `ContiguousArray`无差别
 
 - `ArraySlice`: 它不是一个新的数组，只是一个片段，在内存上与原数组享用的是同一区域
 */

/*:
 ```
 let nums = [1,2,3]
 let nums = [Int](repeating: 0, count: 5)
 
 var nums = [3,1,2]
 //新增
 nums.append(4)
 //升序
 nums.sort()
 //降序
 nums.sort(by: >)
 // 将数组除了最后一个以外的所有元素赋值类另一个数组
 let anotherNums = Array(nums[0 ..< nums.count - 1])
 ```
 */

/*
 不要小看这些简单的操作：
 数组可以依靠他们实现更多的数据结构
 
 Swift 不像 Java 中有现成的队列和栈
 但完全可以用数组配合最简单的操作实现这些数据结构
 
 实现栈: Stack.Swift
 */

class Stack<T> {
    var stack: [T]
    var isEmpty: Bool {Reserves
        return stack.isEmpty
    }
    var peek: T? {
        return stack.last
    }
    
    init() {
        stack = [T]()
    }
    
    func push(object: T){
        stack.append(object)
    }
    
    func pop() -> T? {
        if !isEmpty {
            return stack.removeLast()
        }
        return nil
    }
}

/*
 `reserveCapacity()`
 它用于为原数组预留空间，防止数组在增加和删除元素时反复申请内存空间或是创建新数组
 特别适用于创建和 removeAll() 时候进行调用，为整段代码起到提高性能的作用。
 */


/*:
 ## 字典和集合
 
 字典和集合(这里专指 HashSet) 经常被使用的原因与，
 查找数据的时间复杂度为O(1)。
 一般字典和集合要求它们的key 都必须遵循 hashable 协议，
 Cocoa 中的基本数据类型都满足这一点；
 自定义的 class 需要实现 Hashable,
 又因为 Hashable 是对 Equable 的扩展，所以还需要重载 == 运算符
 
 */

let primeNums: Set = [3,5,7,11,13]
let oddNums: Set = [1,3,5,7,9]

//交集、并集、差集
let primeAndOddNum = primeNums.intersection(oddNums)
let primeOrOddNum = primeNums.union(oddNums)
let oddNotPrimNum = oddNums.subtracting(primeNums)

//用字典和高阶函数计算字符串中每个字符的出现频率，结果:["h":1,"e":1,"l":2,"o":1]
Dictionary("hello".map {($0,1)}, uniquingKeysWith: +)

/*:
 ### Example:
 
 给一个整形数组和一个目标值，判断数组中是否有两个数字之和等于目标值:
 
 这道题是传说中经典的 “2Sum”
 我们已经有一个数组记为 nums,也有一个目标值为 target，最后返回一个Bool值。
 
 1、最粗暴的方法就是每次选中一个数，然后遍历整个数组，判断是否有两一个数使两者之和为 target，
 这种做法时间的复杂度为 O(n^2)
 
 2、采用集合可以优化时间复杂度。
 在遍历数组的过程中，采用集合每次保存当前值。
 假如集合中已经有了 目标值减去当前值，则证明在之前的边里中一定有一个数与当前值之和等于目标值。
 这样的做法时间复杂度为O(n)
 */

func twoSum(nums:[Int],_ target: Int) -> Bool {
    var set = Set<Int>()
    
    for num in nums {
        if set.contains(target - num) {
            return true
        }
        set.insert(num)
    }
    return false
}

/*:
 ### Example:
 
 给定一个整型数组中有且仅有两个数字之和等于目标值，求两个数字在数组中的序号：
 
 思路与上题基本类似，但是为了方便拿到序列号，我们采用字段，
 时间复杂度依然是O(n)
 */

func twoSum_index(nums: [Int],_ target: Int) -> [Int] {
    var dict = [Int: Int]()
    
    for (i, num) in nums.enumerated() {
        
        if let lastIndex = dict[target - num] {
            return [lastIndex,i]
        }else {
            dict[num] = i;
        }
    }
    
    fatalError("No valid output!")
}

/*:
 ## 字符串
 
 字符串是算法实战中及其常见。
 在 Swift 中，字符窜不同于其他语言(包括 ObjC)
 它是值类型而非引用类型。
 */

let str = "3"
let num = Int(str)
let number = 3
let string = String(num)

let len = str.count

// 访问字符串中的单个字符，时间复杂度为O(1)
let char = str[str.index(str.startIndex, offsetBy: 2)]

str.remove(at: 2)
str.append("c")
str += "Hello world"

func isStrNum(str: String) -> Bool {
    return Int(str) != nil
}

// 将字符串按字母大小排序(不考虑大小写)
func sortStr(str: String) -> String {
    return String(str.sorted())
}

/*:
 ### Example:
 给一个字符串，将其按照单词顺序进行反转。
 比如说 s 是 “the sky is blue”,反转就是 “blue is sky the”.
 
 - 每个单词长度不一样
 - 空格需要特殊处理
 
 这样一来代码写起来会很繁琐而且容易出错:
 写法如下:
 */

fileprivate func reverse<T>(_ chars: inout [T],_ start: Int, _ end: Int){
    var start = start, end = end
    
    while start < end {
        swap(&chars, start, end)
        start += 1
        end -= 1
    }
    
    fileprivate func swap<T>(_ chars: inout[T],_ p: Int, _ q: Int){
        (chars[p],chars[q]) = (chars[q],chars[p])
    }
}

/*:
 有了这个方法，可以实行下面两种字符串翻转:
 
 - 整个字符串翻转，“the sky is blue” -> "eulb si yks eht"
 - 单个单词作为一个字符串单独翻转，“the sky is blue” -> "blue is sky the"
 
 整天思路有了，就可以解决这道问题了。
 */

func reverseWords(s: String?) -> String? {
    guard let s = s else {
        return nil
    }
    
    var chars = Array(s),start = 0
    reverse(&chars, 0, chars.count - 1)//整体翻转
    
    //每个单词进行反转
    for i in 0 ..< chars.count {
        if i == chars.count - 1 || chars[i + 1] == " "{//如果是最后一个或者后面是空格，表示是一个单词完毕
            reverse(&chars, start, i)
            start = i + 2 //跳过空格
        }
    }
    return String(chars)
}

// 复杂度还是O(n),整体思路和代码简单很多。

/*:
 在 Swift 中，数组、字符串、集合以及字典是最基本的数据结构，
 但是围绕这些数据结构的问题层出不穷。
 而在日常开发中，使用起来也非常高效(栈上运行)和安全(无需顾虑线程问题)，
 因为他们都是值类型
 */



