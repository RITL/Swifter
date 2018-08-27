import Foundation

public typealias Task = (_ cancel: Bool) -> Void

public func delay(_ time: TimeInterval,task: @escaping ()->()) -> Task? {
    
    /// 使用 GCD 进行延时操作
    func dispatch_later(block: @escaping ()->()){
        let t = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: t, execute: block)
    }
    
    var closure: (()->Void)? = task//执行的闭包
    var result: Task? //暂时排队的任务
    
    let delayClosure: Task = {//延时执行的任务
        cancel in //是否取消
        if let internalClosure = closure {
            if cancel == false {
                DispatchQueue.main.async(execute: internalClosure)//如果不取消并且任务存在，执行
            }
        }
        closure = nil // 将所有变量置nil
        result = nil
    }
    
    result = delayClosure
    
    dispatch_later {
        if let delayedClosure = result {
            delayedClosure(false)
        }
    }
    
    return result
}


/// 取消
public func cancel(_ task: Task?){
    task?(true)
}
