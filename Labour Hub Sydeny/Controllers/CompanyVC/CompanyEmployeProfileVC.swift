//
//  CompanyEmployeProfileVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 17/04/23.
//

import UIKit
import Alamofire
import SDWebImage

class CompanyEmployeProfileVC: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblEmployeName: UILabel!
    @IBOutlet weak var lblEmpEmail: UILabel!
    @IBOutlet weak var lblEmpAddress: UILabel!
    @IBOutlet weak var lblEmpSkills: UILabel!
    @IBOutlet weak var lblEmpComapnyCode: UILabel!
    @IBOutlet weak var lblEmpBSBNo: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblABNNum: UILabel!
    
    var userId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getEmployeProfileDetials()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getEmployeProfileDetials() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_profile?"
        
        let paramDetails =
        [
            
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
                        self.lblEmployeName.text = "\(root.result?.first_name ?? "") \(root.result?.last_name ?? "") (\(root.result?.cat_name ?? ""))"
                        self.lblEmpEmail.text = root.result?.email ?? ""
                        self.lblPhoneNumber.text = root.result?.mobile ?? ""
                        self.lblEmpAddress.text = root.result?.address ?? ""
                        self.lblEmpComapnyCode.text = "\(root.result?.company_name ?? "") (Code: \(root.result?.company_code ?? ""))"
                        self.lblEmpBSBNo.text = "\(root.result?.bank_account ?? "") (BSB Number: \(root.result?.bank_branch ?? ""))"
                        self.lblEmpSkills.text = root.result?.skill ?? ""
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
