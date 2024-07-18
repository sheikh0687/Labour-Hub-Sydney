//
//  EmployeHomeVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 10/04/23.
//

import UIKit
import Alamofire

class EmployeHomeVC: UIViewController {

    @IBOutlet weak var btnActiveJob: UIButton!
    @IBOutlet weak var btnNewJob: UIButton!
    @IBOutlet weak var activeContainerView: UIView!
    @IBOutlet weak var newContainerView: UIView!
    @IBOutlet weak var lblNotification: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activeContainerView.isHidden = false
        self.newContainerView.isHidden = true
        self.tappedActive()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
        self.getUserProfileDetials()
//        self.setNavigationBarItem(LeftTitle: "", LeftImage: "back", CenterTitle: "Projects", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "", BackgroundImage: "", TextColor: "", TintColor: "", Menu: "")
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
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "EmployeNotificationVC") as! EmployeNotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnActiveJob(_ sender: UIButton) {
        self.activeContainerView.isHidden = false
        self.newContainerView.isHidden = true
        self.tappedActive()
        self.tappedNew1()
    }
    
    @IBAction func btnNewJob(_ sender: UIButton) {
        self.activeContainerView.isHidden = true
        self.newContainerView.isHidden = false
        self.tappedNew()
        self.tappedActive1()
    }
    
    func tappedActive() {
        self.btnActiveJob.backgroundColor = .black
        self.btnActiveJob.setTitleColor(UIColor.systemYellow, for: .normal)
    }
    
    func tappedNew() {
        self.btnNewJob.backgroundColor = .black
        self.btnNewJob.setTitleColor(UIColor.systemYellow, for: .normal)
    }
    
    func tappedActive1(){
        self.btnActiveJob.backgroundColor = .black
        self.btnActiveJob.setTitleColor(UIColor.white, for: .normal)
    }
    
    func tappedNew1() {
        self.btnNewJob.backgroundColor = .black
        self.btnNewJob.setTitleColor(UIColor.white, for: .normal)
    }
}
