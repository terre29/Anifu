//
//  AnifuErrorViewController.swift
//  Anifu
//
//  Created by Indocyber on 08/07/23.
//

import Foundation
import UIKit

public class AnifuErrorViewController: UIViewController {
    
    let baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let problemTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ooops, we ran into trouble, please try again later"
        return label
    }()
    
    let problemDescriptionButton: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = true
        button.setTitle("Reload", for: .normal)
        return button
    }()
    
    let reloadAction: () -> Void
    
    public init(reloadAction: @escaping () -> Void) {
        self.reloadAction = reloadAction
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        view.addSubview(baseStackView)
        view.backgroundColor = .black
        baseStackView.addArrangedSubview(problemTitleLabel)
        baseStackView.addArrangedSubview(problemDescriptionButton)
        baseStackView.pinToAllSideWith16Constant(to: view)
        problemDescriptionButton.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
    }
    
    @objc func reloadButtonTapped() {
        reloadAction()
    }
}
