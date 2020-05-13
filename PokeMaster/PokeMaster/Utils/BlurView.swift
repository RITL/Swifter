//
//  PokemonInfoBlurView.swift
//  PokeMaster
//
//  Created by YueWen on 2020/4/27.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import SwiftUI
import UIKit

struct BlurView: UIViewRepresentable {
    
    let style: UIBlurEffect.Style
    
    init(style: UIBlurEffect.Style) {
        print("Init")
        self.style = style
    }
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        
        print("makeUIView")
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.heightAnchor
                .constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor
                .constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {
//        print("UpdateUIView")
        //针对获取的view,获得UIVisualEffectView
        guard let blurView = (uiView.subviews.filter { $0 is UIVisualEffectView }).first else {
            return
        }
        
        (blurView as! UIVisualEffectView).effect = UIBlurEffect(style: style)
        
        print("UpdateUIView - style = \(style)")
    }
}

extension View {
    
    func blurBackground(style: UIBlurEffect.Style) -> some View {
        ZStack {
            BlurView(style: style)
            self
        }
    }
}

struct PokemonInfoBlurView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
//        BlurView(style: .light)
    }
}
