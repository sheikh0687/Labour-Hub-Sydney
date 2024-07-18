//
//  EmployePendingContainerVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 11/04/23.
//

import UIKit
import Alamofire

class EmployePendingContainerVC: UIViewController {
    
    @IBOutlet weak var pendingTableView: UITableView!
    @IBOutlet weak var lblHidden: UILabel!
    
    let identifier = "ApprovedTImeCell"
    var arrTimesheetProject: [ResTimeSheetProject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pendingTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showProgressBar()
        self.getTimesheetProjects()
    }
    
    func getTimesheetProjects() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_time_sheet_project_by_worker?"
        let paramDetails =
        [
            "worker_id": UserDefaults.standard.value(forKey: "user_id") as! String,
            "signature_status": "No"
        ]
        
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            let data = response.data
            do{
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetTimeSheetProjects.self, from: data!)
                if let timesheetStatus = root.status {
                    if timesheetStatus == "1" {
                        self.hideProgressBar()
                        self.arrTimesheetProject = root.result ?? []
                        self.lblHidden.isHidden = true
                    }else {
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                        self.lblHidden.isHidden = false
                    }
                    DispatchQueue.main.async {
                        self.pendingTableView.reloadData()
                    }
                }
            }catch {
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
}

extension EmployePendingContainerVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrTimesheetProject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApprovedTImeCell", for: indexPath) as! ApprovedTImeCell
        cell.lblTitle.text = self.arrTimesheetProject[indexPath.row].title ?? ""
        cell.lblDescription.text = self.arrTimesheetProject[indexPath.row].description ?? ""
        cell.cloTimesheet = {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "EmpTimesheetDetailVC") as! EmpTimesheetDetailVC
            vc.selectedProjectId = self.arrTimesheetProject[indexPath.row].id ?? ""
            vc.signStatus = "No"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
}

extension EmployePendingContainerVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}


