//
//  NSLayoutConstraint.swift
//  RAWG
//
//  Created by Kevin Maulana on 06/10/22.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    public func activated() {
        NSLayoutConstraint.activate([self])
    }
}
