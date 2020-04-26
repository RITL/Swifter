//
//  CalculatorModel.swift
//  SwiftUIDemo
//
//  Created by YueWen on 2020/3/30.
//  Copyright © 2020 YueWen. All rights reserved.
//

import Foundation
import Combine

/// ObservableObject

/// 使用多view的交互，使用引用的计算Model
class CalculatorModel: ObservableObject {
    
    /// 使用 `Published`
    /// 系统自动生产类似`willSet`的`send`操作
    /// ```
    /// var brain: CalculatorBrain = .left("0") {
    ///    willSet { objectWillChange.send() }
    /// }
    /// ```
    /// 在 `ObservableObject` 中，如果没有定义 `objectWillChange，编译器会自动生成他
    /// ```
    /// let objectWillChange = PassthroughSubject<Void, Never>()
    /// ```
    /// 在被标注为 `@Published` 的属性发生变更时，自动去调用 `objectWillChange.send()`
    @Published var brain: CalculatorBrain = .left("0")
    
    /// 回溯操作的数组
    @Published var history: [CalculatorButtonItem] = []
    
    ///
    /// 记录history数组中记录的操作步骤描述链接起来，作为履历的输出字符串
    var historyDetail: String {
        (history.map { $0.title }).joined()
    }
    
    /// 暂时保存的 被回朔 的操作，暂存
    var temporaryKept: [CalculatorButtonItem] = []
    
    /// 总数
    var totalCount: Int {
        history.count + temporaryKept.count
    }
    
    /// 当前滑块表示的index值
    /// 维护 history 和  temproaryKept
    var slidingIndex: Float = 0 {
        didSet {
            keepHistory(upTo: Int(slidingIndex))
        }
    }
    
    
    func apply(_ item: CalculatorButtonItem) {
        brain = brain.apply(item: item)
        history.append(item)
        
        //将temporaryKept清空，并将 slidingIndex 设置到 最后一步
    }
    
    
    /// 根据 slidingIndex进行数据的重新分配
    func keepHistory(upTo index: Int) {
        precondition(index <= totalCount, "Out of index.")
        
        let total = history + temporaryKept
        
        history = Array(total[..<index])
        temporaryKept = Array(total[index...])
        
        brain = history.reduce(CalculatorBrain.left("0")) { result, item in
            result.apply(item: item)
        }
    }
}
