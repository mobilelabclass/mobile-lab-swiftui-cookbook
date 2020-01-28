//
//  SceneDelegate.swift
//  MobileLabSwiftUICookbook
//
//  Created by Nien Lam on 1/27/20.
//  Copyright © 2020 Mobile Lab. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let recipeList = RecipeList()

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: recipeList)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

