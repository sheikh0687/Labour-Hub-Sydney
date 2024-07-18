//
//  EmployeTimsheetVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 10/04/23.
//

import UIKit

class EmployeTimsheetVC: UIViewController {
    
    @IBOutlet weak var btnApprovedOt: UIButton!
    @IBOutlet weak var btnPendingOt: UIButton!
    @IBOutlet weak var approvedContainer: UIView!
    @IBOutlet weak var pendingContainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tappedApproved()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.pendingContainer.isHidden = true
        self.approvedContainer.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnApproved(_ sender: UIButton) {
        self.approvedContainer.isHidden = false
        self.pendingContainer.isHidden = true
        self.tappedApproved()
        self.tappedPending1()
    }
    
    @IBAction func btnPending(_ sender: UIButton) {
        self.pendingContainer.isHidden = false
        self.approvedContainer.isHidden = true
        self.tappedPending()
        self.tappedApproved1()
    }
    
    func tappedApproved() {
        self.btnApprovedOt.backgroundColor = .black
        self.btnApprovedOt.setTitleColor(UIColor.systemYellow, for: .normal)
    }
    
    func tappedPending() {
        self.btnPendingOt.backgroundColor = .black
        self.btnPendingOt.setTitleColor(UIColor.systemYellow, for: .normal)
    }
    
    func tappedApproved1(){
        self.btnApprovedOt.backgroundColor = .black
        self.btnApprovedOt.setTitleColor(UIColor.white, for: .normal)
    }
    
    func tappedPending1() {
        self.btnPendingOt.backgroundColor = .black
        self.btnPendingOt.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func btnNewTimesheet(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "EmployeNewTimesheetVC") as! EmployeNewTimesheetVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
