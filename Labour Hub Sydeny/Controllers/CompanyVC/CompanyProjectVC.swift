//
//  CompanyProjectVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 11/04/23.
//

import UIKit

class CompanyProjectVC: UIViewController {

    @IBOutlet weak var btnExistingProject: UIButton!
    @IBOutlet weak var btnNewProject: UIButton!
    @IBOutlet weak var existingContainer: UIView!
    @IBOutlet weak var newContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.existingContainer.isHidden = false
        self.newContainer.isHidden = true
        self.tappedActive()
        self.tappedInactive1()
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnExisting(_ sender: UIButton) {
        self.existingContainer.isHidden = false
        self.newContainer.isHidden = true
        self.tappedActive()
        self.tappedInactive1()
    }
    
    @IBAction func btnNew(_ sender: UIButton) {
        self.newContainer.isHidden = false
        self.existingContainer.isHidden = true
        self.tappedInactive()
        self.tappedActive1()
    }
    
    func tappedActive() {
        self.btnExistingProject.backgroundColor = .black
        self.btnExistingProject.setTitleColor(UIColor.systemYellow, for: .normal)
    }
    
    func tappedInactive() {
        self.btnNewProject.backgroundColor = .black
        self.btnNewProject.setTitleColor(UIColor.systemYellow, for: .normal)
    }
    
    func tappedActive1(){
        self.btnExistingProject.backgroundColor = .black
        self.btnExistingProject.setTitleColor(UIColor.white, for: .normal)
    }
    
    func tappedInactive1() {
        self.btnNewProject.backgroundColor = .black
        self.btnNewProject.setTitleColor(UIColor.white, for: .normal)
    }
}
