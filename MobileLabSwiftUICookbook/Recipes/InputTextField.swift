//
//  InputTextField.swift
//  SwiftUICookbook
//
//  Created by Sebastian Buys on 6/13/19.
//  Copyright © 2019 Sebastian Buys. All rights reserved.
//

import SwiftUI

struct InputTextField : View {
    @State var text: String = "Hello"

    var body: some View {
        TextField("Title", text: $text, onEditingChanged: { (isEditing) in
            print("is editing: \(isEditing)")
        }) {
            print("pressedComplete")
        }
            .font(.system(.largeTitle))
            .background(Color.red)
       
    }
}

struct InputTextField_Previews : PreviewProvider {
    static var previews: some View {
        InputTextField()
    }
}
