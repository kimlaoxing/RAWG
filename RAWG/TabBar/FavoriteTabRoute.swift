//
//  FavoriteTabRoute.swift
//  RAWG
//
//  Created by Kevin Maulana on 13/10/22.
//

import Foundation
import UIKit

protocol FavoriteTabRoute {
    func makeFavoriteTab() -> UIViewController
}

extension FavoriteTabRoute where Self: Router {
    func makeFavoriteTab() -> UIViewController {
        let router = DefaultRouter(rootTransition: ModalTransition())
        let vc = FavoriteListViewController()
        let vm = DefaultFavoriteListViewModel(router: router)
        vc.viewModel = vm
        router.root = vc
        
        let navigation = UINavigationController(rootViewController: vc)
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .black
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigation.navigationBar.standardAppearance = navBarAppearance
        navigation.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigation.navigationBar.tintColor = .white
        navigation.tabBarItem.title = "Favorite"
        navigation.tabBarItem.image = UIImage(systemName: "star.fill")
        navigation.navigationBar.prefersLargeTitles = false
        navigation.navigationBar.barStyle = .default
        navigation.navigationBar.backgroundColor = .gray
        return navigation
    }
}

extension DefaultRouter: FavoriteTabRoute {}
