//
//  CompanyClientProfileVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 17/04/23.
//

import UIKit
import Alamofire
import SDWebImage

class CompanyClientProfileVC: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var lblUserNumber: UILabel!
    @IBOutlet weak var lblUserAddress: UILabel!
    @IBOutlet weak var lblUserCompanyCode: UILabel!
    @IBOutlet weak var lblABNNum: UILabel!
    
    var userId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getUserProfileDetials()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getUserProfileDetials() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_profile?"
        let paramDetails = [
            "user_id": self.userId
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
                        self.lblUserName.text = "\(root.result?.first_name ?? "") \(root.result?.last_name ?? "")"
                        self.lblUserEmail.text = root.result?.email ?? ""
                        self.lblUserNumber.text = root.result?.mobile ?? ""
                        self.lblUserAddress.text = root.result?.address ?? ""
                        self.lblUserCompanyCode.text = "\(root.result?.company_name ?? "") (Code: \(root.result?.company_code ?? ""))"
                        self.lblABNNum.text = "ABN:\(root.result?.aBN_number ?? "")"
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
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}


