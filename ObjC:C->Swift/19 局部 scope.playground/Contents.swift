//: Playground - noun: a place where people can play

import UIKit

/*:
 C 系语言中在方法内部我们是可以任意添加成对的大括号 {}来限定代码的作用该范围的
 这么做一般来说有两个好处

 超过作用于后里面的临时变量就将失效，这不仅可以使方法内的命名更加容易
 也使得那些不被需要的引用的回收提前进行了，可以稍微提高一些代码的效率
 
 另外，在合适的位置插入括号也有利于方法的梳理
 对于那些不太方便提取一个单独方法
 但是又应该和当前方法内的其他部分进行一些区分的代码
 使用大括号可以将这样的结构进行一个相对自然地划分

 */

/*
 如果我们要在 ObjC 中用代码构建UI的话，一般会选择在 -loadView 里写一些类似这样的代码:
*/

/*:
```
 - (void)loadView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,0,320,480)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(150,30,200,40)];
    titleLabel.textColor = UIColor.redColor;
    titleLabel.text = @"Title";
    [view addSubview:titleLabel];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(150,80,200,40)];
    textLabel.textColor = UIColor.redColor;
    textLabel.text = @"Text";
    [view addSubview:textLabel];
    
    self.view = view;
}
 ```
 */

/*
 这里只添加了两个 view,就已经够让人心烦的了
 真实的界面当然会比这个复杂很多，想想看，如果有十来个 view 的话，这段代码就会变成什么样子吧
 
 我们需要考虑对各个子 view 的命名，以确保他们的意义明确
 如果我们在上面的代码中把某个配置 textLabel 的代码写错成了 titleLabel 的话
 编译器也不会给我们任何警告
 
 这种 bug 是非常难以发现的，因此在类似这种一大堆代码但是又不太可能进行重用的时候
 更推荐使用 局部scope 将他们分割开来
 
 比如上面的代码建议加上括号重写以下形式:
 
 使其更专注与于每个代码块:
 */

/*:
 ```
 - (void)loadView
 {
     UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,0,320,480)];
    {
         UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(150,30,200,40)];
         titleLabel.textColor = UIColor.redColor;
         titleLabel.text = @"Title";
         [view addSubview:titleLabel];
    }
 
    {
         UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(150,80,200,40)];
         textLabel.textColor = UIColor.redColor;
         textLabel.text = @"Text";
         [view addSubview:textLabel];
    }
     self.view = view;
 }
 ```
 */

 
 /*
 在 Swift 中，直接使用大括号的写法是不支持的
 因为这和闭包的定义产生了冲突
 如果我们相类似的使用 局部scope 来分隔代码的话
 一个不错的选择是定义一个接收 ()->() 作为函数的全局方法，然后执行它
 */

func local(_ closure: ()->()){
    closure()
}

/*
 在使用时，可以利用尾随闭包的特性模拟局部 scope:
 */

class UIViewController1: UIViewController {
   
    override func loadView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        view.backgroundColor = .white
        
        local {
            let titleLabel = UILabel(frame: CGRect(x: 150, y: 30, width: 200, height: 40))
            titleLabel.textColor = .red
            titleLabel.text = "Title"
            view.addSubview(titleLabel)
        }
        
        local {
            let textLabel = UILabel(frame: CGRect(x: 150, y: 80, width: 200, height: 40))
            textLabel.textColor = .red
            textLabel.text = "Text"
            view.addSubview(textLabel)
        }
        
        self.view = view
    }
}

/*
 不过在 Swift2.0 中，为了处理异常
 Apple 加入了 do 这个关键字来作为捕获异常的作用于
 
 这一功能恰好为我们提供了一个完美的局部作用域，现在可以简单的实用 do 来分隔代码了:
 */

do {
    let textLabel = UILabel(frame: CGRect(x: 150, y: 80, width: 200, height: 40))
    //...
}


/*
 在 ObjC 中还有一个很棒的技巧是使用 GUN C 的`声明拓展`来在限制局部作用域的时候同时进行赋值
 运用得当的话，可以是代码更加紧凑和整洁
 
 比如上面的 titleLabel 如果我们需要保留一个引用的话，在 ObjC 中可以写为:
 */

/*:
```
self.titleLabel = ({
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(150,30,20,50)];
    label.textColor = UIColor.redColor;
    label.text = @"Title";
    [view addSubview:label];
    label;
})
 ```
*/

/*
 Swift 里当然没有 GUN C 的拓展，但是使用匿名的闭包的话，写出类似的代码也不是难事:
 */

let titleLabel: UILabel = {
    let label = UILabel(frame: CGRect(x: 150, y: 30, width: 200, height: 40))
    label.textColor = .red
    label.text = "Title"
    return label
}()

// 这也是一种隔离代码的很好的方式。
