//
//  SceneDelegate.swift
//  RAWG
//
//  Created by Kevin Maulana on 13/10/22.
//

import UIKit
import Router
import Profile

extension SceneDelegate {
    func willConnectTo(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        let mainRouter = DefaultRouter(rootTransition: EmptyTransition())
        let tabs = [mainRouter.makeHomeTab(),
                    mainRouter.makeFavoriteTab(),
                    mainRouter.makeProfileTab()]
        let home = TabBar(vc: tabs)
        home.selectedIndex = 0
        self.window?.rootViewController = home
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }
}
