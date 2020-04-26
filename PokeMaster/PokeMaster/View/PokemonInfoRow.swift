//
//  PokemonInfoRow.swift
//  PokeMaster
//
//  Created by YueWen on 2020/4/26.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI

struct ToolButtonModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25))
            .foregroundColor(.white)
            .frame(width: 30, height: 30)
        
    }
}

struct PokemonInfoRow: View {
    
    let model = PokemonViewModel.sample(id: 1)
    var body: some View {
        VStack {
            
            HStack {
                Image("Pokemon-\(model.id)")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 4)
                Spacer()
                VStack(alignment: .trailing) {
                    Text(model.name)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                    Text(model.nameEN)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
            }
            .padding(.top, 12)
            
            HStack(spacing: 20) {
                Spacer()
                Button(action: {
                    print("Fav")
                }) {
                    Image(systemName: "star")
                        .modifier(ToolButtonModifier())
                }
                Button(action: {
                    print("Panel")
                }) {
                    Image(systemName: "chart.bar")
                        .modifier(ToolButtonModifier())
                }
                Button(action: {
                    print("Web")
                }) {
                    Image(systemName: "info.circle")
                        .modifier(ToolButtonModifier())
                }
            }
            .padding(.bottom, 12)
        }
        .frame(height: 120)
        .padding(.leading, 40)
        .padding(.trailing, 30)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(model.color, style: StrokeStyle(lineWidth: 4))
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.white,model.color]),
                            startPoint: .leading,
                            endPoint: .trailing)
                )
            }.padding(.horizontal)
        )
        
    }
}

struct PokemonInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoRow()
    }
}
