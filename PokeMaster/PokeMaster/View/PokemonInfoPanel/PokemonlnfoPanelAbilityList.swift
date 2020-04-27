//
//  PokemonlnPanelAbilityList.swift
//  PokeMaster
//
//  Created by YueWen on 2020/4/27.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI

extension PokemonInfoPanel {
    
    /// 技能列表
    struct AbilityList: View {
        let model: PokemonViewModel
        let abilityModels: [AbilityViewModel]?
        
        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text("技能")
                    .font(.headline)
                    .fontWeight(.bold)
                if abilityModels != nil {
                    ForEach(abilityModels!) { ability in
                        // 技能名称
                        Text(ability.name)
                            .font(.subheadline)
                            .foregroundColor(self.model.color)
                        //技能描述
                        Text(ability.descriptionText)
                            .font(.footnote)
                        .foregroundColor(Color(hex: 0xAAAAAA))
                        .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .frame(maxWidth: .infinity,alignment: .leading)
        }
    }
}



struct PokemonlnfoPanelAbilityList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoPanel.AbilityList(model: .sample(id: 1), abilityModels: AbilityViewModel.sample(pokemonID: 1))
    }
}
