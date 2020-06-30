//
//  UserData.swift
//  HandlingUserInput
//
//  Created by YueWen on 2020/6/30.
//  Copyright © 2020 YueWen. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject {
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
    
}

