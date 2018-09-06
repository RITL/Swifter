//: Playground - noun: a place where people can play

import UIKit

// 实现一个链表


/// 链表结点
class ListNode<T> {
    var val: T
    var next: ListNode?
    
    init(_ val: T) {
        self.val = val
        self.next = nil
    }
}

/// 链表
class List<T> {
    var head: ListNode<T>?
    var tail: ListNode<T>?
    
    //尾插法
    func appendToTail(_ val: T){
        if tail == nil {//如果是一个空链表
            tail = ListNode(val)
            head = tail
        }else {
            tail!.next = ListNode(val)
            tail = tail!.next
        }
    }
    
    //头插法
    func appendToHead(_ val: T){
        if head == nil {
            head = ListNode(val)
            tail = head
        }else {
            let temp = ListNode(val)
            temp.next = head
            head = temp
        }
    }
}

/*:
 ## Dummy 节点和尾插法
 
 ### Example：
 给一个链表和一个值x,要求将链表中所有小于x的值放在左边，所有大于等于x的值放到右边。
 原链表的结点顺序不能变。
 
 ```
 例: 1->5->3->2->4->2，给定 x = 3. 则要返回 1->2->2->5->3->4
 ```
 
 直觉告诉我们，这题要先处理左边(比x小的结点)，
 然后再处理右边(比x大的结点)，最后再把左右两边拼起来。
 */


/*:
 即我们有给定链表的头结点，有给定的x值，要求返回新链表的头结点。
 接下来要想，怎么处理左边，怎么处理右边，处理完后怎么拼接
 
 先来看怎么处理左边。
 不妨把这个题目先变简单一点：
 
 给一个链表和一个值x,要求只保留链表中所有小于x的值，原链表的结点顺序不能变。
 
 `例:  1->5->3->2->4->2，给定 x = 3，则要返回 1->2->2`
 
 利用尾插法，遍历链表，将小于x值的节点接入新的链表即可:
 */

func getLeftList(_ head: ListNode<Int>?,_ x: Int) -> ListNode<Int>? {
    let dummy = ListNode(0) // 作为一个虚拟的头结点
    var pre = dummy,node = head
    
    while node != nil {
        if node!.val < x {
            pre.next = node
            pre = node!
        }
        node = node!.next
    }
    
    
    //防止构成环
    pre.next = nil
    return dummy.next
}

/*:
 上面的代码引入了 Dummy 结点，它的作用就是作为一个虚拟的头前结点。
 引入它的原因是我们不知道要返回的新链表的头结点是哪一个，
 它有可能是一个原链表的第一个节点，
 可能在原链表的中间，也可能在最后，甚至可能不存在(nil)。
 而 Dummy 节点的引入可以巧妙的涵盖所有以上情况，可以用 dummy.next 方便得返回最终需要的头结点。
 */

/*
 解决了左边，右边也是同样处理。
 接着只要让左边的尾节点指向右边的头结点即可。
 */

func partition(_ head: ListNode<Int>?,_ x: Int) -> ListNode<Int>? {
    //引入Dummy节点
    let prevDummy = ListNode(0),postDummy = ListNode(0)
    var prev = prevDummy, post = postDummy
    
    var node = head//指向头结点
    
    //使用尾节点处理左边和右边
    while node != nil {
        if node!.val < x {//左边
            prev.next = node
            prev = node!
        }else {//右边
            post.next = node
            post = node!
        }
        node = node!.next
    }
    
    post.next = nil //防止构成环
    prev.next = postDummy.next
    
    return prevDummy.next
}

/*:
 `post.next = nil`，只是为了防止链表循环指向构成环，
 是必须的但是很容易忽略的一步。
 */

/*:
 ### 如何检测链表中是否有环存在
 
 #### 快行指针
 就是两个指针访问链表，一个在前一个在后，或者一个移动快另一个移动慢，
 这就是快行指针。
 
 #### Example: 如何检测一个链表中是否有环?
 
 答案是用两个指针同时访问链表，其中一个速度是另一个的2被，如果相等了，
 这个链表就有换了，这就是快行指针的实际使用:
 */

func hasCycle(_ head: ListNode<Int>?) -> Bool {
    
    var slow = head
    var fast = head
    
    while fast != nil && fast!.next != nil {//如果快行指针不是nil，并且也不是链表的最后
        slow = slow!.next
        fast = fast!.next!.next
        
        if slow === fast {
            return true
        }
    }
    
    return false
}

/*:
 #### Example:
 删除链表中倒数第 n 个节点。
 例: ` 1->2->3->4->5，给定 x = 2，则要返回 1->2->3->5`.
 给定 n 的长度小于等于链表的长度。
 
 解题思路依然是快行指针，这次两个指针动移动速度相同。
 但是一开始，第一个指针(指向头结点之前)就落后第二个指针 n 个节点。
 接着两者同时移动，当第二个移动到尾节点时，第一个节点的下一个节点就是要删除的结点:
 这里面还用到了 Dummy 节点，因为有可能删除的是头结点
 */

func removeNthFromEnd(head: ListNode<Int>?,_ n: Int) -> ListNode<Int>? {
    guard let head = head else {//如果空链表
        return nil
    }
    
    let dummy = ListNode(0)
    dummy.next = head
    var prev: ListNode? = dummy //前指针
    var post: ListNode? = dummy //后指针
    
    //设置后一个节点初始位置
    for _ in 0 ..< n {
        if post == nil {
            break
        }
        post = post!.next
    }
    
    //同时移动前后结点
    while post != nil && post!.next != nil {
        prev = prev!.next
        post = post!.next
    }
    
    //删除结点
    prev!.next = prev!.next!.next
    
    return dummy.next
}

/*:
 
 ## 总结
 
 这次用 Swift 实现了链表的基本结构，
 并且实战了链表的几个技巧。
 在结尾处，Swift 处理链表还有两个细节问题:
 
 - 一定要注意头结点可能就是nil,所以给定链表，要看清楚 heade 是不是 optional，在判断是不是要处理这种边界条件。
 - 注意每个节点的 next 可能是nil。如果不为nil,请用 ‘!’修饰变量。在赋值的时候，也请注意"!"将 optional 节点传给非 optional 节点的情况。
 
 */











