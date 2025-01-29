//
//  ViewControllerExtension.swift
//  QuizApp
//
//  Created by Pallavi Ashim on 7/13/22.
//

import Foundation
import UIKit

extension UIViewController {
        
    // MARK: - ViewController initialization from storyboard
    
    class func instantiateViewController(_ identifier: String) -> Self {
        return instatiateGenericViewController(identifier) ?? unsafeDowncast(UIViewController(), to: self)
    }
    
    fileprivate class func instatiateGenericViewController<T>(_ identifier: String) -> T? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T
        return viewController
    }
    
}

enum Orientation {
    case portrait
    case landscape
}

extension UIDevice {
    var deviceOrientationWithStatusBar: Orientation {
        get {
            if UIApplication.shared.statusBarOrientation.isLandscape {
                return .landscape
            } else {
                return .portrait
            }
        }
    }
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
