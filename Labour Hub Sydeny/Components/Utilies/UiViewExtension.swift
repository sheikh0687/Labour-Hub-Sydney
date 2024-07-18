//
//  UiViewExtension.swift
//  Labour Hub Sydeny
//
//  Created by mac on 13/05/23.
//

import UIKit

public extension UIView {
    /**
     Captures view and subviews in an image
     */
    func snapshotViewHierarchy() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, UIScreen.main.scale)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let copied = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return copied
    }
}
