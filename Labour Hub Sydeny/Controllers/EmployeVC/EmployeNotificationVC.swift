//
//  EmployeNotificationVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 11/04/23.
//

import UIKit
import Alamofire

class EmployeNotificationVC: UIViewController {

    @IBOutlet weak var notificationTableView: UITableView!
    @IBOutlet weak var lblHidden: UILabel!
    
    let identifier = "NotificationCell"
    var arrNotificationList: [ResNotification] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notificationTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.showProgressBar()
        self.notificationList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true
        )
    }
    
    func notificationList(){
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_user_notification_list?"
        let paramDetails = [
            "user_id": UserDefaults.standard.value(forKey: "user_id") as! String
        ]
        
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

extension EmployeNotificationVC: UITableViewDataSource {
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

extension EmployeNotificationVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.arrNotificationList[indexPath.row].title ?? "" == "Time Sheet Submitted" {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "TimesheetVC") as! TimesheetVC
            vc.client_id = self.arrNotificationList[indexPath.row].user_id ?? ""
            vc.selectedProjectId = self.arrNotificationList[indexPath.row].request_id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }else if self.arrNotificationList[indexPath.row].title ?? "" == "Request Accept"{
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "UserProjectDetailVC") as! UserProjectDetailVC
            vc.selectedProjectId = self.arrNotificationList[indexPath.row].request_id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        } else if self.arrNotificationList[indexPath.row].title ?? "" == "New Project assign" {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "EmployeeProjectDetails") as! EmployeeProjectDetails
            vc.selectedProjectId = self.arrNotificationList[indexPath.row].request_id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "EmployeeProjectDetails") as! EmployeeProjectDetails
            vc.selectedProjectId = self.arrNotificationList[indexPath.row].request_id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
