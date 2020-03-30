//
//  CalculatorBrain.swift
//  SwiftUIDemo
//
//  Created by YueWen on 2020/2/19.
//  Copyright © 2020 YueWen. All rights reserved.
//

import Foundation

/// 计算核心
enum CalculatorBrain {

    case left(String) //数字
    case leftOp (left: String, op: CalculatorButtonItem.Op) //数字 + 符号
    case leftOpRight ( left: String, op: CalculatorButtonItem.Op, right: String) //数字 + 符号 + 数字
    case error //错误


    var output: String {
        var result: String
        switch self {
        //左侧数字显示数字
        case .left(let left): result = left
        //左侧数字+运算符，还是显示数字
        case .leftOp(let left, op: _): result = left
        //按出右侧数字，显示右侧数字
        case .leftOpRight(_, _, let right): result = right
        //错误操作，比如 0做分母
        case .error: return "Error"
        }
        guard let value = Double(result) else { return "Error" }
        return formatter.string(from: value as NSNumber)!
    }


    /// 数字
    private func apply(num: Int) -> CalculatorBrain {
        switch self {
        //变成left传递的数字
        case .left(let left): return .left(left.apply(num: num))
        //变成左 + 运算符 + 0
        case .leftOp(let left, let op): return .leftOpRight(left: left, op: op, right: "0".apply(num: num))
        //变成 左 + 运算符  + 右拼接数字
        case .leftOpRight(let left, let op, let right): return .leftOpRight(left: left, op: op, right: right.apply(num: num))
        //错误，显示0即可
        case .error: return .left("0".apply(num: num))
        }
    }

    /// 小数点
    private func applyDot() -> CalculatorBrain {
        switch self {
        //数字后面直接点击小数点
        case .left(let left): return .left(left.applyDot())
        //点击运算符以后直接点击小数点
        case .leftOp(let left, let op): return .leftOpRight(left: left, op: op, right: "0".applyDot())
        //点击运算符后存在第二个数字后点击小数点
        case .leftOpRight(let left, let op, let right): return .leftOpRight(left: left, op: op, right: right.applyDot())
        //出现错误
        case .error: return .left("0".applyDot())
        }
    }

    /// 运算符
    private func apply(op: CalculatorButtonItem.Op) -> CalculatorBrain {
        switch self {
        case .left(let left): //左侧数字
            switch op {
            //点击运算符，进行运算符拼接
            case .plus, .minus, .multiply, .divide: return .leftOp(left: left, op: op)
            //如果直接点击 = , 显示数字即可
            case .equal: return self
        }

        case .leftOp(let left, let currentOp)://左侧数字加运算符
            switch op {
            //点击了 加 减 乘 除 后返回当前状态即可
            case .plus, .minus, .multiply, .divide: return .leftOp(left: left, op: currentOp)
            // 点击了 =，进行运算
            case .equal:
                if let result = currentOp.calculate(l: left, r: left) { return .leftOp(left: result, op:currentOp) }
                else { return .error }
            }

        case .leftOpRight(let left,let currentOp, let right): //左侧存在数字，中间存在运算符，右侧存在数字
            switch op {
            //点击了 加 减 乘 除, 需要进行运算,然后返回算出的结果加上这个运算符
            case .plus, .minus, .multiply, .divide:
                if let result = currentOp.calculate(l: left, r: right) { return .leftOp(left: result, op: op) }
                else { return .error }
            //如果是等于号
            case .equal:
                if let result = currentOp.calculate(l: left, r: right) { return .left(result) }//算出结果直接显示数字即可
                else { return .error }
            }

        case .error: return self //错误返回自己即可
        }
    }


    private func apply(command: CalculatorButtonItem.Command) -> CalculatorBrain {
        switch command {
        case .clear: return .left("0") //清0操作
        case .flip: //如果是+/-
            switch self {
            //如果单纯的数字，点击的是正负号，进行自身显示变化
            case .left(let left): return .left(left.flipped())
            //如果点击的是运算符,操作一遍 -0
            case .leftOp(let left, let op): return .leftOpRight(left: left, op: op, right: "-0")
            //已经存在数据，右侧数据取反
            case .leftOpRight(let left, let op, let right): return .leftOpRight(left: left, op: op, right: right.flipped())
            //错误
            case .error: return .left("-0")
            }
        case .percent: //百分号
            switch self {
            // 数字直接转变为1/100即可
            case .left(let left): return .left(left.percentaged())
            // 如果是数字加运算符,返回自己，不操作即可
            case .leftOp(_, _): return self
            // 如果已经存在右侧数字，对右侧数字进行百分比
            case .leftOpRight(let left, let op, let right): return .leftOpRight(left: left, op: op, right: right.percentaged())
            // 错误
            case .error: return .left("-0")
            }
        }
    }

    func apply(item: CalculatorButtonItem) -> CalculatorBrain {
        switch item {
        case .digit(let num): return apply(num: num)
        case .dot: return applyDot()
        case .op(let op): return apply(op: op)
        case .command(let command): return apply(command: command)
        }
    }
}


extension String {

    var containsDot: Bool {
        return contains(".")
    }

    /// 是否是负数
    var startWithNegative: Bool {
        return starts(with: "-")
    }

    /// 拼成数字:
    /// 0 + 1 = 01 = 1
    /// 1 + 2 = 12
    func apply(num: Int) -> String {
        return self == "0" ? "\(num)" : "\(self)\(num)"
    }


    /// 小数点
    /// 如果存在小数点直接返回，不存在后面拼接小数点，避免重复点击多次
    func applyDot() -> String {
        return containsDot ? self : "\(self)."
    }

    
    /// 取反
    func flipped() -> String {
        if startWithNegative { //如果是存在负数
            var s = self
            s.removeFirst() //移除-号
            return s
        } else {
            return "-\(self)"
        }
    }
    
    /// 百分比
    func percentaged() -> String {
        return String(Double(self) ?? 0.0 / 100)
    }
}


/// 转换
var formatter: NumberFormatter = {
    let f = NumberFormatter()
    f.minimumFractionDigits = 0
    f.maximumFractionDigits = 8
    f.numberStyle = .decimal
    return f
}()



typealias CalculatorState = CalculatorBrain
typealias CalculatorStateAction = CalculatorButtonItem


struct Reducer {

    static func reduce(state: CalculatorState, action: CalculatorStateAction) -> CalculatorState {
        return state.apply(item: action)
    }
}


extension CalculatorButtonItem.Op {

    /// 开始计算
    func calculate(l: String, r: String) -> String? {

        guard let left = Double(l), let right = Double(r) else { return nil }//没有数字

        let result: Double?
        switch self {
        case .plus: result = left + right
        case .minus: result = left - right
        case .multiply: result = left * right
        case .divide: result = right == 0 ? nil : left / right
        case .equal: fatalError()
        }
        return result.map{ String($0) }
    }

}
