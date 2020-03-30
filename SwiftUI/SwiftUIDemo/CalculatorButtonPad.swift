//
//  CalculatorButtonPad.swift
//  SwiftUIDemo
//
//  Created by YueWen on 2020/2/10.
//  Copyright © 2020 YueWen. All rights reserved.
//

import SwiftUI

struct CalculatorButtonPad: View {
    
    @Binding var brain: CalculatorBrain
    
    let pad: [[CalculatorButtonItem]] = [
        
        [.command(.clear), .command(.flip),
        .command(.percent), .op(.divide)],
        
        [.digit(7), .digit(8), .digit(9), .op(.multiply)],
        [.digit(4), .digit(5), .digit(6), .op(.minus)],
        [.digit(1), .digit(2), .digit(3), .op(.plus)],
        [.digit(0), .dot, .op(.equal)]
    ]
    
    var body: some View {
        VStack(spacing: 9) {
            ForEach(pad, id: \.self) { row in
                CalculatorButtonRow(brain: self.$brain, row: row)
            }
        }
    }
}

struct CalculatorButtonPad_Previews: PreviewProvider {
    static var previews: some View {
//        CalculatorButtonPad()
        Text("123")
    }
}
