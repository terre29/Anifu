//
//  ProfilePageComposer.swift
//  Anifu
//
//  Created by Indocyber on 18/05/23.
//

import Foundation
import UIKit


struct ProfilePageComposer {
    static func createPoriflePageViewController() -> ProfilePageViewController {
        let viewController = ProfilePageViewController()
        viewController.title = "Profile"
        return viewController
    }
}
