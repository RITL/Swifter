//
//  PokemonInfoPanel.swift
//  PokeMaster
//
//  Created by YueWen on 2020/4/27.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI

struct PokemonInfoPanel: View {
    
    let model: PokemonViewModel
    /// 能力
    var abilities: [AbilityViewModel] {
        AbilityViewModel.sample(pokemonID: model.id)
    }
    
    /// 顶部的指示条
    var topIndicator: some View {
        RoundedRectangle(cornerRadius: 2)
            .frame(width: 40, height: 6)
            .opacity(0.2)
    }
    
    /// 描述
    var pokemonDescription: some View {
        Text(model.descriptionText)
            .font(.callout)
            .foregroundColor(Color(hex: 0x666666))
            //保持理想尺寸，不被上层View截断
            // 默认为显示全部文本，想要限制行数，.lineLimit(x)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            topIndicator
            Header(model: model)
            pokemonDescription
            Divider()
            AbilityList(
                model: model,
                abilityModels: abilities)
        }
        .padding(
            EdgeInsets(
                top: 12,
                leading: 30,
                bottom: 30,
                trailing: 30
            )
        )
            
            .background(Color.white)
            .cornerRadius(20)
            .fixedSize(horizontal: false, vertical: true)
    }
}



struct PokemonInfoPanel_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoPanel(model: .sample(id: 1))
    }
}
