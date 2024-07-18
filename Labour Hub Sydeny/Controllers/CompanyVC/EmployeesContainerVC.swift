//
//  EmployeesContainerVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 27/03/23.
//

import UIKit
import Alamofire
import SDWebImage

class EmployeesContainerVC: UIViewController {

    @IBOutlet weak var employeeTableView: UITableView!
    @IBOutlet weak var lblHidden: UILabel!
    
    let identifier = "CellForEmployee"
    var arrEmployeProject: [ResCompanyEmpProject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.employeeTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showProgressBar()
        self.employeeProjects()
    }
    
    func employeeProjects()
    {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_company_employee?"
        let paramDetails =
        [
            "company_code": k.userDefault.value(forKey: k.session.commonCompanyCode) as! String
        ]
        
        Alamofire.request(urlString,parameters: paramDetails).response { response in
            let data = response.data
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetCompanyEmpProjects.self, from: data!)
                if let projectStatus = root.status {
                    if projectStatus == "1"{
                        self.hideProgressBar()
                        self.arrEmployeProject = root.result ?? []
                        self.lblHidden.isHidden = true
                    }else{
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                        self.lblHidden.isHidden = false
                    }
                    DispatchQueue.main.async {
                        self.employeeTableView.reloadData()
                    }
                }
            }catch{
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteEmployeAccount()
    {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/delete_account?"
        let paramDetails =
        [
            "user_id": UserDefaults.standard.value(forKey: "user_id") as! String
        ]
        
        Alamofire.request(urlString,parameters: paramDetails).response { response in
            let data = response.data
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(DeleteAccounts.self, from: data!)
                if let projectStatus = root.status {
                    if projectStatus == "1"{
                        self.hideProgressBar()
                        self.alert(alertmessage: "Account Deleted Successfully!")
                        self.employeeProjects()
                    }else{
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                    }
                    DispatchQueue.main.async {
                        self.employeeTableView.reloadData()
                    }
                }
            }catch{
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
}

extension EmployeesContainerVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrEmployeProject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellForEmployee", for: indexPath) as! CellForEmployee
        cell.lblEmpName.text = "\(self.arrEmployeProject[indexPath.row].first_name ?? "") \(self.arrEmployeProject[indexPath.row].last_name ?? "")  (\(self.arrEmployeProject[indexPath.row].cat_name ?? ""))"
        cell.lblEmpEmail.text = self.arrEmployeProject[indexPath.row].email ?? ""
        
        if let imageUrl = URL(string: self.arrEmployeProject[indexPath.row].image ?? ""){
            cell.imageOutlet.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "profile_ic"), options: .continueInBackground,completed: nil)
        }
        
        cell.cloTimesheet = {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "CompanyWorkerTimesheetVC") as! CompanyWorkerTimesheetVC
            vc.selectedProjectId = self.arrEmployeProject[indexPath.row].id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.cloDocument = {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "CompanyEmployeDocumentVC") as! CompanyEmployeDocumentVC
            vc.employeId = self.arrEmployeProject[indexPath.row].id ?? ""
            print(vc.employeId)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.cloPresent = {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "PresentEmployeDeleteVC") as! PresentEmployeDeleteVC
            
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            
            vc.cloCancel = {
                self.dismiss(animated: true)
            }
            
            vc.cloOk = {
                self.showProgressBar()
                self.deleteEmployeAccount()
            }
            
            self.present(vc, animated: true, completion: nil)
        }
        return cell
    }
}

extension EmployeesContainerVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "CompanyEmployeProfileVC") as! CompanyEmployeProfileVC
        vc.userId = self.arrEmployeProject[indexPath.row].id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
