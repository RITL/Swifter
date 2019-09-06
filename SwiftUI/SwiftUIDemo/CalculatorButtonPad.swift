//
//  CalculatorButtonPad.swift
//  SwiftUIDemo
//
//  Created by YueWen on 2019/9/6.
//  Copyright © 2019 YueWen. All rights reserved.
//

import Foundation
import SwiftUI

struct CalculatorButtonPad: View {

    let pad: [[CalculatorButtonItem]] = [
        [.command(.clear),.command(.flip),.command(.precent),.op(.divde)],
        [.digit(7),.digit(8),.digit(9),.op(.multiply)],
        [.digit(4),.digit(5),.digit(6),.op(.minus)],
        [.digit(1),.digit(2),.digit(3),.op(.plus)],
        [.digit(0),.dot,.op(.equal)]
    ]
    
    var body: some View {
        VStack(spacing: 8) {
            
            ForEach(pad, id: \.self) { row in
                CalculatorButtonRow(row: row)
            }
        }
    }
}
