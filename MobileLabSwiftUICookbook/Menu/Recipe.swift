//
//  Recipe.swift
//  MobileLabSwiftUICookbook
//
//  Created by Nien Lam on 1/27/20.
//  Copyright © 2020 Mobile Lab. All rights reserved.
//

import SwiftUI
import Combine

enum Recipe: String, CaseIterable, Identifiable {
    case simpleText
    case inputTextField
    case drag
    case dragSpring
    case slider
    case popUp
    
    // Associated data for recipe (title, description, { AnyView(view) })
    private var associatedData: Data {
        switch self {
            
        case .simpleText:
            return Data("Simple Text",
                        "Basic Text component. Similar to a basic UILabel with default styles.",
                        { AnyView(SimpleText()) })
            
        case .inputTextField:
            return Data("Input Text Field",
                        "Dynamic text field.",
                        { AnyView(InputTextField()) })
            
        case .drag:
            return Data("Drag",
                        "Draggable component using shape primitive and gesture modifier.",
                        { AnyView(Drag()) })
            
        case .dragSpring:
            return Data("Drag Spring",
                        "Draggable component using spring animation.",
                        { AnyView(DragSpring()) })
            
        case .slider:
            return Data("Slider",
                        "Customized slider using shape, gesture and stack.",
                        { AnyView(Slider()) })
            
        case .popUp:
            return Data("Pop Up",
                        "Button with submenu buttons.",
                        { AnyView(PopUp(secondaryButtonContents: SecondaryButton.secondaryButtons,
                                        popupButtonContent: PopupButton(),
                                        radius: 120,
                                        minAngle: .init(degrees: 0),
                                        maxAngle: .init(degrees: 135),
                                        popupButtonRotationActive: true,
                                        popupButtonScalingActive: true,
                                        secondaryButtonsGradualAppearance: true)) })
        }
    }
    
    // MARK: -
    
    var id: String { return self.rawValue }
    var title: String { return associatedData.title }
    var description: String { return associatedData.description }
    
    func makeView() -> AnyView { associatedData.view() }
    
    private typealias Data = (
        title: String,
        description: String,
        view: () -> AnyView
    )
}
