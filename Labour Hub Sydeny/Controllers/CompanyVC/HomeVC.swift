//
//  SelectProjectVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 23/03/23.
//

import UIKit
import Alamofire

class HomeVC: UIViewController {
    
    @IBOutlet var lblCompanyaName: UILabel!
    @IBOutlet weak var lblNotification: UILabel!
    
    var companyName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getUserProfileDetials()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
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
                        self.lblCompanyaName.text = root.result?.company_name ?? ""
                        let notiCount = root.result?.noti_count ?? ""
                        if notiCount != "0"
                        {
                            self.lblNotification.isHidden = false
                            self.lblNotification.text = "\(notiCount)"
                        }else
                        {
                            self.lblNotification.isHidden = true
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
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "CompanyNotificationVC") as! CompanyNotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnNewProject(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "CompanyProjectVC") as! CompanyProjectVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnInvoice(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "CompanyInvoiceVC") as! CompanyInvoiceVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnreport(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "CompanyReportVC") as! CompanyReportVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
