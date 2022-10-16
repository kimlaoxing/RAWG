//
//  BaseRoute.swift
//  RAWG
//
//  Created by Kevin Maulana on 13/10/22.
//

import Foundation
import Router

public protocol NewProfileRoute {
    func toNewProfile()
}

extension NewProfileRoute where Self: Router {

    func toNewProfile(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let vc = NewProfileViewController()
        vc.hidesBottomBarWhenPushed = true
        router.root = vc
        route(to: vc, as: transition)
    }

    public func toNewProfile() {
        toNewProfile(with: PushTransition())
    }
}

extension DefaultRouter: NewProfileRoute {}
