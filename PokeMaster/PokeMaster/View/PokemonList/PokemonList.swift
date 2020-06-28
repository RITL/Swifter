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
        // overlay是在当前View上方添加一层另外的View.
        // 行为和ZStack相似，但是overlay会尊重下方的原有View的布局，而不像ZStack中的view那样相互没有约束。
//        .overlay(
//            VStack{
//                Spacer()
//                PokemonInfoPanel(model: .sample(id: 1))
//            }.edgesIgnoringSafeArea(.bottom)
//        )
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
