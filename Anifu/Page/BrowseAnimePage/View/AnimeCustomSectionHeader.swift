//
//  AnimeCustomSectionHeader.swift
//  Anifu
//
//  Created by Terretino on 09/01/23.
//

import Foundation
import UIKit

class AnimeCustomSectionHeader: UICollectionReusableView {
    
    var sectionTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sectionTitle)
        sectionTitle.pinToAllSideWith8Constant(to: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



