//
//  FavoriteTabRoute.swift
//  RAWG
//
//  Created by Kevin Maulana on 13/10/22.
//

import Foundation
import UIKit
import Router

public protocol ProfileTabRoute {
    func makeProfileTab() -> UIViewController
}

extension ProfileTabRoute where Self: Router {
    public func makeProfileTab() -> UIViewController {
        let router = DefaultRouter(rootTransition: ModalTransition())
        let vc = ProfileViewController()
        let vm = DefaultProfileViewViewModel(router: router)
        vc.viewModel = vm
        vc.navigationItem.backButtonTitle = ""
        router.root = vc

        let navigation = UINavigationController(rootViewController: vc)
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .black
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigation.navigationBar.standardAppearance = navBarAppearance
        navigation.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigation.navigationBar.tintColor = .white
        navigation.tabBarItem.title = "Profile"
        navigation.tabBarItem.image = UIImage(systemName: "person")
        navigation.navigationBar.prefersLargeTitles = false
        navigation.navigationBar.barStyle = .default
        navigation.navigationBar.backgroundColor = .gray
        return navigation
    }
}

extension DefaultRouter: ProfileTabRoute {}
