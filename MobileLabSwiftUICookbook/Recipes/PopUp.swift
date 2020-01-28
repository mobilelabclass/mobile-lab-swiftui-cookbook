//
//  PopUp.swift
//  SwiftUICookbook
//
//  Created by Timothy on 6/25/19.
//  Copyright © 2020 Mobile Lab. All rights reserved.
//

import SwiftUI

//EXAMPLE VIEWS-----------------------------------------------
// EXAMPLE STRUCT FOR SECONDARY BUTTON
struct SecondaryButton : View, Identifiable{
    
    var id: Int // THIS HAS TO BE INT
    var buttonImage: Image
    var buttonAction: (() -> Void)
    
    var body: some View {
        Group {
            buttonImage
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
                .onTapGesture(perform: buttonAction)
        }
    }
    
    static var secondaryButtons: [SecondaryButton] = [.init(id: 0, buttonImage: .init(systemName: "q.circle"), buttonAction: {}),
                                                      .init(id: 1, buttonImage: .init(systemName: "arrow.down.circle"), buttonAction: {}),
                                                      .init(id: 2, buttonImage: .init(systemName: "questionmark.circle"), buttonAction: {})]
}
// EXAMPLE STRUCT FOR POP-UP BUTTON
struct PopupButton : View {
    var buttonImage = Image(systemName: "plus.circle")
    var body: some View {
        buttonImage
            .resizable()
            .frame(width: 50, height: 50, alignment: .center)
    }
}
//-------------------------------------------------------------

/// This pop up view only defines a method of combining views to achieve certain appearances. The views themselves can be anything that adheres to the protocols defined below
struct PopUp<PopupButtonContent, SecondaryButtonContent> : View where PopupButtonContent : View, SecondaryButtonContent : View, SecondaryButtonContent : Identifiable, SecondaryButtonContent.ID == Int {
    
    /// Expanded buttons passed as an array with Int identifiers
    var secondaryButtonContents: [SecondaryButtonContent]
    
    /// Pop-up button view
    var popupButtonContent: PopupButtonContent
    
    /// An array of specified positions. If not provided, positions are calculated based on angles and the radius
    var exactPositionArray: [(x: CGFloat, y: CGFloat)]? = nil
    
    /// Radial distance of secondary buttons from the pop-up button. Angles specify the sector of where the buttons will appear
    var radius: CGFloat = 40
    var minAngle: Angle = .init(degrees: 0)
    var maxAngle: Angle = .init(degrees: 90)
    
    /// Transition modifiers
    var popupButtonRotationActive: Bool = false
    var popupButtonScalingActive: Bool = false
    var secondaryButtonsGradualAppearance: Bool = false
    
    /// State variable responsible to tracking switching
    @State private var expanded = false
    
    var body: some View {
        
        let positionArray = exactPositionArray == nil ? determinePositions() : exactPositionArray!
        
        return ZStack {
            
            ForEach(secondaryButtonContents, id: \.id) { secondaryButtonContent in
                SecondaryButtonView(expanded: self.$expanded,
                                    secondaryButtonContent: secondaryButtonContent,
                                    position: positionArray[secondaryButtonContent.id],
                                    gradualAppearance: self.secondaryButtonsGradualAppearance)
            }
            
            popupButtonContent
                .scaleEffect(self.expanded && self.popupButtonScalingActive ? 1.15 : 1)
                .rotationEffect(self.expanded && self.popupButtonRotationActive ? .init(degrees: 45) : .init(degrees: 0))
                .onTapGesture {
                    self.expanded.toggle()
                }
                .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.5, blendDuration: 1.4))
            
        }
    }
    
    func determinePositions() -> [(x: CGFloat, y: CGFloat)] {
        let increment = (self.maxAngle.radians - self.minAngle.radians)/Double(self.secondaryButtonContents.count - 1)
        var positionArray: [(CGFloat, CGFloat)] = []
        
        for i in 0..<self.secondaryButtonContents.count {
            let angle = self.minAngle.radians + increment*Double(i)
            let x = CGFloat(cos(angle))*self.radius
            let y = -CGFloat(sin(angle))*self.radius
            positionArray.append((x,y))
        }
        
        return positionArray
    }
}

struct SecondaryButtonView<SecondaryButtonContent>: View where SecondaryButtonContent: View,SecondaryButtonContent: Identifiable, SecondaryButtonContent.ID == Int {
    
    @Binding var expanded: Bool
    
    var secondaryButtonContent: SecondaryButtonContent
    var position: (x: CGFloat, y: CGFloat)
    var gradualAppearance: Bool
    
    
    var body: some View {
        secondaryButtonContent
            .offset(x: self.expanded ? position.x : 0, y: self.expanded ? position.y : 0)
            .opacity(self.expanded ? 1 : 0)
            .animation(.easeInOut(duration: 0.5 + (self.gradualAppearance ? 0.1*Double(secondaryButtonContent.id) : 0)))
            .disabled(!self.expanded)
    }
}

struct PopUp_Previews : PreviewProvider {
    static var previews: some View {
        PopUp(secondaryButtonContents: SecondaryButton.secondaryButtons, popupButtonContent: PopupButton(), radius: 120, minAngle: .init(degrees: 0), maxAngle: .init(degrees: 135), popupButtonRotationActive: true, popupButtonScalingActive: true, secondaryButtonsGradualAppearance: true)
    }
}
