//
//  CompanyInvoiceDetails.swift
//  Labour Hub Sydeny
//
//  Created by mac on 19/04/23.
//

import UIKit

var clasObj = CompanyInvoiceDetails()

class CompanyInvoiceDetails: UIViewController {
    
    @IBOutlet weak var btnAllOt: UIButton!
    @IBOutlet weak var btnPendingOt: UIButton!
    @IBOutlet weak var btnOverDueOt: UIButton!
    @IBOutlet weak var allContainer: UIView!
    @IBOutlet weak var pendingContainer: UIView!
    @IBOutlet weak var overDueContainer: UIView!
    
    var selectedProjectId = ""
    var selctedClientId = ""
    var startDate = ""
    var endDate = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.allContainer.isHidden = false
        self.pendingContainer.isHidden = true
        self.overDueContainer.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.tappedOne()
        self.tappedTwoR()
        self.tappedThreeR()
        print(self.selectedProjectId)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "IndentifierContainerAll" {
            let vc = segue.destination as! AllContainerVC
            vc.idProject = self.selectedProjectId
            print(vc.idProject)
            vc.clientId = self.selctedClientId
            vc.selectedStartDate = self.startDate
            vc.selectedEndDate = self.endDate
        }
        
        if segue.identifier == "IndentifierContainerPending" {
            let vc = segue.destination as! PendingContainerVC
            vc.idProject = self.selectedProjectId
            vc.clientId = self.selctedClientId
            vc.selectedStartDate = self.startDate
            vc.selectedEndDate = self.endDate
        }
        
        if segue.identifier == "IndentifierContainerOverDue" {
            let vc = segue.destination as! OverDueContainerVC
            vc.idProject = self.selectedProjectId
            vc.clientId = self.selctedClientId
            vc.selectedStartDate = self.startDate
            vc.selectedEndDate = self.endDate
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAll(_ sender: UIButton) {
        self.tappedOne()
        self.tappedTwoR()
        self.tappedThreeR()
        self.allContainer.isHidden = false
        self.pendingContainer.isHidden = true
        self.overDueContainer.isHidden = true
    }
    
    @IBAction func btnPending(_ sender: UIButton) {
        self.tappedTwo()
        self.tappedOneR()
        self.tappedThreeR()
        self.allContainer.isHidden = true
        self.pendingContainer.isHidden = false
        self.overDueContainer.isHidden = true
    }
    
    @IBAction func btnOverDue(_ sender: UIButton) {
        self.tappedThree()
        self.tappedOneR()
        self.tappedTwoR()
        self.allContainer.isHidden = true
        self.pendingContainer.isHidden = true
        self.overDueContainer.isHidden = false
    }
    
    func tappedOne()
    {
        self.btnAllOt.setTitleColor(.systemYellow, for: .normal)
        self.btnAllOt.backgroundColor = .black
    }
    
    func tappedTwo()
    {
        self.btnPendingOt.setTitleColor(.systemYellow, for: .normal)
        self.btnPendingOt.backgroundColor = .black
    }
    
    func tappedThree()
    {
        self.btnOverDueOt.setTitleColor(.systemYellow, for: .normal)
        self.btnOverDueOt.backgroundColor = .black
    }
    
    func tappedOneR()
    {
        self.btnAllOt.setTitleColor(.white, for: .normal)
        self.btnAllOt.backgroundColor = .black
    }
    
    func tappedTwoR()
    {
        self.btnPendingOt.setTitleColor(.white, for: .normal)
        self.btnPendingOt.backgroundColor = .black
    }
    
    func tappedThreeR()
    {
        self.btnOverDueOt.setTitleColor(.white, for: .normal)
        self.btnOverDueOt.backgroundColor = .black
    }
    
}

