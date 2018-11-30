//: Playground - noun: a place where people can play

import UIKit

/*:
 # 二叉树
 
 ## 二叉树的基本概念
 
 二叉树中每个结点最多有两个子节点，
 一般称为左子节点和右子节点，并且二叉树的子树有左右之分，其次序不能任意点到。
 节点的Swift实现:
 */

class TreeNode<T> {
    
    var val: T
    var left: TreeNode<T>?
    var right: TreeNode<T>?
    
    init(_ val: T) {
        self.val = val
    }
}

/*:
 一般在面试中，会给定二叉树的根节点。
 要访问任何其他节点，只要从起始节点开始往左/右走即可。
 
 在二叉树中，节点的层次从根开始定义，根为第一层，树中节点的最大层次为树的深度。
 */

func maxDepth<T>(root: TreeNode<T>?) -> Int {
    guard let root = root else {
        return 0
    }
    return max(maxDepth(root: root.left), maxDepth(root: root.right)) + 1 //左子树和右子树的最大深度 + 1(根节点)
}

/*:
 一般面试中，最常见的是二叉查找树，它是一种特殊的二叉树。
 它的特点就是左子树中节点的值都小于根节点的值，
 右子树中节点的值都大于根节点的值。
 
 那么问题：给你一颗二叉树，怎么判断它是二叉查找树？
 */

func isValidBST<T: Comparable>(root: TreeNode<T>?) -> Bool {
    
    func _helper(node: TreeNode<T>?,_ min: T?,_ max: T?) -> Bool {
        
        guard let node = node else { //空节点
            return true
        }
        
        //所有的右子节点都必须大于根节点
        if let min = min,node.val <= min {
            return false
        }
        
        //所有的左子节点都必须大于根节点
        if let max = max,node.val >= max {
            return false
        }
        
        return _helper(node: node.left, min, node.val)//比较右边
            && _helper(node: node, node.val, max)//比较左边
    }
    
    return _helper(node: root, nil, nil)
}

/*:
 - 二叉树本身是由递归定义的，所以原理上所有二叉树的题目都是可以用递归来解
 - 二叉树这类题目很容易就会牵扯到往左往右走，所以写helper函数要想到有两个相对应的参数
 - 记得处理结点为nil的参数，尤其是要注意根节点为nil的情况
 */

/*:
 ## 二叉树的遍历
 
 最常见的树的遍历有3中，前序，中序，后序遍历。
 这三种写法类似，无非是递归的顺序略有不同。
 面试时候有可能考察的是用非递归的方法写这三种遍历: 用栈实现:
 */


/// 前序遍历
func preorderTraversal<T>(root: TreeNode<T>?) -> [T]{
    var res = [T]()
    var stack = [TreeNode<T>]()
    var node = root
    
    while !stack.isEmpty || node != nil {
        if node != nil {
            res.append(node!.val)
            stack.append(node!)
            node = node!.left
        }else {
            node = stack.removeLast().right
        }
    }
    return res
}



/// 中序遍历
func inorderTraversal<T>(root: TreeNode<T>?) -> [T]{
    var res = [T]()
    var stack = [TreeNode<T>]()
    var node = root
    
    while !stack.isEmpty || node != nil {
        if node != nil {
            stack.append(node!)
            node = node!.left
        }else {
            res.append(stack.last!.val)
            node = stack.removeLast().right
        }
    }
    
    return res
}



/// 后序遍历
func posorderTravelsal<T>(root: TreeNode<T>?) -> [T]{
    guard let root = root else {
        return [T]()
    }
    
    var res = [T]()
    var stack = [TreeNode<T>]()
    var node = root
    
    
}
