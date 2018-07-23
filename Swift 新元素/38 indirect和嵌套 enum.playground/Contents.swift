//: Playground - noun: a place where people can play

// 再涉及到一些数据结构的经典理论和模型(链表，树和图)时，往往会用到嵌套的类型。
// 比如链表，在Swift中，可以这样定义一个单项列表
//Example:

class Node<T> {
    let value: T?
    let next: Node<T>?
    
    init(value: T?,next: Node<T>?) {
        self.value = value
        self.next = next
    }
}

let list = Node(value: 1, next: Node(value: 2, next: Node(value: 3, next: Node(value: 4, next: nil))))

// 单项链表 1 -> 2 -> 3 -> 4

// 看其里很不错，但是这样的形式在表达空节点的时候并不十分理想。
// 我们不得不借助于nil来表达空节点，但是事实上空节点和nil并不是等价的
// 另外，如果我们想表达一个空链表的话，要么需要把list设置为Optional,要么把Node里的 value 以及 next 都设为nil,这导致描述中存在歧义，我们不得不做一些人为的约定来表述这样的情况，这在算法描述里是十分致命的。

// 在Swift2中，我们可以使用嵌套enum了，而这在swift1.x里是编译器所不允许的。
// 我们使用enum来重新定义链表结构的话:

indirect enum LinkedList<Element: Comparable> {
    case empty
    case node(Element, LinkedList<Element>)
}

let linkedList = LinkedList.node(1, .node(2,.node(3,.node(4,.empty))))

// 单项链表 1 -> 2 -> 3 -> 4

// 在enum的定义中嵌套自身对于class 这样的引用类型来说没有任何问题，但是对于像struct或者enum这样的值类型来说，普通的做法是不可行的。
// 我们需要在定义前面加上 indirect 来提示编译器不要直接在值类型中直接嵌套。
// 使用enum表达链表的好处在于，我们可以寥寥数行就轻易的实现链表结点的删除方法:

indirect enum LinkedList1<Element: Comparable> {
    
    case empty
    case node(Element, LinkedList1<Element>)
    
    func removing(_ element: Element) -> LinkedList1<Element>{
        
        guard case let .node(value,next) = self else {//如果是node结点，就跳出，如果是末尾了，直接返回空链表
            return .empty
        }
        
        // 第一步 1 ！= 2 返回 LinkedList1.node(1,2->3->4)
        // 第二步 2 == 2 直接返回 (3->4)
        // 进行拼接 1 -> 3 -> 4
        return value == element ? next : LinkedList1.node(value, next.removing(element))
    }
}


let linkedList1 = LinkedList1.node(1, .node(2,.node(3,.node(4,.empty))))
linkedList1.removing(2)
// 单项链表 1 -> 3 -> 4



