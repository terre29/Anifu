//
//  ProfilePageCell.swift
//  Anifu
//
//  Created by Indocyber on 11/05/23.
//

import Foundation
import UIKit

class ProfilePageCell: UITableViewCell {
    
    let baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        stackView.axis = .horizontal
        return stackView
    }()
    
    let cellIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        imageView.image = UIImage(systemName: "person.circle.fill")
        return imageView
    }()
    
    let cellName: UILabel = {
        let cellName = UILabel()
        cellName.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return cellName
    }()
    
    let cellRightButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupBaseLayout()
        setupStackItemViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackItemViewLayout() {
        cellIcon.translatesAutoresizingMaskIntoConstraints = false
        cellIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cellIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupBaseLayout() {
        contentView.addSubview(baseStackView)
        baseStackView.pinToAllSideWith16Constant(to: contentView)
        baseStackView.addArrangedSubview(cellIcon)
        baseStackView.addArrangedSubview(cellName)
        baseStackView.addArrangedSubview(cellRightButton)
    }
}
