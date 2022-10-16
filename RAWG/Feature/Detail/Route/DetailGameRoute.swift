//
//  BaseRoute.swift
//  RAWG
//
//  Created by Kevin Maulana on 13/10/22.
//

import Foundation
import Router

protocol DetailGameRoute {
    func toDetailGame(id: String)
}

extension DetailGameRoute where Self: Router {

    func toDetailGame(with transition: Transition, id: String) {
        let router = DefaultRouter(rootTransition: transition)
        let vc = DetailGameViewController()
        let vm = DefaultDetailGameViewModel(id: id)
        vc.viewModel = vm
        vc.hidesBottomBarWhenPushed = true
        router.root = vc
        route(to: vc, as: transition)
    }

    func toDetailGame(id: String) {
        toDetailGame(with: PushTransition(), id: id)
    }
}

extension DefaultRouter: DetailGameRoute {}
