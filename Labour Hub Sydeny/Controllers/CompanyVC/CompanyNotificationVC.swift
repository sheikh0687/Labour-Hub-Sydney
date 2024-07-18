//
//  CompanyNotificationVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 13/05/23.
//

import UIKit
import Alamofire

class CompanyNotificationVC: UIViewController {

    @IBOutlet weak var notificationTableView: UITableView!
    @IBOutlet weak var lblHidden: UILabel!
    
    let identifier = "NotificationCell"
    var arrNotificationList: [ResNotification] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.notificationTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.showProgressBar()
        self.notificationList()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func btnBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func notificationList() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_user_notification_list?"
        let paramDetails =
        [
            "user_id": UserDefaults.standard.value(forKey: "user_id") as! String
        ]
        
        print(paramDetails)
        
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            let data = response.data
            do{
                let decoder = JSONDecoder()
                let root = try decoder.decode(getNotificationList.self, from: data!)
                if let notifyStatus = root.status{
                    if notifyStatus == "1"{
                        self.hideProgressBar()
                        self.arrNotificationList = root.result ?? []
                        self.lblHidden.isHidden = true
                    }else{
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                        self.lblHidden.isHidden = false
                    }
                    DispatchQueue.main.async {
                        self.notificationTableView.reloadData()
                    }
                }
            }catch{
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
}

extension CompanyNotificationVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrNotificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        cell.lblTitle.text! = self.arrNotificationList[indexPath.row].title ?? ""
        cell.lblSender.text! = self.arrNotificationList[indexPath.row].message ?? ""
        cell.lblDateTime.text! = self.arrNotificationList[indexPath.row].date_time ?? ""
        return cell
    }
}

extension CompanyNotificationVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.arrNotificationList[indexPath.row].title ?? "" == "Time Sheet Submitted" {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "TimesheetVC") as! TimesheetVC
            vc.client_id = self.arrNotificationList[indexPath.row].user_id ?? ""
            vc.selectedProjectId = self.arrNotificationList[indexPath.row].request_id ?? ""
            print(vc.selectedProjectId)
            self.navigationController?.pushViewController(vc, animated: true)
        }else if self.arrNotificationList[indexPath.row].title ?? "" == "Request Accept"{
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "UserProjectDetailVC") as! UserProjectDetailVC
            vc.selectedProjectId = self.arrNotificationList[indexPath.row].request_id ?? ""
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else if self.arrNotificationList[indexPath.row].title ?? "" == "New Project assign" {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "UserProjectDetailVC") as! UserProjectDetailVC
            vc.selectedProjectId = self.arrNotificationList[indexPath.row].request_id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "UserProjectDetailVC") as! UserProjectDetailVC
            vc.selectedProjectId = self.arrNotificationList[indexPath.row].request_id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
