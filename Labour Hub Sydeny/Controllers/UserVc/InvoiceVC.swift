//
//  InvoiceVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 25/03/23.
//

import UIKit
import DropDown
import Alamofire

class InvoiceVC: UIViewController {

    @IBOutlet weak var btnDrop: UIButton!
    @IBOutlet weak var btnStartDate: UIButton!
    @IBOutlet weak var btnEndDate: UIButton!
    
    let dropDown = DropDown()
    var arrProjectList: [ResClientProject] = []
    var selectedProjectId = ""
    var selectedProjectName = ""
    var strStartDate = ""
    var strEndDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.getProjectList()
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnStartDate(_ sender: UIButton) {
        self.datePickerTapped(strFormat: "YYYY-MM-dd", mode: .date) { dateString in
            self.strStartDate = dateString
            self.btnStartDate.setTitle(dateString, for: .normal)
        }
    }
    
    @IBAction func btnEndDate(_ sender: UIButton) {
        self.datePickerTapped(strFormat: "YYYY-MM-dd", mode: .date) { dateString in
            self.strEndDate = dateString
            self.btnEndDate.setTitle(dateString, for: .normal)
        }
    }
    
    @IBAction func btnDropDown(_ sender: UIButton) {
        self.dropDown.show()
    }
    
    func getProjectList() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_all_project_by_client?"
        let paramDetails = [
            "client_id": UserDefaults.standard.value(forKey: "user_id") as! String
        ]
        
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            if let responseData = response.data {
                do {
                    
                    let root = try JSONDecoder().decode(GetCLientProject.self, from: responseData)
                    print(root)
                    if let CategoryListStatus = root.status {
                        if CategoryListStatus == "1" {
                            self.arrProjectList = root.result ?? []
                        }else{
                            self.arrProjectList = []
                        }
                        DispatchQueue.main.async {
                            self.configureCategoryDropdown()
                        }
                    }
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func configureCategoryDropdown() {
        var arrProjectId:[String] = []
        var arrProjectName:[String] = []
        for val in self.arrProjectList {
            arrProjectId.append(val.project_details?.id ?? "")
            arrProjectName.append(val.project_details?.title ?? "")
        }
        dropDown.anchorView = self.btnDrop
        dropDown.dataSource = arrProjectName
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectedProjectId = arrProjectId[index]
            self.selectedProjectName = item
            self.btnDrop.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func btnViewInvoice(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "UserDetailsInvoiceVC") as! UserDetailsInvoiceVC
        vc.projectId = self.selectedProjectId
        vc.selectedStartDate = self.strStartDate
        vc.selectedEndDate = self.strEndDate
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
