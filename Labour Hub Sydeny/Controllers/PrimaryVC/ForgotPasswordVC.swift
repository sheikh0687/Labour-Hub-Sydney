//
//  ForgotPasswordVC.swift
//  Labour Hub Sydeny
//
//  Created by Techimmense Software Solutions on 26/05/23.
//

import UIKit
import Alamofire

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var textEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnForgot(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSend(_ sender: UIButton) {
        self.showProgressBar()
        self.newPassword()
    }
    
    func newPassword()
    {
        let url = "https://labourhubsydney.com.au/LabourHubSydney/webservice/forgot_password?"
        let paramDetails =
        [
            "email": self.textEmail.text!,
            "type": "Normal"
        ]
        
        print(paramDetails)
        
        Alamofire.request(url, parameters: paramDetails).response { response in
            let data = response.data
            do{
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetNewPassword.self, from: data!)
                if let adminStatus = root.status {
                    if adminStatus == "1"{
                        self.hideProgressBar()
                        self.alert(alertmessage: "New Password has been Sent to your email address!")
                    }else{
                        self.hideProgressBar()
                        self.alert(alertmessage: "This email id does not exist!")
                    }
                    DispatchQueue.main.async {
                    }
                }
            }catch{
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
}
