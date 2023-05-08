//
//  AnifuTabBarController.swift
//  Anifu
//
//  Created by Terretino on 10/01/23.
//

import Foundation
import UIKit

class AnifuTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    let viewControllerList: [UIViewController]
    
    init(viewControllerList: [UIViewController]) {
        self.viewControllerList = viewControllerList
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTabBarItem()
    }
    
    func setupTabBarItem() {
        var viewControllers = [UIViewController]()
        viewControllerList.forEach({ viewController in
            let tabBarItem = UITabBarItem(title: viewController.title ?? "ITEM", image: nil, selectedImage: nil)
            viewController.tabBarItem = tabBarItem
            viewControllers.append(viewController)
        })
        self.viewControllers = viewControllers
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
