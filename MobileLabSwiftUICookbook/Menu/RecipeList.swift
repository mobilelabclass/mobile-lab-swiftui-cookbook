//
//  RecipeList.swift
//  MobileLabSwiftUICookbook
//
//  Created by Nien Lam on 1/27/20.
//  Copyright © 2020 Mobile Lab. All rights reserved.
//

import SwiftUI

struct RecipeList: View {
    @State var showAlert = false

    var body: some View {
        NavigationView {
            List(Recipe.allCases) { recipe in
                NavigationLink(destination: RecipeContainer(recipe: recipe)) {
                    Text(recipe.title)
                }
            }
            .navigationBarTitle(Text("Recipes 🌮"))
            .navigationBarItems(trailing: Button(action: { self.showAlert.toggle() }) {
                Image(systemName: "info.circle")
                    .font(.system(size: 24, weight: .light))
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("SwiftUI Cookbook 👨🏻‍🍳"), message: Text(" \nversion: \(Bundle.main.releaseVersionNumber)"),
                      dismissButton: .default(Text("Okay")))
            }
        }
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        RecipeList()
    }
}
