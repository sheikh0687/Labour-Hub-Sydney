//
//  UserVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 27/03/23.
//

import UIKit

class UserVC: UIViewController {

    @IBOutlet weak var clientOt: UIButton!
    @IBOutlet weak var employeOt: UIButton!
    @IBOutlet weak var clientContainerView: UIView!
    @IBOutlet weak var employeeContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clientContainerView.isHidden = false
        self.employeeContainerView.isHidden = true
        self.tappedActive()
        self.tappedInactive1()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnClient(_ sender: UIButton) {
        self.clientContainerView.isHidden = false
        self.employeeContainerView.isHidden = true
        self.tappedActive()
        self.tappedInactive1()
    }
    
    @IBAction func btnEmployee(_ sender: UIButton) {
        self.clientContainerView.isHidden = true
        self.employeeContainerView.isHidden = false
        self.tappedInactive()
        self.tappedActive1()
    }
    
    func tappedActive() {
        self.clientOt.backgroundColor = .black
        self.clientOt.setTitleColor(UIColor.systemYellow, for: .normal)
    }
    
    func tappedInactive() {
        self.employeOt.backgroundColor = .black
        self.employeOt.setTitleColor(UIColor.systemYellow, for: .normal)
    }
    
    func tappedActive1(){
        self.clientOt.backgroundColor = .black
        self.clientOt.setTitleColor(UIColor.white, for: .normal)
    }
    
    func tappedInactive1() {
        self.employeOt.backgroundColor = .black
        self.employeOt.setTitleColor(UIColor.white, for: .normal)
    }
}
