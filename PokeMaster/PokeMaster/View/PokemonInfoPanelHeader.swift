//
//  PokemonInfoHeader.swift
//  PokeMaster
//
//  Created by YueWen on 2020/4/27.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI

extension PokemonInfoPanel {
    
    struct Header: View {
        let model: PokemonViewModel
        
        var body: some View {
            HStack(spacing: 18) {
                pokemonIcon
                nameSpecies
                verticalDivider
                VStack(spacing: 12) {
                    bodyStatus
                    typeInfo
                }
            }
        }
        
        /// 图标
        var pokemonIcon: some View {
            Image("Pokemon-\(model.id)")
                .resizable()
                .frame(width: 68, height: 68)
        }
        
        /// 名字
        var nameSpecies: some View {
            VStack (spacing: 10){
                VStack {
                    Text(model.name)
                        .foregroundColor(model.color)
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                    
                    Text(model.nameEN)
                        .foregroundColor(model.color)
                        .font(.system(size: 13))
                        .fontWeight(.bold)
                }
                
                Text(model.genus)
                    .foregroundColor(.gray)
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                
            }
        }
        
        /// 垂直线
        var verticalDivider: some View {
            RoundedRectangle(cornerRadius: 0.5)
                .frame(width: 1, height: 44)
                .foregroundColor(Color.init(hex: 000000, alpha: 0.1))
        }
        
        /// 信息
        var bodyStatus: some View {
            VStack {
                HStack {
                    Text("身高")
                        .foregroundColor(.gray)
                        .font(.system(size: 11))
                    Text(model.height)
                        .font(.system(size: 11))
                        .foregroundColor(model.color)
                }
                HStack {
                    Text("体重")
                        .foregroundColor(.gray)
                        .font(.system(size: 11))
                    Text(model.weight)
                        .font(.system(size: 11))
                        .foregroundColor(model.color)
                }
            }
        }
        
        /// 类型
        var typeInfo: some View {
            HStack {
                ForEach(model.types) { (type) in
                    /// 使用ZStack
                    /// 使用该方法，背景色会固定，文字可能会超出背景色范围
                    ZStack {
                        RoundedRectangle(cornerRadius: 7)
                            .fill(type.color)
                            .frame(width: 36, height: 14)

                        Text(type.name)
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                    }

                    /// 不使用ZStack,使用backgroundView
                    /// 使用该方法，文字超出会出现...
//                    Text(type.name)
//                        .font(.system(size: 10))
//                        .foregroundColor(.white)
//                        .frame(width: 36, height: 14)
//                        .background(
//                            RoundedRectangle(cornerRadius: 7)
//                                .fill(type.color)
//
//                    )
                }
            }
        }
    }
}


struct PokemonInfoHeader_Previews: PreviewProvider {
    static var previews: some View {
        //        PokemonInfoHeader()
        PokemonInfoPanel.Header(model: .sample(id: 1))
    }
}
