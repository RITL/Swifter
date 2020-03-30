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

    /// @State 修饰的值，在SwiftUI内部会被自动转换为一对setter和getter方法
    /// 对这个属性进行赋值的操作将会触发View的刷新。
    /// body会被再次调用，底层渲染引擎将会找出界面上被改变的部分
    /// 根据新的属性值计算出新的View,进行刷新
    @State private var brain: CalculatorBrain = .left("0")
    
    var body: some View {
        
        VStack(spacing: 12) {
            
            Spacer()//充满屏的空白
            
            Text(brain.output)//文本内容
                .font(.system(size: 76))
                .minimumScaleFactor(0.5)
                .padding(.trailing, 24 * scale)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            
            CalculatorButtonPad(brain: $brain)//底部键盘
                .padding(.bottom)
        }
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




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            ContentView()
//            ContentView().previewDevice("iPad Pro (11-inch)")
//            ContentView().previewDevice("iPhone SE")
        }
    }
}







