//
//  EmployeApprovedContainer.swift
//  Labour Hub Sydeny
//
//  Created by mac on 11/04/23.
//

import UIKit
import Alamofire

class EmployeApprovedContainer: UIViewController {

    @IBOutlet weak var approvedTableView: UITableView!
    @IBOutlet weak var lblHidden: UILabel!
    
    let identifier = "ApprovedTImeCell"
    var arrTimesheetProject: [ResTimeSheetProject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.approvedTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
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
            "signature_status": "Yes"
        ]
        
        print(paramDetails)
        
        
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
                        self.approvedTableView.reloadData()
                    }
                }
            }catch {
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
}

extension EmployeApprovedContainer: UITableViewDataSource {
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
            vc.signStatus = "Yes"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        return cell
    }
}

extension EmployeApprovedContainer: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
