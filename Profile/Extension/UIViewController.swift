//
//  UIViewController.swift
//  RAWG
//
//  Created by Kevin Maulana on 23/09/22.
//

import Foundation
import UIKit
import Toast_Swift

extension UIViewController {
    func manageLoadingActivity(isLoading: Bool) {
        if isLoading {
            showLoadingActivity()
        } else {
            hideLoadingActivity()
        }
    }
    
    func showLoadingActivity() {
        self.view.makeToastActivity(.center)
    }
    
    func hideLoadingActivity() {
        self.view.hideToastActivity()
    }
}
