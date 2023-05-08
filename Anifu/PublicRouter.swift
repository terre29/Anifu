//
//  PublicRouter.swift
//  Anifu
//
//  Created by Terretino on 04/01/23.
//

import Foundation
import UIKit
import RxSwift

public class GlobalRouter {
    public static let shared = GlobalRouter()
    
    init(){}
    
    func route(to: UIViewController, from: UIViewController) {
        from.show(to, sender: from)
    }
}
