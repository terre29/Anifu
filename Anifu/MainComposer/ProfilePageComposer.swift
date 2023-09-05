//
//  ProfilePageComposer.swift
//  Anifu
//
//  Created by Indocyber on 18/05/23.
//

import Foundation
import UIKit

struct ProfilePageComposer {
    static func createPoriflePageViewController(coreDataManager: AnifuCoreDataManager) -> ProfilePageViewController {
        let data = coreDataManager.fetchData()
        let viewModel = ProfilePageViewModel(
            fetchUserData: {
                guard let userData = data?.first else { return ProfileHeaderViewModel(userName: "", userImage: UIImage())}
                return ProfileHeaderViewModel(userName: userData.name ?? "", userImage: UIImage())
            },
            updateNameCoreData: { newName in
                DispatchQueue.global(qos: .background).async {
                    data?.first?.name = newName
                    coreDataManager.saveDataChanges()
                }
            })
        let viewController = ProfilePageViewController(viewModel: viewModel)
        viewController.title = "Profile"
        return viewController
    }
}
