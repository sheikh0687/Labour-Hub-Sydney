//
//  EmployeNewTimesheetVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 10/04/23.
//

import UIKit
import DropDown
import Alamofire

class EmployeNewTimesheetVC: UIViewController, YPSignatureDelegate {
    
    @IBOutlet weak var btnClientdrop: UIButton!
    @IBOutlet weak var btnProjectDrop: UIButton!
    @IBOutlet weak var textSiteManager: UITextField!
    @IBOutlet weak var textLunchBreak: UITextField!
    @IBOutlet weak var btnSelectDateOt: UIButton!
    @IBOutlet weak var btnStartTimeOt: UIButton!
    @IBOutlet weak var btnEndTimeOt: UIButton!
    @IBOutlet weak var signView: Canvas!
    @IBOutlet weak var scroolView: UIScrollView!
    @IBOutlet weak var signatureView: YPDrawSignatureView!
    //    @IBOutlet weak var signatureView: SignatureView!
    
    let dropDown = DropDown()
    let dropDrow2 = DropDown()
    var arrCategoryList: [ResEmpCategoryList] = []
    var arrProjectList: [ResClientProjectList] = []
    var arrImage:[[String: AnyObject]] = []
    var selectedClientId = ""
    var selectedCategoryName = ""
    var selectedProjectId = ""
    var selectedProjectName = ""
    var selectedId = ""
    var strDate = ""
    var strStartTime = ""
    var strEndTime = ""
    var signatureStatus = ""
    var selectedRequestId = ""
    var selectedServiceId = ""
    private var signatureData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signatureView.delegate = self
        //        NSLayoutConstraint.activate([
        //                  signatureView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        //                  signatureView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        //                  signatureView.topAnchor.constraint(equalTo: view.topAnchor),
        //                  signatureView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        //              ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        //        signatureView.translatesAutoresizingMaskIntoConstraints = false
        self.showProgressBar()
        self.getCategoryList()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view == signView {
                self.scroolView.isScrollEnabled = false
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view == signView {
                self.scroolView.isScrollEnabled = true
            }
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnClient(_ sender: UIButton) {
        self.dropDown.show()
    }
    
    
    func getCategoryList() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_client_assign_project_by_emp?"
        
        let paramDetails = [
            "employee_id": UserDefaults.standard.value(forKey: "user_id") as! String
        ]
        
        print(paramDetails)
        
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            if let responseData = response.data {
                do {
                    
                    let root = try JSONDecoder().decode(GetEmpCategoryList.self, from: responseData)
                    print(root)
                    if let CategoryListStatus = root.status {
                        if CategoryListStatus == "1" {
                            self.hideProgressBar()
                            self.arrCategoryList = root.result ?? []
                        }else{
                            self.hideProgressBar()
                            self.arrCategoryList = []
                        }
                        DispatchQueue.main.async {
                            self.configureCategoryDropdown()
                        }
                    }
                }catch {
                    self.hideProgressBar()
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func configureCategoryDropdown() {
        var arrCategoryId:[String] = []
        var arrCategoryName:[String] = []
        for val in self.arrCategoryList {
            arrCategoryId.append(val.id ?? "")
            arrCategoryName.append(("\(val.first_name ?? "") \(val.last_name ?? "")"))
        }
        dropDown.anchorView = self.btnClientdrop
        dropDown.dataSource = arrCategoryName
        dropDown.bottomOffset = CGPoint(x: -5, y: 45)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectedClientId = arrCategoryId[index]
            self.selectedCategoryName = item
            self.getProjectList()
            self.btnClientdrop.setTitle(item, for: .normal)
        }
    }
    
    
    @IBAction func btnProject(_ sender: UIButton) {
        self.dropDrow2.show()
    }
    
    func getProjectList() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_project_by_client?"
        
        let paramDetails = [
            "client_id": self.selectedClientId,
            "employee_id": UserDefaults.standard.value(forKey: "user_id") as! String
        ]
        
        print(paramDetails)
        
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            if let responseData = response.data {
                do {
                    
                    let root = try JSONDecoder().decode(GetEmpProjectByClient.self, from: responseData)
                    print(root)
                    if let CategoryListStatus = root.status {
                        if CategoryListStatus == "1" {
                            self.arrProjectList = root.result ?? []
                            if self.arrProjectList.count > 0 {
                                self.selectedRequestId = root.result?[0].request_service_id ?? ""
                                self.selectedServiceId = root.result?[0].service_list?.id ?? ""
                            }
                        }else{
                            self.arrProjectList = []
                        }
                        DispatchQueue.main.async {
                            self.configureProjectDropdown()
                        }
                    }
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func configureProjectDropdown() {
        var arrProjectId:[String] = []
        var arrProjectName:[String] = []
        var arrRequestId: [String] = []
        for val in self.arrProjectList {
            arrProjectId.append(val.request_id ?? "")
            arrProjectName.append(val.project_details?.title ?? "")
            arrRequestId.append(val.request_service_id ?? "")
        }
        dropDrow2.anchorView = self.btnProjectDrop
        dropDrow2.dataSource = arrProjectName
        dropDrow2.bottomOffset = CGPoint(x: -5, y: 45)
        dropDrow2.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectedProjectId = arrProjectId[index]
            print(selectedProjectId)
            self.selectedProjectName = item
            self.btnProjectDrop.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func btnDate(_ sender: UIButton) {
        datePickerTapped(strFormat: "YYYY-MM-dd", mode: .date) { dateString in
            self.strDate = dateString
            self.btnSelectDateOt.setTitle(dateString, for: .normal)
        }
    }
    
    @IBAction func btnStartTime(_ sender: UIButton) {
        //let datee = Date()
        self.datePickerTapped(strFormat: "HH:mm", mode: .time) { dateString in
            self.strStartTime = dateString
            print(self.strStartTime)
            self.btnStartTimeOt.setTitle(dateString, for: .normal)
        }
    }
    
    @IBAction func btnEndTime(_ sender: UIButton) {
        self.datePickerTapped(strFormat: "HH:mm", mode: .time) { dateString in
            self.strEndTime = dateString
            print(self.strEndTime)
            self.btnEndTimeOt.setTitle(dateString, for: .normal)
        }
    }
    
    @IBAction func btnSubmitWithoutSign(_ sender: UIButton) {
        self.signatureStatus = "No"
        self.timesheetValidation2()
    }
    
    @IBAction fileprivate func clearSignature(_ sender: UIButton) {
        self.signatureView.clear()
    }
    
    func didStart(_ view: YPDrawSignatureView) {
        self.scroolView.isScrollEnabled = false
    }
    
    func didFinish(_ view: YPDrawSignatureView) {
        self.scroolView.isScrollEnabled = true
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        self.signatureStatus = "Yes"
        self.timesheetValidation1()
    }
    
    func timesheetValidation1()
    {
        if self.selectedClientId.isEmpty
        {
            self.alert(alertmessage: "Please Select Client!")
        }
        else if self.selectedProjectId.isEmpty
        {
            self.alert(alertmessage: "Please Select Project!")
        }
        else if textSiteManager.text!.isEmpty
        {
            self.alert(alertmessage: "Please enter the Site Manager name!")
        }
        else if self.strDate.isEmpty
        {
            self.alert(alertmessage: "Please Select Date!")
        }
        else if strStartTime.isEmpty
        {
            self.alert(alertmessage: "Please Start Date!")
        }
        else if strEndTime.isEmpty
        {
            self.alert(alertmessage: "Please Select End Date!")
        }
        else if signatureView.isEmpty
        {
            self.alert(alertmessage: "Please Submit your Signature!")
        }
        else
        {
            Api.shared.addNewTimesheet(self, self.paramAddTimesheetDetails(), images: self.imageDictAddTimesheet(), videos: [:]) { responseData in
                Utility.showAlertWithAction(withTitle: k.appName, message: "New Timesheet Added Successfully!", delegate: nil, parentViewController: self) { bool in
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func timesheetValidation2()
    {
        if self.selectedClientId.isEmpty
        {
            self.alert(alertmessage: "Please Select Client!")
        }
        else if self.selectedProjectId.isEmpty
        {
            self.alert(alertmessage: "Please Select Project!")
        }
        else if textSiteManager.text!.isEmpty
        {
            self.alert(alertmessage: "Please enter the Site Manager name!")
        }
        else if self.strDate.isEmpty
        {
            self.alert(alertmessage: "Please Select Date!")
        }
        else if strStartTime.isEmpty
        {
            self.alert(alertmessage: "Please select start time!")
        }
        else if strEndTime.isEmpty
        {
            self.alert(alertmessage: "Please select end time!")
        }
        else
        {
            Api.shared.addNewTimesheet(self, self.paramAddTimesheetDetails(), images: [:], videos: [:]) { responseData in
                Utility.showAlertWithAction(withTitle: k.appName, message: "New Timesheet Added Successfully!", delegate: nil, parentViewController: self) { bool in
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func paramAddTimesheetDetails() -> [String: String] {
        let paramAnswer =
        [
            "worker_id": UserDefaults.standard.value(forKey: "user_id") as! String,
            "request_id": self.selectedProjectId,
            "request_service_id": self.selectedRequestId,
            "assign_id": self.selectedServiceId,
            "client_id": self.selectedClientId,
            "site_manager_name": self.textSiteManager.text!,
            "lunch_break_duration": self.textLunchBreak.text!,
            "start_date": self.strDate,
            "start_time": self.strStartTime,
            "signature_status": self.signatureStatus,
            "end_time": self.strEndTime,
            "signature": self.signatureStatus
        ]
        print(paramAnswer)
        return paramAnswer
    }
    
    func imageDictAddTimesheet() -> [String: UIImage] {
        var dict : [String: UIImage] = [:]
        if let images = signatureView.getSignature() {
            print(images)
            dict["signature_image"] = images
        }
        print(dict)
        return dict
    }
}






