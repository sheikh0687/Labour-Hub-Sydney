//
//  CompanyPresentAssignedVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 15/04/23.
//

import UIKit
import Alamofire
import DropDown

class CompanyPresentAssignedVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var btnDrop: UIButton!
    @IBOutlet weak var textDescription: UITextView!
   
    var arrEmployeProject: [ResCompanyEmpProject] = []
    var arrStatusDt: [ResCompanyStatus] = []
    let dropDown = DropDown()
    var selectedEmployeId = ""
    var selectedEmplyeeName = ""
    var selectedEmpName = ""
    var categoryID = ""
    var cloSubmint: ((String) -> Void)?
    var selectedAssignId = ""
    var getSelectedId = ""
    var selectedCatID = ""
    var noOfWorker = ""
    var arrOfCheck: [ResCompanyStatus] = []
    var selectedService = ""
    
    let textView = UITextView()
    let hint = "Enter Description"
    let hintColor = UIColor.lightGray
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textDescription.delegate = self
        textDescription.font = UIFont.systemFont(ofSize: 16)
        textDescription.text = hint
        textDescription.textColor = hintColor
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
           if textDescription.text == hint {
               textDescription.text = ""
               textDescription.textColor = UIColor.black
           }
       }
       

       // UITextViewDelegate method
    func textViewDidEndEditing(_ textView: UITextView) {
            if textDescription.text.isEmpty {
                textDescription.text = hint
                textDescription.textColor = hintColor
            }
        }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnDropDown(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "PresentEmployeStatusVC") as! PresentEmployeStatusVC
        
        vc.selectedCategoryId = self.selectedAssignId
        vc.selectedServiceId = self.selectedService
        print(vc.selectedCategoryId)
        
        vc.totalNoOfWorker = self.noOfWorker
        
        vc.cloSelectedvalue = {takeVaue in
            self.btnDrop.setTitle(takeVaue, for: .normal)
        }
        
        vc.sendSelectdId = { takeSendId in
            self.getSelectedId = takeSendId
        }
        
        vc.cloToCheck = { closubmit in
            self.arrOfCheck = closubmit
        }
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        self.dismiss(animated: true)
        self.cloSubmint?(self.getSelectedId)
    }
}
