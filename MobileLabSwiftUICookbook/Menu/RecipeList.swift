//
//  RecipeList.swift
//  MobileLabSwiftUICookbook
//
//  Created by Nien Lam on 1/27/20.
//  Copyright © 2020 Mobile Lab. All rights reserved.
//

import SwiftUI

struct RecipeList: View {
    var body: some View {
        NavigationView {
            List(RecipeType.allCases) { recipeType in
                NavigationLink(destination: RecipeContainer(recipeType: recipeType)) {
                    Text(recipeType.title)
                }
            }
            .navigationBarTitle(Text("Recipes"))
        }
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        RecipeList()
    }
}
