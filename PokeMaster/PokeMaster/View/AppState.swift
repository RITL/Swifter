//
//  AppState.swift
//  PokeMaster
//
//  Created by YueWen on 2020/6/9.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import Foundation


struct AppState {
    //1
    var settings = Settings()
}


extension AppState {
    
    struct Settings {
        enum Sorting: CaseIterable {
            case id, name, color, favorite
        }
        
        var showEnglishName = true
        var sorting = Sorting.id
        var showFavoriteOnly = false
    }
}
