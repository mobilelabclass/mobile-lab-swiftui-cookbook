//
//  RecipeView.swift
//  MobileLabSwiftUICookbook
//
//  Created by Nien Lam on 1/27/20.
//  Copyright © 2020 Mobile Lab. All rights reserved.
//

import SwiftUI

struct RecipeContainer: View {
    let recipe: Recipe
    
    @State var showAlert = false
    
    var body: some View {
        recipe.makeView()
            .navigationBarTitle(Text(recipe.title), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: { self.showAlert.toggle() }) {
                Image(systemName: "info.circle")
                    .font(.system(size: 24, weight: .light))
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text(""), message: Text(recipe.description), dismissButton: .default(Text("Okay")))
            }
    }
}
