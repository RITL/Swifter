//
//  CalculatorButtonItem.swift
//  SwiftUIDemo
//
//  Created by YueWen on 2020/1/15.
//  Copyright © 2020 YueWen. All rights reserved.
//

import Foundation
import CoreGraphics

/// 按钮类型
enum CalculatorButtonItem {
    
    /// 运算符
    enum Op: String {
        case plus = "+"
        case minus = "-"
        case divide = "/"
        case multiply = "x"
        case equal = "="
    }
    
    /// 命令按钮
    enum Command: String {
        case clear = "A/C"
        case flip = "+/-"
        case percent = "%"
    }
    
    /// 数字按钮
    case digit(Int)
    /// 小数点
    case dot
    /// 操作符
    case op(Op)
    /// 命令按钮
    case command(Command)
}



extension CalculatorButtonItem {
    
    // 显示的文本
    var title: String {
        switch self {
        case .digit(let value): return "\(value)"
        case .dot: return "."
        case .op(let op): return op.rawValue
        case .command(let command): return command.rawValue
        }
    }
    
    // 按钮大小
    var size: CGSize {
        CGSize(width: 88, height: 88)
    }
    
    // 背景色名称
    var backgroundName: String {
        switch self {
        case .digit, .dot: return "digitBackground"
        case .op: return "operatorBackground"
        case .command: return "commandBackground"
        }
    }
}

extension CalculatorButtonItem: Hashable {}
