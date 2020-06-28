//
//  ContentView.swift
//  CreatingAndCombiningViews
//
//  Created by YueWen on 2020/6/28.
//  Copyright © 2020 YueWen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MapView()
                .edgesIgnoringSafeArea(.top)
                .frame(height: 300)
            
            CircleImage()
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text("上实中心")
                    .font(.title)
                HStack(alignment: .top) {
                    Text("崂山区香港东路195号")
                        .font(.subheadline)
                    Spacer()
                    Text("青岛")
                        .font(.subheadline)
                }
            }
            .padding()
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
