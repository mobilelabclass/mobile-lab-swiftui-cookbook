//
//  RecipeData.swift
//  MobileLabSwiftUICookbook
//
//  Created by Nien Lam on 1/27/20.
//  Copyright © 2020 Mobile Lab. All rights reserved.
//

import SwiftUI
import Combine

enum RecipeType: String, CaseIterable, Identifiable {
    case simpleText
    case inputTextField

    // Associated type data (title, description, { view })
    private var associatedData: Data {
        switch self {

        case .simpleText:
            return Data("Simple Text",
                        "Basic label",
                        { AnyView(SimpleText()) })

        case .inputTextField:
            return Data("Input Text Field",
                        "Dynamic text field",
                        { AnyView(InputTextField()) })
            
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
