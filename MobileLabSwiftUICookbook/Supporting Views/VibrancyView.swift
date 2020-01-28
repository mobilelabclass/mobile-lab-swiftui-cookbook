//
//  VibrancyView.swift
//  MobileLabSwiftUICookbook
//
//  Created by Nien Lam on 10/8/19.
//  Copyright © 2020 Mobile Lab. All rights reserved.
//

import SwiftUI

struct VibrancyView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<VibrancyView>) -> UIVisualEffectView {
        let effect = UIBlurEffect(style: .light)
        return UIVisualEffectView(effect: effect)
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<VibrancyView>) {
    }
}
