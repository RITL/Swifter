//: Playground - noun: a place where people can play

import UIKit

/*:
 # 栈和队列
 
 在 Swift 中，没有内设的栈和队列，很多扩展库中使用 Generic Type来实现栈或是队列。
 正规的做法是使用链表来实现，这样可以保证加入和删除的时间复杂度是O(1)。
 但是最实用的实现方法是使用数组，因为Swift没有现成的链表，而数组又有很多API可以直接使用，非常方便
 
 ## 基本概念 
 对于栈来说，需要了解一下几点:
 
 - 栈是后进先出的结构，可以理解成有好几个盘子跌成一叠，哪个盘子最后叠上去，下次使用的时候就最先抽出去。
 - 在 iOS 开发中，如果要在你的 App 中添加撤销操作(比如删除图片，恢复删除图片)，那么栈是首选数据结构
 - 无论在面试还是写 App 中，最关注栈的几个基本操作: push,pop,isEmpty,peek,size
 */

protocol Stack {
    
    //持有的元素类型
    associatedtype Element
    
    /// 是否为空
    var isEmpty: Bool { get }
    /// 栈的大小
    var size: Int { get }
    /// 栈顶元素
    var  peek: Element? { get }
    
    /// 进栈
    mutating func push(_ newElement: Element)
    /// 出栈
    mutating func pop() -> Element?
}

struct IntegerStack: Stack {
    
    typealias Element = Int
    
    var isEmpty: Bool { return stack.isEmpty }
    var size: Int {return stack.count }
    var peek: Element? { return stack.last }
    
    private var stack = [Element]()
    
    mutating func push(_ newElement: Int) {
        stack.append(newElement)
    }
    
    mutating func pop() -> Int? {
        return stack.popLast()
    }
}

/*:
 对于队列来说，需要了解以下几点:
 
 - 队列是先进先出的结构。正好就像现实生活中排队买票，谁先来排队，谁先买到票。
 - iOS开发中多线程的 GCD 和 NSOperationQueue 就是基于队列谁先的。
 - 关于队列只关注几个操作: enqueue,dequeue,isEmpty,peek,size
 */

protocol Queue {
    associatedtype Element
    
    var isEmpty: Bool { get }
    var size: Int { get }
    /// 队首元素
    var peek: Element? { get }
    
    /// 入队
    mutating func enqueue(_ newElement: Element)
    /// 出队
    mutating func dequeue() -> Element?
}


/// 数字队列
struct IntegerQueue: Queue {

    typealias Element = Int
    
    var isEmpty: Bool { return left.isEmpty && right.isEmpty }
    var size: Int { return left.count + right.count }
    var peek: Int? { return left.isEmpty ? right.first : left.last }
    
    private var left = [Element]()
    private var right = [Element]()
    
    mutating func enqueue(_ newElement: Int) {
        right.append(newElement)
    }
    
    mutating func dequeue() -> Int? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
}

/*:
 处理栈和队列问题，最经典的一个思路就是使用两个栈/队列来解决问题。
 也就是在原栈/队列的基础上，用一个协助栈/队列来帮助我们简化算法，
 这是一种空间换时间的思路。
 */


/*:
 ### 用栈实现队列
 */
struct MyQueue {
    
    var stackA: IntegerStack//一个真正的栈
    var stackB: IntegerStack//A的逆向栈
    
    var isEmpty: Bool {
        return stackA.isEmpty && stackB.isEmpty
    }
    
    mutating func peek() -> Int? {//队列的头
        shift()
        return stackB.peek
    }
    
    var size: Int {
        return stackA.size + stackB.size
    }
    
    init() {
        stackA = IntegerStack()
        stackB = IntegerStack()
    }
    
    // 进入队列
    mutating func enqueue(_ newElement: Int) {
        stackA.push(newElement)
    }
    
    // 出队
    mutating func dequeue() -> Int? {
        shift()//进行转换
        return stackB.pop()
    }
    
    
    fileprivate mutating func shift() {
        if stackB.isEmpty {//如果第二个栈为空
            while !stackA.isEmpty {//第一个站不是空，从栈A中pop 追加到 栈B
                stackB.push(stackA.pop()!)
            }
        }
    }
}

/*:
 ### 用队列实现栈
 */
struct MyStack {
    var queueA: IntegerQueue
    var queueB: IntegerQueue
    
    init() {
        queueA = IntegerQueue()
        queueB = IntegerQueue()
    }
    
    var isEmpty: Bool {
        return queueA.isEmpty && queueB.isEmpty
    }
    
    mutating func peek() -> Int?{
        shift()//栈A剩队尾
        let peekObj = queueA.peek//获得当前的队尾，就是栈顶
        queueB.enqueue(queueA.dequeue()!)//将A全部放到队列B中
        swap()//交换
        return peekObj
    }
    
    var size: Int {
        return queueA.size
    }
    
    
    mutating func push(_ newElement: Int) {
        queueA.enqueue(newElement)
    }
    
    mutating func pop() -> Int? {
        shift()
        let popObj = queueA.dequeue()
        swap()
        return popObj
    }
    
    /// 栈A与栈B进行交换
    private mutating func swap(){
        (queueA,queueB) = (queueB,queueA)
    }
    
    /// 将栈A的数据转移到栈B，只剩一个队尾
    private mutating func shift() {
        while queueA.size != 1 {//如果队列1的长度不是1
            queueB.enqueue(queueA.dequeue()!)//队列B追加A的出栈
        }
    }
}

/*:
 ### Example:
 
 给一个文件的绝对路径，将其简化。
 举个例子，路径是"/home/",简化后未"/home";
 路径是"/a/./b/../../c/",简化后为"/c"
 
 根据常识，知道以下规则:
 
 - '.'代表当前路径。比如"/a/."实际上就是"/a"，无论输入多少个"."都返回当前目录
 - “..”表示上一级。比如"/a/b/.."实际上就是"/a",也就是说先进入"a"目录，在进入其下的“b”目录，再返回“b”目录的上一层，也就是"a"目录
 
 
 针对以上信息，可以得到以下思路:
 
 - 首先输入是个 String,代表路径。输出要求也是 String,同样代码路径;
 - 可以把 input 根据 "/"符号去拆分，比如"/a/b/./../d/"就拆成了一个 String 数组["a","b",".","..","d"]
 - 创立一个栈然后遍历查分后的 String 数组，对于一般 String，直接加入到栈中，对于".."就对栈做pop操作，其他情况不作处理
 */

func simplifyPath(path: String) -> String {
    
    //用数组来实现栈的功能
    var pathStack = [String]()
    //查分分路径
    let paths = path.components(separatedBy: "/")
    
    //进行数据处理
    for path in paths {
        guard path != "." else {//当前目录，不做处理
            continue
        }
        
        //对于..使用pop操作
        if path == ".." {
            if pathStack.count > 0 {
                pathStack.removeLast()
            }
        // 对于太注意空数组的特殊情况
        }else if path != "" {//入栈
            pathStack.append(path)
        }
    }
    
    // 将栈中的内容转化为优化后的新路径
    let res = pathStack.reduce("") { "\($0)/\($1)" }
    return res.isEmpty ? "/" : res
}

/*:
 在Swift中，栈和队列是比较特殊的数据结构，
 最实用的实现和运用方法是利用数组。
 虽然本身比较抽象，却是很多复杂数据结构和iOS开发中的功能模块的基础。
 这也是一个工程师进阶之路理应熟练掌握的两种数据结构。
 */


