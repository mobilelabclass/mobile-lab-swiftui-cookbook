//
//  Drag.swift
//  MobileLabSwiftUICookbook
//
//  Created by Sebastian Buys on 6/11/19.
//  Copyright © 2020 Mobile Lab. All rights reserved.
//

import SwiftUI

struct Drag: View {
    /// A variable that controls location changes
    @GestureState var translation: CGSize = CGSize()
    
    /// A variable that keeps the current location
    @State var offset = CGSize()
    
    var body: some View {
        let drag = DragGesture(minimumDistance: 0.0, coordinateSpace: CoordinateSpace.global)
            .updating($translation, body: { (gestureState, translation, transaction) in
                translation = gestureState.translation
            })
            .onChanged { gesture in
                // gesture.location
            }
            .onEnded { gesture in
                
                // Updating location when press is realeased
                self.offset = CGSize(width: self.offset.width + gesture.translation.width, height: self.offset.height + gesture.translation.height)
        }
        
        return Circle()
            .fill(Color.red)
            .frame(width: 100.0, height: 100.0, alignment: .center)
            .offset(CGSize(width: self.offset.width + translation.width, height: self.offset.height + translation.height))
            .gesture(drag)
    }
}

struct Drag_Previews : PreviewProvider {
    static var previews: some View {
        Drag()
    }
}
