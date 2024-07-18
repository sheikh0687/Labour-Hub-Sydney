//
//  SignUpTypeVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 18/03/23.
//

import UIKit

class SignUpTypeVC: UIViewController {

    @IBOutlet weak var typeTableView: UITableView!
    
    let identifier = "CellForTypes"
    
    var arrImages =
    [
        UIImage(named: "ClientUser.jpg"),
        UIImage(named: "employeeicon.jpg")
    ]
    
    var arrName = ["Client","Employee"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.typeTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SignUpTypeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellForTypes", for: indexPath) as! CellForTypes
        cell.imageOutlet.image = self.arrImages[indexPath.row]
        cell.lblName.text = self.arrName[indexPath.row]
        return cell
    }
}

extension SignUpTypeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ClientSignUpVC") as! ClientSignUpVC
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmployeSignUpVC") as! EmployeSignUpVC
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
