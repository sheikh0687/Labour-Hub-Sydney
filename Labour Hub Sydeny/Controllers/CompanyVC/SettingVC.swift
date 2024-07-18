//
//  SettingVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 27/03/23.
//

import UIKit
import Alamofire
import SDWebImage

class SettingVC: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        self.getProfileDetials()
    }
    
    func getProfileDetials() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_profile?"
        
        let paramDetails =
        [
            "user_id": UserDefaults.standard.value(forKey: "user_id") as! String
        ]
        
        print(paramDetails)
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            let data = response.data
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(getProfile.self, from: data!)
                print(root)
                if let loginStatus = root.status {
                    if loginStatus == "1"{
                        self.lblName.text = "\(root.result?.first_name ?? "") \(root.result?.last_name ?? "")"
                        if let imageUrl = URL(string: root.result?.image ?? ""){
                            self.img.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "profile_ic"), options: .continueInBackground,completed: nil)
                        }
                    }
                    else{
                        print("Something Went Wrong!")
                    }
                    DispatchQueue.main.async {
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func btnChangePassword(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnSignout(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "LogOutVC") as! LogOutVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
