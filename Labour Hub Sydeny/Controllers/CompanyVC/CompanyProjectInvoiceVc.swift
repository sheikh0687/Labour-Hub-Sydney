//
//  CompanyProjectInvoiceVc.swift
//  Labour Hub Sydeny
//
//  Created by mac on 02/05/23.
//

import UIKit

class CompanyProjectInvoiceVc: UIViewController {

    @IBOutlet weak var btnAllOt: UIButton!
    @IBOutlet weak var btnPendingOt: UIButton!
    @IBOutlet weak var btnOverDueOt: UIButton!
    @IBOutlet weak var allContainer: UIView!
    @IBOutlet weak var pendingContainer: UIView!
    @IBOutlet weak var overDueContainer: UIView!
    
    var passedValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.allContainer.isHidden = false
        self.pendingContainer.isHidden = true
        self.overDueContainer.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.tappedOne()
        self.tappedTwoR()
        self.tappedThreeR()
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAll(_ sender: UIButton) {
        self.tappedOne()
        self.tappedTwoR()
        self.tappedThreeR()
        self.allContainer.isHidden = false
        self.pendingContainer.isHidden = true
        self.overDueContainer.isHidden = true
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "YourSegueIdentifier" {
                if let destinationVC = segue.destination as? ProjectInvoiceAllContainerVC {
                    destinationVC.selectedValue = "Hello Is working?"
                }
            }
        }
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


