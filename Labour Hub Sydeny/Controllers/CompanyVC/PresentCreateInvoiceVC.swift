//
//  PresentCreateInvoiceVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 02/05/23.
//

import UIKit
import Alamofire

class PresentCreateInvoiceVC: UIViewController {

    @IBOutlet weak var btnIssueDate: UIButton!
    @IBOutlet weak var btnDueDate: UIButton!
    
    var strIssueDate = ""
    var strDueDate = ""
    var selectedIssueDate = ""
    var selectedDueDate = ""
    var selectedProjectId = ""
    var selectedProjectTittle = ""
    var selectedProjectAddress = ""
    var selectedSubTotal = ""
    var selectedTotalGst = ""
    var selectedAud = ""
    var selectedRequestId = ""
    var selectedCatId = ""
    var selectedCatName = ""
    var selectedNoOfWorker = ""
    var selectedHrRate = ""
    var selectedTotalWorkerHour = ""
    var selectedExtraTotalTime = ""
    var selectedDiscount = ""
    var selectedGst = ""
    var selectedFinalPayAmount = ""
    var selectedCompanyName = ""
    var selectedCompanyAddress = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnSelectIssueDate(_ sender: UIButton) {
        datePickerTapped(strFormat: "YYYY-MM-dd", mode: .date) { dateString in
            self.strIssueDate = dateString
            self.btnIssueDate.setTitle(dateString, for: .normal)
    }
}
    
    @IBAction func btnDueDate(_ sender: UIButton) {
        datePickerTapped(strFormat: "YYYY-MM-dd", mode: .date) { dateString in
            self.strDueDate = dateString
            self.btnDueDate.setTitle(dateString, for: .normal)
    }
}
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        self.showProgressBar()
        self.requestedNewInvoice()
    }
    
    func requestedNewInvoice()
    {
        let urlSting = "https://labourhubsydney.com.au/LabourHubSydney/webservice/save_user_request_invoice?"
        let paramDetails =
        [
            "user_id": UserDefaults.standard.value(forKey: "user_id") as! String,
            "company_id": "",
            "company_code": k.userDefault.value(forKey: k.session.commonCompanyCode) as! String,
            "invoicedate": self.strIssueDate,
            "due_date": self.strDueDate,
            "companyname": self.selectedCompanyName,
            "companyaddress": self.selectedCompanyAddress,
            "project_id": self.selectedProjectId,
            "projecttitle": self.selectedProjectTittle,
            "projectaddress": self.selectedProjectAddress,
            "subtotal": self.selectedSubTotal,
            "totalgst": self.selectedTotalGst,
            "totalaud": self.selectedAud,
            "request_service_id": self.selectedRequestId,
            "cat_id": self.selectedCatId,
            "cat_name": self.selectedCatName,
            "NoOfWorker": self.selectedNoOfWorker,
            "HrRate": self.selectedHrRate,
            "TotalWorkHour": self.selectedTotalWorkerHour,
            "ExtraTotalTime": self.selectedExtraTotalTime,
            "Discount": self.selectedDiscount,
            "Gst": self.selectedGst,
            "FianlPayAmount": self.selectedFinalPayAmount
        ]
        
        print(paramDetails)
        
        Alamofire.request(urlSting, parameters: paramDetails).response { response in
            let data = response.data
            do{
                let decode = JSONDecoder()
                let root = try decode.decode(GetClientProjectInvoice.self, from: data!)
                if let invoiceStatus = root.status {
                    if invoiceStatus == "1" {
                        self.hideProgressBar()
                        self.alert(alertmessage: "Successfully Added!")
                    }else{
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                    }
                }
            }catch{
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
}
