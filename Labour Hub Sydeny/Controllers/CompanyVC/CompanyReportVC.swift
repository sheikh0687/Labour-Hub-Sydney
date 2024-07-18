//
//  CompanyReportVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 11/04/23.
//

import UIKit
import Alamofire
import DropDown

class CompanyReportVC: UIViewController {
    
    @IBOutlet weak var btnDrop: UIButton!
    @IBOutlet weak var btnDrop2: UIButton!
    @IBOutlet weak var btnStartDate: UIButton!
    @IBOutlet weak var btnEndDate: UIButton!
    @IBOutlet weak var lblValue1: UILabel!
    @IBOutlet weak var lblValue2: UILabel!
    @IBOutlet weak var view1height: NSLayoutConstraint!
    @IBOutlet weak var view2Height: NSLayoutConstraint!
    
    
    let dropDown = DropDown()
    let dropDown2 = DropDown()
    
    var strStartDate = ""
    var strtEndDate = ""
    var selectedClientId = ""
    var selectedClientName = ""
    var arrCLientProject: [ResClientProjectDetail] = []
    var selectedProjectId = ""
    var selectedProjectName = ""
    var arrProjectList: [ResAllClientProject] = []
    var getSelectedId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.showProgressBar()
        self.getClientProjectList()
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnStart(_ sender: UIButton) {
        datePickerTapped(strFormat: "YYYY-MM-dd", mode: .date) { dateString in
            self.strStartDate = dateString
            self.btnStartDate.setTitle(dateString, for: .normal)
        }
    }
    
    @IBAction func btnEnd(_ sender: UIButton) {
        datePickerTapped(strFormat: "YYYY-MM-dd", mode: .date) { dateString in
            self.strtEndDate = dateString
            self.btnEndDate.setTitle(dateString, for: .normal)
        }
    }
    
    @IBAction func btnDropCLientList(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "PresentClientListVC") as! PresentClientListVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        
        vc.cloSelectedvalue = {takeVaue in
            self.lblValue1.text! = takeVaue
        }
        
        vc.sendSelectdId = { takeSendId in
            self.getSelectedId = takeSendId
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func getClientProjectList() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_company_user?"
        let paramDetails =
        [
            "company_code": k.userDefault.value(forKey: k.session.commonCompanyCode) as! String
        ]
        
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            if let responseData = response.data {
                do {
                    
                    let root = try JSONDecoder().decode(GetClientProject.self, from: responseData)
                    print(root)
                    if let CategoryListStatus = root.status {
                        if CategoryListStatus == "1" {
                            self.hideProgressBar()
                            self.arrCLientProject = root.result ?? []
                        }else{
                            self.hideProgressBar()
                            print("Something Went Wrong!")
                        }
                        DispatchQueue.main.async {
                            self.configureClientDropdown()
                        }
                    }
                }catch {
                    self.hideProgressBar()
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func configureClientDropdown() {
        var arrClientProjectId:[String] = []
        var arrClientProjectName:[String] = []
        for val in self.arrCLientProject {
            arrClientProjectId.append(val.id ?? "")
            arrClientProjectName.append("\(val.first_name ?? "") \(val.last_name ?? "")")
        }
        dropDown.anchorView = self.btnDrop
        dropDown.dataSource = arrClientProjectName
        dropDown.bottomOffset = CGPoint(x: -5, y: 45)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectedClientId = arrClientProjectId[index]
            self.selectedClientName = item
            self.getAllProjectList()
            self.btnDrop.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func btnProject(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "PresentProjectListVC") as! PresentProjectListVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        
        vc.ClientID = self.getSelectedId
        
        vc.cloSelectedvalue = {takeVaue in
            self.lblValue2.text! = takeVaue
        }
        
        vc.sendSelectdId = { takeSendId in
            self.selectedProjectId = takeSendId
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func getAllProjectList() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_all_project_by_client?"
        let paramDetails =
        [
            "client_id": self.selectedClientId
        ]
        
        print(paramDetails)
        
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            if let responseData = response.data {
                do {
                    
                    let root = try JSONDecoder().decode(GetClientAllProjects.self, from: responseData)
                    print(root)
                    if let CategoryListStatus = root.status {
                        if CategoryListStatus == "1" {
                            self.arrProjectList = root.result ?? []
                        }else{
                            self.arrProjectList = []
                        }
                        DispatchQueue.main.async {
                            self.configureProjectDropdown()
                        }
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func configureProjectDropdown() {
        var arrAllClientProjectId:[String] = []
        var arrAllClientProjectName:[String] = []
        for val in self.arrProjectList {
            arrAllClientProjectId.append(val.request_id ?? "")
            arrAllClientProjectName.append(val.project_details?.title ?? "")
        }
        
        dropDown2.anchorView = self.btnDrop2
        dropDown2.dataSource = arrAllClientProjectName
        dropDown2.bottomOffset = CGPoint(x: -5, y: 45)
        dropDown2.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectedProjectId = arrAllClientProjectId[index]
            print(self.selectedProjectId)
            self.selectedProjectName = item
            self.btnDrop2.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func btnReport(_ sender: UIButton) {
        if self.selectedProjectId == "" {
            self.alert(alertmessage: "Please select project!")
        }else{
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "CompanyDetailReportVC") as! CompanyDetailReportVC
            vc.clientId = self.getSelectedId
            vc.projectId = self.selectedProjectId
            vc.startDate = self.strStartDate
            vc.endDate = self.strtEndDate
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func btnViewAllReport(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "CompanyDetailReportVC") as! CompanyDetailReportVC
        vc.clientId = self.getSelectedId
        vc.projectId = self.selectedProjectId
        vc.startDate = self.strStartDate
        vc.endDate = self.strtEndDate
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
