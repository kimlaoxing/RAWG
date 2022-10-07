//
//  BaseRoute.swift
//  RAWG
//
//  Created by Kevin Maulana on 13/10/22.
//

import Foundation

protocol EditProfileRoute {
    func toEditName(_ delegate: ProfileEditDelegate)
    func toEditEmail(_ delegate: ProfileEditDelegate)
}

extension EditProfileRoute where Self: Router {
    
    func toEditName(with transition: Transition, delegate: ProfileEditDelegate) {
        let router = DefaultRouter(rootTransition: transition)
        let vc = ProfileEditViewController()
        vc.state = .name
        vc.delegate = delegate
        vc.hidesBottomBarWhenPushed = true
        router.root = vc
        route(to: vc, as: transition)
    }
    
    func toEditEmail(with transition: Transition, delegate: ProfileEditDelegate) {
        let router = DefaultRouter(rootTransition: transition)
        let vc = ProfileEditViewController()
        vc.state = .email
        vc.state = .email
        vc.delegate = delegate
        vc.hidesBottomBarWhenPushed = true
        router.root = vc
        route(to: vc, as: transition)
    }
    
    func toEditName(_ delegate: ProfileEditDelegate) {
        toEditName(with: PushTransition(), delegate: delegate)
    }
    
    func toEditEmail(_ delegate: ProfileEditDelegate) {
        toEditEmail(with: PushTransition(), delegate: delegate)
    }
}

extension DefaultRouter: EditProfileRoute { }
