//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by YueWen on 2019/9/2.
//  Copyright © 2019 YueWen. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    var body: some View {
        VStack(spacing: 2) {
            Spacer()
            Text("0")
                .font(.system(size: 76))
                .minimumScaleFactor(0.5)
                .padding(.trailing, 24)
                .lineLimit(1)
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       alignment: .trailing)
            
            CalculatorButtonPad()
                .padding(.bottom)
        }
       
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
