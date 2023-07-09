//
//  PublicRouter.swift
//  Anifu
//
//  Created by Terretino on 04/01/23.
//

import Foundation
import UIKit
import RxSwift

public protocol DataReceiver {
    func receiveData<D>(data: D) throws
}

enum DataError: Error {
    case DataNotMatch
}

class Router {
    weak var sourceViewController: UIViewController?
    
    init(sourceViewController: UIViewController) {
        self.sourceViewController = sourceViewController
    }
    
    func route(to destinationViewController: UIViewController, with data: Any? = nil) {
        guard let dataReceiver = destinationViewController as? DataReceiver else {
            return
        }
        
        let isDataNotNil = data != nil
        if isDataNotNil {
            try? dataReceiver.receiveData(data: data)
        }
        sourceViewController?.navigationController?.pushViewController(destinationViewController, animated: true)
    }
 
}

