//
//  Store.swift
//  PokeMaster
//
//  Created by YueWen on 2020/6/9.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import Combine

class Store: ObservableObject {
    
    @Published var appState = AppState()
}
