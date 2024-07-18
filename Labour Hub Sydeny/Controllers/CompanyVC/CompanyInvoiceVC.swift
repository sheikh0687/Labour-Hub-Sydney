//
//  CompanyInvoiceVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 11/04/23.
//

import UIKit
import Alamofire
import DropDown

class CompanyInvoiceVC: UIViewController {
    
    @IBOutlet weak var btnDrop: UIButton!
    @IBOutlet weak var btnDrop2: UIButton!
    @IBOutlet weak var btnStartDate: UIButton!
    @IBOutlet weak var btnEndDate: UIButton!
    @IBOutlet weak var lblValue1: UILabel!
    @IBOutlet weak var lblValue2: UILabel!
    
    let dropDown = DropDown()
    let dropDown2 = DropDown()
    var selectedClientId = ""
    var selectedClientName = ""
    var selectedProjectId = ""
    var selectedProjectName = ""
    var selectedProjectIdSend = ""
    var strStartDate = ""
    var strEndDate = ""
    var arrCLientProject: [ResClientProjectDetail] = []
    var arrProjectList: [ResAllClientProject] = []
    var getSelectedId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func btnback(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnStartDate(_ sender: UIButton) {
        datePickerTapped(strFormat: "YYYY-MM-dd", mode: .date) { dateString in
            self.strStartDate = dateString
            self.btnStartDate.setTitle(dateString, for: .normal)
        }
    }
    
    @IBAction func btnEndDate(_ sender: UIButton) {
        datePickerTapped(strFormat: "YYYY-MM-dd", mode: .date) { dateString in
            self.strEndDate = dateString
            self.btnEndDate.setTitle(dateString, for: .normal)
        }
    }
    
    @IBAction func btnDropCLientList(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "PreClientInvoiceNameVC") as! PreClientInvoiceNameVC
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
    
    @IBAction func btnDropDown2(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "PreInvoiceProjectVC") as! PreInvoiceProjectVC
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
    
    @IBAction func btnInvoice(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "CompanyInvoiceDetails") as! CompanyInvoiceDetails
        vc.selectedProjectId = self.selectedProjectId
        print(vc.selectedProjectId)
        vc.selctedClientId = self.getSelectedId
        print(vc.selctedClientId)
        vc.startDate = self.strStartDate
        vc.endDate = self.strEndDate
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnCreateInvoice(_ sender: UIButton) {
        if doesNotContainComma(getSelectedId)
        {
            self.alert(alertmessage: "Please Select Single Client Name!")
        }
        else if doesNotContainComma(selectedProjectId)
        {
            self.alert(alertmessage: "Please Select Single Project!")
        }
        else
        {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "CompanyNewInvoiceVC") as! CompanyNewInvoiceVC
            vc.clientId = self.getSelectedId
            print(vc.clientId)
            vc.ProjectID = self.selectedProjectId
            print(vc.ProjectID)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func doesNotContainComma(_ input : String) -> Bool {
        return input.contains(",")
    }
}
