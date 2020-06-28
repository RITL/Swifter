//
//  SettingView.swift
//  PokeMaster
//
//  Created by YueWen on 2020/4/28.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI
import Combine


class Settings: ObservableObject {
    
    enum AccountBehavior: CaseIterable {
        case register, login
    }
    
    enum Sorting: CaseIterable {
        case id, name, color, favorite
    }
    
    @Published var accountBehavior = AccountBehavior.login
    @Published var email = ""
    @Published var password = ""
    @Published var verifyPassword = ""
    
    @Published var showEnglishName = true
    @Published var sorting = Sorting.id
    @Published var showFavoriteOnly = false
}


struct SettingView: View {
    
    @EnvironmentObject var store: Store
    var settingBinding: Binding<AppState.Settings> {
        $store.appState.settings
    }
    
    @ObservedObject var settings = Settings()
    
    var body: some View {
        Form {
            accountSection
            optionalSection
            actionSection
        }
    }
    
    /// 注册/登录 切换
    var accountSection: some View {
        Section(header: Text("账户")) {
            Picker(
                selection: $settings.accountBehavior,
                label: Text("")) {
                    ForEach(Settings.AccountBehavior.allCases,id: \.self) {
                        Text($0.text)
                    }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            TextField("电子邮箱", text: $settings.email)
            SecureField("密码", text: $settings.password)
            
            if settings.accountBehavior == .register {
                SecureField("确认密码", text: $settings.verifyPassword)
            }
            
            Button(settings.accountBehavior.text) {
                print("登录/注册")
            }
        }
    }
    
    
    /// 选项
    var optionalSection: some View {
        Section(header: Text("选项")) {
            Toggle(isOn: settingBinding.showEnglishName) {
                Text("显示英文名")
            }
            Picker(selection: settingBinding.sorting, label: Text("排序方式")) {
                ForEach(AppState.Settings.Sorting.allCases, id: \.self) {
                    Text($0.text)
                }
            }
            Toggle(isOn: settingBinding.showFavoriteOnly) {
                Text("只显示收藏")
            }
        }
    }
    
    
    /// 清除缓存
    var actionSection: some View {
        Section {
            Button(action: {
                print("清空缓存")
            }) {
                Text("清空缓存").foregroundColor(.red)
            }
        }
    }
}


extension AppState.Settings.Sorting {
    
    var text: String {
        switch self {
        case .id: return "ID"
        case .name: return "名字"
        case .color: return "颜色"
        case .favorite: return "最爱"
        }
    }
}


extension Settings.AccountBehavior {
    var text: String {
        switch self {
        case .register: return "注册"
        case .login: return "登录"
        }
    }
}


struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        
        let store = Store()
        store.appState.settings.sorting = .color
        return SettingView().environmentObject(store)
    }
}



