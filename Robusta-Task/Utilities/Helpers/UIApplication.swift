//
//  UIApplication.swift
//  Repositories
//
//  Created by Abdelrhman Eliwa on 14/11/2022.
//

import UIKit
import SwiftUI

extension UIApplication {
    var topController: UIViewController? {
        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        guard var topController = keyWindow?.rootViewController else { return nil }
        
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        
        return topController
    }
    
    var window: UIWindow? {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    }
}
