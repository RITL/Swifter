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
    
    func apply(_ item: CalculatorButtonItem) {
        brain = brain.apply(item: item)
        history.append(item)
    }
}
