//
//  ProfilePageModel.swift
//  Anifu
//
//  Created by Indocyber on 12/05/23.
//

import Foundation
import UIKit
import RxSwift

enum ProfileCases {
    case AnimePreference
    case Name
    case Profile
}

class ProfilePageViewModel {
    var userName = PublishSubject<String>()
    var profileImage = PublishSubject<UIImage>()
    
    let fetchUserData: () -> ProfileHeaderViewModel
    let updateNameCoreData: (String) -> Void
    
    init(fetchUserData: @escaping () -> ProfileHeaderViewModel, updateNameCoreData: @escaping (String) -> Void) {
        self.fetchUserData = fetchUserData
        self.updateNameCoreData = updateNameCoreData
    }
    
    func updateName(name: String) {
        userName.onNext(name)
    }
    
    func updateProfileImage(image: UIImage) {
        profileImage.onNext(image)
    }
}

struct ProfileHeaderViewModel {
    let userName: String
    let userImage: UIImage
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
