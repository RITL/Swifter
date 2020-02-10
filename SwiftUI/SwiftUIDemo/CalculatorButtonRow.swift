//
//  CalculatorButtonRow.swift
//  SwiftUIDemo
//
//  Created by YueWen on 2020/2/10.
//  Copyright © 2020 YueWen. All rights reserved.
//

import SwiftUI

struct CalculatorButtonRow: View {
    
    let row: [CalculatorButtonItem]
    var body: some View {
        HStack {
            ForEach(row, id: \.self) { item in
                CalculatorButton(title: item.title,
                                 size: item.size,
                                 backgroundColorName: item.backgroundName) {
                                    print("Button: \(item.title)")
                }
            }
        }
    }
}

struct CalculatorButtonRow_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButtonRow(row: [.digit(1),.digit(2),.digit(3),.op(.plus)])
    }
}
