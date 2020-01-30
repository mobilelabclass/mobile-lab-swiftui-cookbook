//
//  Slider.swift
//  cookbooktesting
//
//  Created by 邵名浦 on 2020/1/30.
//  Copyright © 2020 vinceshao. All rights reserved.
//

import SwiftUI

struct CustomizedSlider: View {
    
    // State variables
    /// A variable that controls location changes
    @GestureState var translation: CGSize = CGSize()
    /// A variable that keeps the current location
    @State var offset = CGSize()
    
    // Static variables
    let sliderHeight: CGFloat = 400
    let sliderWidth: CGFloat = 20
    let circleWidth: CGFloat = 40
    
    var body: some View {
        
        // Helper functions
        /// Calculating position of the circle
        func getOffsetHeight(translateHeight: CGFloat) -> CGFloat {
            /// 1. get required reference values
            let minHeight = 0 - self.sliderHeight/2
            let maxHeight = self.sliderHeight/2
            
            /// 2. calculate new values
            let newHeight = self.offset.height + translateHeight
            
            /// 3. format new values to deal with edge cases
            let fmtHeight = newHeight < minHeight
                ? minHeight : newHeight > maxHeight
                ? maxHeight : newHeight
            
            return fmtHeight
        }
        
        /// Changing color
        func setColor(_ offsetHeight: CGFloat) -> Color {
            if (offsetHeight == 0) {
                return Color.gray
            } else if (offsetHeight == 0 - self.sliderHeight/2) {
                return Color.purple
            } else if (offsetHeight == self.sliderHeight/2) {
                return Color.red
            } else if (offsetHeight > 0) {
                return Color.orange
            } else {
                return Color.blue
            }
        }
        
        /// Moving the circle
        let drag = DragGesture(minimumDistance: 0, coordinateSpace: CoordinateSpace.global)
            .updating($translation, body: {
                (gestureState, translation, transaction) in translation = gestureState.translation
            })
            .onEnded { gesture in
                self.offset = CGSize(
                    width: self.offset.width,
                    height: getOffsetHeight(translateHeight: gesture.translation.height)
                )
            }
        
        // Main view
        return ZStack {
                RoundedRectangle(cornerRadius: 50)
                    .fill(setColor(
                        getOffsetHeight(translateHeight: self.translation.height)
                    ))
                    .frame(width: self.sliderWidth,
                           height: self.sliderHeight,
                           alignment: .center)
                    .animation(.easeInOut)
                
                Circle()
                    .fill(Color.yellow)
                    .frame(width: self.circleWidth,
                           height: self.circleWidth,
                           alignment: .center)
                    .offset(CGSize(
                        width: self.offset.width,
                        height: getOffsetHeight(translateHeight: self.translation.height)
                    ))
                    .gesture(drag)
        }
        
    }
    
}


struct Slider_Previews : PreviewProvider {
    static var previews: some View {
        CustomizedSlider()
    }
}
