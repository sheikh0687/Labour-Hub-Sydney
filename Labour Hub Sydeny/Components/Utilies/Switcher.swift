//
//  Switcher.swift
//  Labour Hub Sydeny
//
//  Created by mac on 30/03/23.
//

import Foundation
import UIKit

class Switcher {
    
    class func checkLoginStatus() {
        
        let status = k.userDefault.bool(forKey: k.session.status)
    
            if status == true {
                if let selectedType = k.userDefault.value(forKey: k.session.userType) {
                    if selectedType as! String == "USER" {
        
                        let homeViewController = Kstoryboard.instantiateViewController(withIdentifier: "UserTabBarController") as! UserTabBarController
                        let CheckViewController = UINavigationController(rootViewController: homeViewController)
                        
                        kAppDelegate.window?.rootViewController = CheckViewController
                        kAppDelegate.window?.makeKeyAndVisible()
        
                    }else if selectedType as! String == "EMPLOYEE" {
                        
                        let homeViewController = Kstoryboard.instantiateViewController(withIdentifier: "EmployeeTabBarVC") as! EmployeeTabBarVC
                        let CheckViewController = UINavigationController(rootViewController: homeViewController)
                        
                        kAppDelegate.window?.rootViewController = CheckViewController
                        kAppDelegate.window?.makeKeyAndVisible()
                    }else if selectedType as! String == "SUBADMIN"{
                        let homeViewController = Kstoryboard.instantiateViewController(withIdentifier: "MainTabBarVC") as! MainTabBarVC
                        let CheckViewController = UINavigationController(rootViewController: homeViewController)
                        
                        kAppDelegate.window?.rootViewController = CheckViewController
                        kAppDelegate.window?.makeKeyAndVisible()
                    }
                } else {
                let mainInterfaceVC = Kstoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                let vc = UINavigationController(rootViewController: mainInterfaceVC)
                kAppDelegate.window?.rootViewController = vc
                kAppDelegate.window?.makeKeyAndVisible()
            }
        } else {
            let mainInterfaceVC = Kstoryboard.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
            let vc = UINavigationController(rootViewController: mainInterfaceVC)
            kAppDelegate.window?.rootViewController = vc
            kAppDelegate.window?.makeKeyAndVisible()
        }
    }
}
