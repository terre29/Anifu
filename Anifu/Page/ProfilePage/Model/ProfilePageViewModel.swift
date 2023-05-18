//
//  ProfilePageModel.swift
//  Anifu
//
//  Created by Indocyber on 12/05/23.
//

import Foundation
import UIKit

enum ProfileCases {
    case AnimePreference
    case Name
    case Profile
}

struct ProiflePageCellViewModel: Hashable {
    let icon: UIImage
    let settingName: String
    let profileId: ProfileCases
    
    init(icon: UIImage, settingName: String, profileId: ProfileCases) {
        self.icon = icon
        self.settingName = settingName
        self.profileId = profileId
    }
}

struct ProfilePageHeaderCellViewModel: Hashable {
    let name: String
    let description: String
    let profileImage: UIImage
    
    init(name: String, description: String, profileImage: UIImage) {
        self.name = name
        self.description = description
        self.profileImage = profileImage
    }
}
