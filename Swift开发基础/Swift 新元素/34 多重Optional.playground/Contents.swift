//: Playground - noun: a place where people can play

// Optional 可是说是 Swift 的一大特色，特完全解决了"有"和"无"这两个困扰了ObjC许久的哲学概念，也使得代码安全性得到了很大的增加。
// 但是一个陷阱或者说一个很容易让人迷惑的概念也随之而来，那就是多重Optional

// 在深入讨论之前，可以先看看 Optional 是什么。
// 使用的类型后加上? 的语法只不过是 Optional 类型的语法糖，而实际上这个类型是一个枚举

//enum Optional<T> : _Reflectable,ExpressibleByNilLiteral {
//    case None
//    case Some(T)
//}

// 在这个定义中，对T没有任何限制，也就是说，是可以在 Optional 中装入任意东西的，甚至也包括 Optional 对象自身。打个形象的比方，如果我们把 Optional 比作一个盒子，实际具体的  String 或者 Int 这样的值比作糖果的话，当打开一个盒子(unwrap)时，可能的结果会有三个 -- 空气 糖果或者另一个盒子

var string: String? = "String"
var anotherString: String?? = string

// 可以很明白的知道 antherString 是 Optional<Optional<String>>.
// 但是除开讲一个Optional值付给多重 Optional以外，也可以将直接的字面量赋值给它

var literalOptional: String?? = "string"

// 这种情况还好，根据类型推断我们只能讲 Optional<String> 放入到 literalOptional中，所以可以猜测它与上面提到的 anotherString 是等效的。
// 但是如果将nil赋值给它的话，情况就有所不同了。

var aNil: String? = nil

var anotherNil: String?? = aNil
var literalNil: String?? = nil

// 此时，anotherNil 与 literalNil 是不等效的！
// anotherNil 是盒子中包了一个盒子，打开内层盒子的时候会发现空气
// 但literalNil是盒子中直接是空气。

if anotherNil != nil {
    print("anotherNil")
}

if literalNil != nil {
    print("literalNil")
}

// 只会输出 anotherNil

// 另一个值得注意的地方是 在 playground运行 或者在用lldb进行调试时，直接使用 po 指令打印 Optional 值的话，为了看起来方便，lldb会将要打印的 Optional 进行展开。
// 如果直接打印上面的 anotherNil 和 literalNil，得到的结果都是nil

/*

(lldb) po anotherNil
nil

(lldb) po literalNil
nil
 
 */


// 如果遇到了多重 Optional 的麻烦的时候，显然对我们没有太大帮助的。
// 可以使用frv -R 命令打印出变量的未加工时的信息

/*

(lldb) fr v -R anotherNil
(Swift.Optional<Swift.Optional<Swift.String>>)
anotherNil = Some{
    //....
}


(lldb) fr v -R literalNil
(Swift.Optional<Swift.Optional<Swift.String>>)
literalNil = None{
    //....
}
 
 */

// 这样就能清晰地分辨出两者的区别了







