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

extension UIStackView {
    func setMargin(_ margin: UIEdgeInsets) {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = margin
    }
}

extension UIEdgeInsets {
    init(marginAll: CGFloat) {
        self.init(top: marginAll, left: marginAll, bottom: marginAll, right: marginAll)
    }
}

extension UIColor {
    convenience init?(hex: String, alpha: CGFloat = 1) {
        var chars = Array(hex.hasPrefix("#") ? hex.dropFirst() : hex[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }
        case 6: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                 blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                alpha: alpha)
    }

    convenience init?(hexaRGBA: String) {
        var chars = Array(hexaRGBA.hasPrefix("#") ? hexaRGBA.dropFirst() : hexaRGBA[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars.append(contentsOf: ["F","F"])
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                 blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                alpha: .init(strtoul(String(chars[6...7]), nil, 16)) / 255)
    }

    convenience init?(hexaARGB: String) {
        var chars = Array(hexaARGB.hasPrefix("#") ? hexaARGB.dropFirst() : hexaARGB[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars.append(contentsOf: ["F","F"])
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                green: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                 blue: .init(strtoul(String(chars[6...7]), nil, 16)) / 255,
                alpha: .init(strtoul(String(chars[0...1]), nil, 16)) / 255)
    }
}

extension UIViewController {
    
}
