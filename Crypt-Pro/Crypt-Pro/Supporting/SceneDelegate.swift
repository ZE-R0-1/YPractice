//
//  SceneDelegate.swift
//  Crypt-Pro
//
//  Created by USER on 7/15/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = HomeController()
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}

