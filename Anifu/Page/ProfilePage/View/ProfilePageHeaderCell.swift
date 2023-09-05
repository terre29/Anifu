//
//  ProfilePageHeaderCell.swift
//  Anifu
//
//  Created by Indocyber on 13/05/23.
//

import Foundation
import UIKit
import RxSwift

class ProfilePageHeaderCell: UITableViewCell {
    
    // MARK: Property
    var nameTapped: (() -> Void)?
    var viewModel = PublishSubject<ProfileHeaderViewModel>()
    
    let baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .systemGray5
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.layer.cornerRadius = 12
        return stackView
    }()
    
    let nameAndDescriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupLayout()
        setupNameTappedFunction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(baseStackView)
        baseStackView.pinToAllSideWith16Constant(to: contentView)
        baseStackView.addArrangedSubview(profileImage)
        baseStackView.addArrangedSubview(nameAndDescriptionStackView)
        
        nameAndDescriptionStackView.addArrangedSubview(nameLabel)
        nameAndDescriptionStackView.addArrangedSubview(descriptionLabel)
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.heightAnchor.constraint(equalToConstant: 70).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    override func layoutSubviews() {
        profileImage.layer.cornerRadius = profileImage.frame.size.height/2
    }
    
    private func setupNameTappedFunction() {
        nameLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellNameTapped))
        nameLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func cellNameTapped() {
        nameTapped!()
    }
}
