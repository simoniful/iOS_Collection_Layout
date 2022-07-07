//
//  SceneDelegate.swift
//  Playground
//
//  Created by Sang hun Lee on 2022/07/06.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: CollectionViewExampleViewController(pageType: .collectionView))
        // CollectionViewExampleViewController(pageType: .collectionView)
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
    }
}

