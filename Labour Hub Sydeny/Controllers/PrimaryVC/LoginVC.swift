//
//  LoginVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 18/03/23.
//

import UIKit
import Alamofire

class LoginVC: UIViewController {
    
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpTypeVC") as! SignUpTypeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        if self.textEmail.hasText && self.textPassword.hasText{
            self.login()
        }else{
            self.hideProgressBar()
            self.alert(alertmessage: "Please Enter The Valid Detials!")
        }
    }
    
    @IBAction func btnForgotPassword(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func paramLogin() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["email"]                 =   self.textEmail.text! as AnyObject
        dict["password"]              =   self.textPassword.text! as AnyObject
        dict["register_id"]           =   k.emptyString as AnyObject
        dict["lat"]                   =   kAppDelegate.coordinate2.coordinate.latitude as AnyObject
        dict["lon"]                   =   kAppDelegate.coordinate2.coordinate.longitude as AnyObject
        dict["mobile"]                =   k.emptyString as AnyObject
        dict["ios_register_id"]       =   k.iosRegisterId as AnyObject
        print(dict)
        return dict
    }
    
    func login() {
        print(self.paramLogin())
        Api.shared.login(self, self.paramLogin()) { (response) in
            self.hideProgressBar()
            k.userDefault.set(true, forKey: k.session.status)
            k.userDefault.set(response.id ?? "", forKey: k.session.userId)
            k.userDefault.set("\(response.first_name ?? "") \(response.last_name ?? "")", forKey: k.session.userName)
            k.userDefault.set(response.email ?? "", forKey: k.session.userEmail)
            k.userDefault.set(response.type ?? "", forKey: k.session.userType)
            k.userDefault.set(response.company_code ?? "", forKey: k.session.commonCompanyCode)
            Switcher.checkLoginStatus()
        }
    }
}

