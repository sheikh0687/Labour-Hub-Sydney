//
//  CompanyWorkerTimesheetVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 20/04/23.
//

import UIKit
import Alamofire

class CompanyWorkerTimesheetVC: UIViewController {

    @IBOutlet weak var workerTimesheetVC: UITableView!
    @IBOutlet weak var lblHidden: UILabel!
    
    let identifier = "CellForTimeSheet"
    var selectedProjectId = ""
    var arrTimesheetdt: [ResWorkerTimesheet] = []
    var deletedId = ""
    var project_id = ""
    var id = ""
    var type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.workerTimesheetVC.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.getTimesheet()
    }
    
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getTimesheet() {
        
        let url = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_time_sheet_by_worker?"
        
        let paramDetails = [
            "worker_id": self.selectedProjectId,
            "project_id": self.project_id,
            "signature_status": ""
        ]
        
        print(paramDetails)
        
        Alamofire.request(url,parameters: paramDetails).response { response in
            let data = response.data
            do{
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetTimesheetByWOrker.self, from: data!)
                print(root)
                if let loginStatus = root.status {
                    if loginStatus == "1" {
                        self.arrTimesheetdt = root.result ?? []
                        self.lblHidden.isHidden = true
                    } else {
                        print("Something Went Wrong!")
                        self.lblHidden.isHidden = false
                    }
                    DispatchQueue.main.async {
                        self.workerTimesheetVC.reloadData()
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteTimesheet(){
        let url = "https://labourhubsydney.com.au/LabourHubSydney/webservice/delete_timesheet?"
        let paramDetails =
        [
            "id": self.deletedId
        ]
        
        print(paramDetails)
        
        Alamofire.request(url,parameters: paramDetails).response { response in
            let data = response.data
            do{
                let decoder = JSONDecoder()
                let root = try decoder.decode(DeletedTimesheet.self, from: data!)
                print(root)
                if let loginStatus = root.status {
                    if loginStatus == "1" {
                        self.getTimesheet()
                        self.alert(alertmessage: "Deleted Successfully!")
                    } else {
                        print("Something Went Wrong!")
                    }
                    DispatchQueue.main.async {
                        self.workerTimesheetVC.reloadData()
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}

extension CompanyWorkerTimesheetVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrTimesheetdt.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellForTimeSheet", for: indexPath) as! CellForTimeSheet
        cell.lblTitle.text = self.arrTimesheetdt[indexPath.row].project_details?.title ?? ""
        cell.lblAddress.text = self.arrTimesheetdt[indexPath.row].project_details?.address ?? ""
        cell.lblStartDate.text = self.arrTimesheetdt[indexPath.row].start_date ?? ""
        cell.lblStartTime.text = self.arrTimesheetdt[indexPath.row].start_time ?? ""
        cell.lblEndTime.text = self.arrTimesheetdt[indexPath.row].end_time ?? ""
        cell.lblOvertime.text = "\(self.arrTimesheetdt[indexPath.row].extra_total_time ?? "") Hours"
        cell.lblLunchTime.text = "\(self.arrTimesheetdt[indexPath.row].lunch_break_duration ?? "") Min"
        cell.lblRegular.text = "\(self.arrTimesheetdt[indexPath.row].total_time ?? "") Hours"
        cell.lblEmployename.text = "\(self.arrTimesheetdt[indexPath.row].worker_details?.first_name ?? "") \(self.arrTimesheetdt[indexPath.row].worker_details?.last_name ?? "")"
        cell.lblSiteManager.text = self.arrTimesheetdt[indexPath.row].site_manager_name ?? ""
        cell.lblClientName.text = "\(self.arrTimesheetdt[indexPath.row].client_details?.first_name ?? "") \(self.arrTimesheetdt[indexPath.row].client_details?.last_name ?? "")"
        
        if let imageUrl = URL(string: self.arrTimesheetdt[indexPath.row].signature_image ?? "")
        {
            cell.imageOutlet.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder_2"), options: .continueInBackground,completed: nil)
        }
        
        cell.cloDelete = {
            self.deletedId = self.arrTimesheetdt[indexPath.row].id ?? ""
            print(self.deletedId)
            self.deleteTimesheet()
        }
        
        return cell
    }
}

