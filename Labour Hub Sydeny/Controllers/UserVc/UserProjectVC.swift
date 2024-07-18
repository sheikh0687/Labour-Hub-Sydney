//
//  UserProjectVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 05/04/23.
//

import UIKit

class UserProjectVC: UIViewController {
    
    @IBOutlet weak var btnInactiveOt: UIButton!
    @IBOutlet weak var btnActiveOt: UIButton!
    @IBOutlet weak var activeContainer: UIView!
    @IBOutlet weak var inactiveContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tappedActive()
        self.activeContainer.isHidden = false
        self.inactiveContainer.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActive(_ sender: UIButton) {
        self.tappedActive()
        self.tappedInactive1()
        self.activeContainer.isHidden = false
        self.inactiveContainer.isHidden = true
        
    }
    
    @IBAction func btnInactive(_ sender: UIButton) {
        self.tappedInactive()
        self.tappedActive1()
        self.activeContainer.isHidden = true
        self.inactiveContainer.isHidden = false
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "UserInactiveContainerVC" {
                if let destinationVC = segue.destination as? UserInactiveContainerVC {
                    destinationVC.cloDeclare =
                    {
                        self.alert(alertmessage: "Data Not Available!")
                    }
                }
            }
        }
    }
    
    func tappedActive() {
        self.btnActiveOt.backgroundColor = .black
        self.btnActiveOt.setTitleColor(UIColor.systemYellow, for: .normal)
    }
    
    func tappedInactive() {
        self.btnInactiveOt.backgroundColor = .black
        self.btnInactiveOt.setTitleColor(UIColor.systemYellow, for: .normal)
    }
    
    func tappedActive1(){
        self.btnActiveOt.backgroundColor = .black
        self.btnActiveOt.setTitleColor(UIColor.white, for: .normal)
    }
    
    func tappedInactive1() {
        self.btnInactiveOt.backgroundColor = .black
        self.btnInactiveOt.setTitleColor(UIColor.white, for: .normal)
    }
}

