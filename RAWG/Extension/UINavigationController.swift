//
//  UINavigationController.swift
//  RAWG
//
//  Created by Kevin Maulana on 06/10/22.
//

import Foundation
import UIKit

public extension UINavigationController {
    func popToRoot(transitionType type: CATransitionType = .fade, duration: CFTimeInterval = 0.3) {
        self.addTransition(transition: type, duration: duration)
        self.popToRootViewController(animated: false)
    }
    
    func pop(transitionType type: CATransitionType, duration: CFTimeInterval = 0.3) {
        self.addTransition(transition: type, duration: duration)
        self.popViewController(animated: false)
    }
    
    func push(viewController vc: UIViewController, animated: Bool = true, transitionType type: CATransitionType = .fade, duration: CFTimeInterval = 0.3) {
        if animated {
            self.pushViewController(vc, animated: animated)
        } else {
            self.addTransition(transition: type, duration: duration)
            self.pushViewController(vc, animated: animated)
        }
    }
    
    private func addTransition(transition type: CATransitionType = .fade, duration: CFTimeInterval = 0.3) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = type
        self.view.layer.add(transition, forKey: nil)
    }
}
