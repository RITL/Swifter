//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by YueWen on 2019/9/2.
//  Copyright © 2019 YueWen. All rights reserved.
//

import SwiftUI

// 第一种全局缩放适配SE,简单粗暴，不推荐
let scale: CGFloat = UIScreen.main.bounds.width / 414

struct ContentView: View {
    
    var body: some View {
        
        VStack(spacing: 12) {
            
            Spacer()//充满屏的空白
            Text("0")//文本内容
                .font(.system(size: 76))
                .minimumScaleFactor(0.5)
                .padding(.trailing, 24)
                .lineLimit(1)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            
            CalculatorButtonPad()//底部键盘
                .padding(.bottom)
        }
        .scaleEffect(scale)
    }
}


// MARK: 使用frame填充Text,使用Spacer设置键盘往下推
//VStack(spacing: 12) {
//
//    HStack {
//        Spacer()//充满屏的空白
//          Text("3213213213213213213213213210")//文本内容
//              .font(.system(size: 76))
//              .minimumScaleFactor(0.5)
//              .padding(.trailing, 24)
//              .lineLimit(1)
//
//    }.frame(maxHeight: .infinity, alignment: .bottom)
//
//
//    CalculatorButtonPad()//底部键盘
//        .padding(.bottom).frame(alignment: .bottom)
//}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            ContentView()
            ContentView().previewDevice("iPhone Xs Max")
            ContentView().previewDevice("iPhone SE")
        }
        
        //        Text("+")
        //            .font(.title)
        //            .foregroundColor(.white)
        //            .background(Color.orange)
        //            .padding()
        //            .background(Color.blue)
    }
}





//        Text("青岛地铁2.5.6 测试版本(含建行、帮你省、活动盒子key、推送) \n\n 2020-02-12 11:00 \n - 修复退登之后，点击卡券包--待领取--提示：请先登录，返回到待领取页面，再点击一下待领取，就提示404了的问题 \n  \n 2020-02-11 12:30  \n 1、 修复钱包购买周卡后钱包主页金额显示不变的问题 \n 2、 修复账号被顶掉后，进入购买周卡一直加载的问题 \n  2020-02-11 9:30 :\n 1、修复在4.7寸手机支付管理提示标签上偏移问题 \n 2020-02-07 16:47: \n 1、修复钱包界面由于未开通钱包导致的周卡不显示问题 \n 2020-02-06 17:10: \n 1、修复支付管理界面上方Banner不显示的问题 \n 2、首充完毕后可弹出赠卡信息弹窗并进入卡卷包 \n 2020-01-21 13:58 :  \n 1、钱包订单追加订单号 \n 2020-01-20 15:28 : \n 1、包含建行钱包所有的内容 \n 2、钱包首页权益介绍适配新大小、追加点击事件跳转<隐私协议> \n 3、公交码右上角优惠根据默认方式是否是钱包 程橘黄色以及灰色 \n 4、公交右侧享8折优惠图标，并支持banner的所有跳转方式 \n 5、钱包作为默认支付方式时后面加入 特别描述 \n 6、极光推送(没自测过，可以试试、记得打开接收推送开关) \n 7、公交灰名单、以及中英文适配(由于太多，会有遗漏，发现没适配的还请告知一下) \n 8、优惠规则、常见问题、钱包充值协议、钱包免密代扣协议 \n 9、支付管理设置钱包默认支付方式失败文案调整 (在钱包空空 后面加个逗号)\n 10、建行周卡")
//            .font(.system(size: 10))
//            .lineSpacing(4)

