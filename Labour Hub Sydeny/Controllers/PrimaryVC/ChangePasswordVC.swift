//
//  ChangePasswordVC.swift
//  Labour Hub Sydeny
//
//  Created by Techimmense Software Solutions on 14/07/23.
//

import UIKit

class ChangePasswordVC: UIViewController {
    
    @IBOutlet weak var txtCurrentPssword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSave(_ sender: UIButton)
    {
        if self.txtCurrentPssword.hasText && self.txtNewPassword.hasText && self.txtConfirmPassword.hasText {
            self.updatePassword()
        }else{
            self.alert(alertmessage: "Please Enter the Required Details!")
        }
    }
    
    func updatePassword()
    {
        Api.shared.changePassword(self, self.passwordParam()) { responseData in
            self.alert(alertmessage: "Password Changed Successfully!")
        }
    }
    
    func passwordParam() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["password"]               = self.txtNewPassword.text! as AnyObject
        dict["old_password"]           = self.txtCurrentPssword.text! as AnyObject
        return dict
    }
}
