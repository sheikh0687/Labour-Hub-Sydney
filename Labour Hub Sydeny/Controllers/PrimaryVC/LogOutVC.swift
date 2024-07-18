//
//  LogOutVC.swift
//  Labour Hub Sydeny
//
//  Created by Techimmense Software Solutions on 27/05/23.
//

import UIKit

class LogOutVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnOk(_ sender: UIButton) {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        Switcher.checkLoginStatus()
    }
    
    @IBAction func btnCAncel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
