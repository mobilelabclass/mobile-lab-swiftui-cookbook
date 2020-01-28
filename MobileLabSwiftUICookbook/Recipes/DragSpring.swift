//
//  DragSpring.swift
//  MobileLabSwiftUICookbook
//
//  Created by Sebastian Buys on 6/11/19.
//  Copyright © 2020 Mobile Lab. All rights reserved.
//

import SwiftUI

struct DragSpring: View {
    @GestureState var translation: CGSize = CGSize()
    
    var body: some View {
        let drag = DragGesture(minimumDistance: 10.0, coordinateSpace: CoordinateSpace.global)
            .updating($translation, body: { (gestureState, translation, transaction) in
                translation = gestureState.translation
            })
        
        return ZStack {
            Ellipse()
                .fill(Color.red)
                .frame(width: 100.0 + abs(translation.width) / 10.0, height: 100.0 + abs(translation.height) / 10.0, alignment: .center)
                .offset(translation)
                .gesture(drag)
                .animation(.spring())
        }
    }
}

struct DragSpring_Previews : PreviewProvider {
    static var previews: some View {
        DragSpring()
    }
}
