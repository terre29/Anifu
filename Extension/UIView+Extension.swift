//
//  UIView+Extension.swift
//  Anifu
//
//  Created by Terretino on 02/01/23.
//

import Foundation
import UIKit

extension UIView {
    func pinToAllSides(to: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: to.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: to.bottomAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: to.trailingAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: to.leadingAnchor).isActive = true
    }
    
    func pinToAllSideWith8Constant(to: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: to.topAnchor, constant: 8).isActive = true
        self.bottomAnchor.constraint(equalTo: to.bottomAnchor, constant: -8).isActive = true
        self.trailingAnchor.constraint(equalTo: to.trailingAnchor, constant: -8).isActive = true
        self.leadingAnchor.constraint(equalTo: to.leadingAnchor, constant: 8).isActive = true
    }
    
    func pinToAllSideWith16Constant(to: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: to.topAnchor, constant: 16).isActive = true
        self.bottomAnchor.constraint(equalTo: to.bottomAnchor, constant: -16).isActive = true
        self.trailingAnchor.constraint(equalTo: to.trailingAnchor, constant: -16).isActive = true
        self.leadingAnchor.constraint(equalTo: to.leadingAnchor, constant: 16).isActive = true
    }
    
    func pinToAllSideWithSafeArea(to: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: to.safeAreaLayoutGuide.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: to.bottomAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: to.trailingAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: to.leadingAnchor).isActive = true
    }
}
