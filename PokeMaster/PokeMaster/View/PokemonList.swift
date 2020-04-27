//
//  PokemonList.swift
//  PokeMaster
//
//  Created by YueWen on 2020/4/26.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI

struct PokemonList: View {
    
    @State var expandingIndex: Int?
    
    var body: some View {
        
        //        // 分割线暂时没有API实现
        //        List(PokemonViewModel.all) { pokemon in
        //            PokemonInfoRow(model: pokemon, expanded: false)
        //        }
        
        ScrollView {
            ForEach(PokemonViewModel.all) { pokemon in
                PokemonInfoRow(
                    model: pokemon,
                    expanded: self.expandingIndex == pokemon.id
                ).onTapGesture {
                    withAnimation(
                        .spring(
                            response: 0.55,
                            dampingFraction: 0.425,
                            blendDuration: 0
                        )
                    )
                    {
                        if self.expandingIndex == pokemon.id {
                            self.expandingIndex = nil
                        }else {
                            self.expandingIndex = pokemon.id
                        }
                    }
                }
            }
        }
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
