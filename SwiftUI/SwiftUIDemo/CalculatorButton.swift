//
//  CalculatorButton.swift
//  SwiftUIDemo
//
//  Created by YueWen on 2019/9/6.
//  Copyright © 2019 YueWen. All rights reserved.
//

import Foundation
import SwiftUI


struct CalculatorButton: View {

    let fontSize: CGFloat = 38
    let titie: String
    let size: CGSize
    let backgroundColorName: String
    let action: () -> Void
    
    var body: some View {
        return Button(action: action) {
                Text(titie)
                .font(.system(size: fontSize))
                .foregroundColor(.white)
                .frame(width: size.width, height: size.height)
                .background(Color(backgroundColorName))
                .cornerRadius(size.width / 2)
            
        }
    }
}
