//
//  AMACardView.swift
//  CommonUI
//
//  Created by Terretino on 24/01/23.
//  Copyright © 2023 Rheza Rivaldi. All rights reserved.
//

import Foundation
import UIKit

public protocol AMACardViewUsage {
    func createSimpleCardView(useShadow: Bool, mainView: UIView) -> UIView
    func createSimpleCardViewWithTopView(useShadow: Bool, mainView: UIView, topView: UIView) -> UIView
    func createSimpleCardViewWithFlag(useShadow: Bool, mainView: UIView, flagView: UIView) -> UIView
    func createSimpleCardViewWithTopViewAndFlag(useShadow: Bool, mainView: UIView, topView: UIView, flagView: UIView) -> UIView
}

public class AMACardView: UIView {
    
    lazy var baseCardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var topContent: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var bottomContent: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var topDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var flagViewContainer: UIView? = {
        let view = UIView()
        return view
    }()
    
    let preset: AMACardViewPreset
    let dependency: ACACardViewDependency
    
    init(preset: AMACardViewPreset, dependency: ACACardViewDependency) {
        super.init(frame: .zero)
        self.preset = preset
        self.dependency = dependency
        
        initSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSetup() {
        switch preset {
        case .simple:
            createSimpleCardView()
        case .simpleWithTop:
            createSimpleCardViewWithTop()
        case .simpleFlag:
            createSimpleCardView()
            setupFlagView()
        case .simpleFlagWithTop:
            createSimpleCardViewWithTop()
            setupFlagView()
        }
    }

    private func setupView() {
        addSubview(baseCardView)
        baseCardView.anchorAllSidesTo(view: self)
        baseCardView.addSubview(baseStackView)
        baseStackView.anchorAllSidesTo(view: baseCardView)
    }
    
    private func setupShadow() {
        shadowColor = AMAColorUsage
        layer.shadowOffset = CGSize(width: 1, height: 3)
        layer.shadowOpacity = 0.5
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 12)
        layer.shadowPath = shadowPath.cgPath
    }
    
    private func setupFlagView() {
        guard let flagView = dependency.flagView else { return }
        addSubview(flagView)
        flagView.translatesAutoresizingMaskIntoConstraints = false
        flagView.topAnchor.constraint(equalTo: baseCardView.topAnchor, constant: 20).isActive = true
        flagView.trailingAnchor.constraint(equalTo: baseCardView.trailingAnchor, constant: 8).isActive = true
    }
    
    private func createSimpleCardView() {
        bottomContent = dependency.mainView
        baseStackView.addArrangedSubview(bottomContent)
    }
    
    private func createSimpleCardViewWithTop() {
        bottomContent = dependency.mainView
        topContent = dependency.topView!
        baseStackView.addArrangedSubview(topContent)
        baseStackView.addArrangedSubview(topDividerView)
        baseStackView.addArrangedSubview(bottomContent)
    }
}

enum AMACardViewPreset {
    case simple
    case simpleWithTop
    case simpleFlag
    case simpleFlagWithTop
}

struct ACACardViewDependency {
    let useShadow: Bool
    let topView: UIView?
    let mainView: UIView
    let flagView: UIView?
}

public struct AMACardViewMaker: AMACardViewUsage {
    public func createSimpleCardView(useShadow: Bool, mainView: UIView) -> UIView {
        <#code#>
    }
    
    public func createSimpleCardViewWithTopView(useShadow: Bool, mainView: UIView, topView: UIView) -> UIView {
        <#code#>
    }
    
    public func createSimpleCardViewWithFlag(useShadow: Bool, mainView: UIView, flagView: UIView) -> UIView {
        <#code#>
    }
    
    public func createSimpleCardViewWithTopViewAndFlag(useShadow: Bool, mainView: UIView, topView: UIView, flagView: UIView) -> UIView {
        <#code#>
    }
    
    
}

//lazy var baseCardView: UIView = {
//    let view = UIView()
//    view.layer.cornerRadius = 12
//    view.layer.borderWidth = 1
//    view.layer.borderColor = UIColor.gray.cgColor
//    view.layer.masksToBounds = true
//    return view
//}()
//
//lazy var baseStackView: UIStackView = {
//    let stackView = UIStackView()
//    stackView.axis = .vertical
//    return stackView
//}()
//
//lazy var topContent: UIView = {
//    let view = UIView()
//    return view
//}()
//
//lazy var bottomContent: UIView = {
//    let view = UIView()
//    return view
//}()
//
//lazy var topDividerView: UIView = {
//    let view = UIView()
//    view.backgroundColor = .gray
//    view.heightAnchor.constraint(equalToConstant: 1).isActive = true
//    view.translatesAutoresizingMaskIntoConstraints = false
//    return view
//}()
//
//let content1 = UIView()
//let content2 = UIView()
//
//private func setupStackView() {
//    baseStackView.addArrangedSubview(topContent)
//    baseStackView.addArrangedSubview(topDividerView)
//    baseStackView.addArrangedSubview(bottomContent)
//}
//
//private func setupView() {
//    content1.backgroundColor = .systemBlue
//    content2.backgroundColor = .systemYellow
//    content1.heightAnchor.constraint(equalToConstant: 100).isActive = true
//    content1.translatesAutoresizingMaskIntoConstraints = false
//    topContent.addSubview(content1)
//    content1.anchorAllSidesTo(view: topContent)
//    bottomContent.addSubview(content2)
//    content2.anchorAllSidesTo(view: bottomContent)
//}
