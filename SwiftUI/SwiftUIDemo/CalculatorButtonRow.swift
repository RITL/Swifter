//
//  CalculatorButtonRow.swift
//  SwiftUIDemo
//
//  Created by YueWen on 2019/9/6.
//  Copyright © 2019 YueWen. All rights reserved.
//

import Foundation
import SwiftUI

struct CalculatorButtonRow : View {
    let row: [CalculatorButtonItem]
    var body: some View {
        
        HStack {
            ForEach(row,id:\.self) { item in
                CalculatorButton(
                    titie: item.title,
                    size: item.size,
                    backgroundColorName: item.backgroundColorName) {
                        print("Button \(item.title)")
                }
            }
        }
    }
}
