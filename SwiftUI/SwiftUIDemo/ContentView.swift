//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by YueWen on 2019/9/2.
//  Copyright © 2019 YueWen. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    // 废弃row, 使用pad
    let row: [CalculatorButtonItem] = [
        .digit(1), .digit(2), .digit(3), .op(.plus),
    ]
    
    
    let pad: [[CalculatorButtonItem]] = [
        
        [.command(.clear), .command(.flip),
        .command(.percent), .op(.divide)],
        
        [.digit(7), .digit(8), .digit(9), .op(.multiply)],
        [.digit(4), .digit(5), .digit(6), .op(.minus)],
        [.digit(1), .digit(2), .digit(3), .op(.plus)],
        [.digit(0), .dot, .op(.equal)]
    ]
    
    
    var body: some View {
        
        
        //        Text("青岛地铁2.5.6 测试版本(含帮你省、活动盒子key、建行、推送) \n\n 2020-02-07 16:47: \n 1、修复钱包界面由于未开通钱包导致的周卡不显示问题 \n\n 2020-02-06 17:10: \n 1、修复支付管理界面上方Banner不显示的问题 \n 2、首充完毕后可弹出赠卡信息弹窗并进入卡卷包 \n 2020-01-21 13:58 :  \n 1、钱包订单追加订单号 \n 2020-01-20 15:28 : \n 1、包含建行钱包所有的内容 \n 2、钱包首页权益介绍适配新大小、追加点击事件跳转<隐私协议> \n 3、公交码右上角优惠根据默认方式是否是钱包 程橘黄色以及灰色 \n 4、公交右侧享8折优惠图标，并支持banner的所有跳转方式 \n 5、钱包作为默认支付方式时后面加入 特别描述 \n 6、极光推送(没自测过，可以试试、记得打开接收推送开关) \n 7、公交灰名单、以及中英文适配(由于太多，会有遗漏，发现没适配的还请告知一下) \n 8、优惠规则、常见问题、钱包充值协议、钱包免密代扣协议 \n 9、支付管理设置钱包默认支付方式失败文案调整 (在钱包空空 后面加个逗号)\n 10、建行周卡")
        //            .font(.system(size: 10))
        //            .lineSpacing(4)
        VStack(spacing: 8) { // 1
            
            ForEach(pad, id: \.self) { row in
                CalculatorButtonRow(row: row)
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct CalculatorButton: View {
    
    let fontSize: CGFloat = 38
    let title: String
    let size: CGSize
    let backgroundColorName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: fontSize))
                .foregroundColor(.white)
                .frame(width: size.width, height: size.height)
                .background(Color(backgroundColorName))
                .cornerRadius(size.width / 2)
        }
    }
}
