//
//  PresentAccountDelete.swift
//  Labour Hub Sydney
//
//  Created by Techimmense Software Solutions on 13/06/23.
//

import UIKit
import Alamofire

class PresentAccountDelete: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnNo(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnYes(_ sender: UIButton) {
        self.showProgressBar()
        self.deleteAccount()
    }
    
    func deleteAccount() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/delete_account?"
        let paramLogin = [
            "user_id": UserDefaults.standard.value(forKey: "user_id") as! String
        ]
        
        Alamofire.request(urlString, parameters: paramLogin).response { response in
            let data = response.data
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(AccountDeactivate.self, from: data!)
                print(root)
                if let deletedAccountStatus = root.status {
                    if deletedAccountStatus == "1" {
                        self.hideProgressBar()
                        let domain = Bundle.main.bundleIdentifier!
                        UserDefaults.standard.removePersistentDomain(forName: domain)
                        UserDefaults.standard.synchronize()
                        Switcher.checkLoginStatus()
                    } else {
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                    }
                }
            } catch {
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
}
