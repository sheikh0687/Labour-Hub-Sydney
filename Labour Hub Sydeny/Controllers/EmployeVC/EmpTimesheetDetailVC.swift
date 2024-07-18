//
//  EmpTimesheetDetailVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 14/04/23.
//

import UIKit
import Alamofire
import SDWebImage

class EmpTimesheetDetailVC: UIViewController {

    @IBOutlet weak var timesheetTableView: UITableView!
    @IBOutlet weak var lblHidden: UILabel!
    
    let identifier = "CellForTimeSheet"
    var arrTimesheetdt: [ResEmpTimesheetDt] = []
    var selectedProjectId = ""
    var signStatus = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.timesheetTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.getTimesheet()
    }
    
    @IBAction func btnBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getTimesheet()
    {
        let url = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_time_sheet_by_worker?"
        let paramDetails =
        [
            "worker_id": UserDefaults.standard.value(forKey: "user_id") as! String,
            "project_id": self.selectedProjectId,
            "signature_status": self.signStatus
        ]
        
        print(paramDetails)
        
        Alamofire.request(url,parameters: paramDetails).response { response in
            let data = response.data
            do{
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetEmpTimesheetDetail.self, from: data!)
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
                        self.timesheetTableView.reloadData()
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}

extension EmpTimesheetDetailVC: UITableViewDataSource {
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
            cell.imageOutlet.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "Unknownblank1"), options: .continueInBackground,completed: nil)
        }
        
        cell.btnHide.isHidden = true
        cell.btnApprove.isHidden = true
        
        return cell
    }
}


