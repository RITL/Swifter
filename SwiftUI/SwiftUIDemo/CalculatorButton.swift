//
//  CalculatorButton.swift
//  SwiftUIDemo
//
//  Created by YueWen on 2020/2/13.
//  Copyright © 2020 YueWen. All rights reserved.
//

import SwiftUI

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


struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        
        CalculatorButton(title: "1", size: CGSize(width: 100, height: 100), backgroundColorName: "") {
            
            }
    }
}
