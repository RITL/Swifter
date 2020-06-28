//
//  LandmarkList.swift
//  BuildingListsAndNavigation
//
//  Created by YueWen on 2020/6/28.
//  Copyright © 2020 YueWen. All rights reserved.
//

import SwiftUI

struct LandmarkList: View {
    var body: some View {
        NavigationView {
            List(landmarkData) { landmark in
                //navigation跳转
                NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                    LandmarkRow(landmark: landmark)
                }
            }
        .navigationBarTitle(Text("Landmarks"))
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 6s", "iPhone XS Max"], id: \.self) { deviceName in
             LandmarkList()
            .previewDevice(PreviewDevice(rawValue: deviceName))
        }
       
        
    }
}
