//
//  UserHomeVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 05/04/23.
//

import UIKit
import Alamofire

class UserHomeVC: UIViewController {

    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblNotifi: UILabel!
    
    var companyName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getUserProfileDetials()
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    func getUserProfileDetials() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_profile?"
        let paramDetails = [
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
                        self.lblCompanyName.text = root.result?.company_name ?? ""
                        let notiCount = root.result?.noti_count ?? ""
                        if notiCount != "0"
                        {
                            self.lblNotifi.isHidden = false
                            self.lblNotifi.text = "\(notiCount)"
                        }else
                        {
                            self.lblNotifi.isHidden = true
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
    
    @IBAction func btnNotification(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "NotificationVc") as! NotificationVc
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnProject(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "UserProjectVC") as! UserProjectVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnTimesheet(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "UserTimesheetVC") as! UserTimesheetVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnInvoice(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "UserInvoiceVC") as! UserInvoiceVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnNewProject(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "UserNewProject") as! UserNewProject
        self.navigationController?.pushViewController(vc, animated: true
        )
    }
    
}
