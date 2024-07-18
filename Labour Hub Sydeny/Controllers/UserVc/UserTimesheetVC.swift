//
//  UserTimesheetVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 06/04/23.
//

import UIKit
import Alamofire
import SDWebImage

class UserTimesheetVC: UIViewController {
    
    @IBOutlet weak var timesheetTableView: UITableView!
    @IBOutlet weak var lblHidden: UILabel!
    
    let identifier = "CellForTimeSheet"
    var selectedProjectId = ""
    var arrTimesheetdt: [ResTimesheetDt] = []
    var arrProjectDt: Project_details?
    var signatureId = ""
    var client_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timesheetTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.showProgressBar()
        self.getTimesheet()
    }
    
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getTimesheet(){
        let url = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_time_sheet_by_client?"
        let paramDetails =
        [
            "client_id": UserDefaults.standard.value(forKey: "user_id") as! String,
            "project_id": self.selectedProjectId
        ]
        
        print(paramDetails)
        
        Alamofire.request(url,parameters: paramDetails).response { response in
            let data = response.data
            do{
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetTimesheetDetails.self, from: data!)
                print(root)
                if let loginStatus = root.status {
                    if loginStatus == "1" {
                        self.hideProgressBar()
                        self.arrTimesheetdt = root.result ?? []
                        self.lblHidden.isHidden = true
                    } else {
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                        self.lblHidden.isHidden = false
                    }
                    DispatchQueue.main.async {
                        self.timesheetTableView.reloadData()
                    }
                }
            }catch{
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
    
    func paramAddSignature() -> [String: String] {
        let paramAnswer =
        [
            "id": self.signatureId,
            "signature_status": "Yes",
        ]
        
        print(paramAnswer)
        
        return paramAnswer
    }
    
    func imageDictAddTimesheet(_ image : UIImage) -> [String: UIImage] {
        var dict : [String: UIImage] = [:]
        dict["signature_image"] = image
        print(dict)
        return dict
    }
}

extension UserTimesheetVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrTimesheetdt.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellForTimeSheet", for: indexPath) as! CellForTimeSheet
        cell.lblTitle.text = self.arrTimesheetdt[indexPath.row].project_details?.title ?? ""
        cell.lblAddress.text = self.arrTimesheetdt[indexPath.row].project_details?.address ?? ""
        cell.lblStartDate.text = self.arrTimesheetdt[indexPath.row].date ?? ""
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
        
        cell.btnHide.isHidden = true
        
        cell.cloApprove =
        {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "E_SignatureVC") as! E_SignatureVC
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            
            vc.cloSubmit = { img in
                self.signatureId = self.arrTimesheetdt[indexPath.row].id ?? ""
                print(self.signatureId)
                Api.shared.addSignature(vc, self.paramAddSignature(), images: self.imageDictAddTimesheet(img), videos: [:]) { responseData in
                    self.getTimesheet()
                    self.alert(alertmessage: "Approved!")
                }
            }
            
            self.present(vc, animated: true, completion: nil)
        }
        
        if self.arrTimesheetdt[indexPath.row].signature_status ?? "" == "No" {
            cell.btnApprove.isHidden = false
        }else{
            cell.btnApprove.isHidden = true
        }
        
        return cell
    }
}
