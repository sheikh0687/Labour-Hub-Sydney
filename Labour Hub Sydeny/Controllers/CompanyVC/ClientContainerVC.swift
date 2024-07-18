//
//  ClientContainerVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 27/03/23.
//

import UIKit
import Alamofire
import SDWebImage

class ClientContainerVC: UIViewController {

    @IBOutlet weak var clientTableView: UITableView!
    @IBOutlet weak var lblHidden: UILabel!
    
    let identifier = "CellForClients"
    var arrCLientProject: [ResClientProjectDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clientTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showProgressBar()
        self.clientProjects()
    }
    
    func clientProjects()
    {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_company_user?"
        let paramDetails =
        [
            "company_code": k.userDefault.value(forKey: k.session.commonCompanyCode) as! String
        ]
        
        Alamofire.request(urlString,parameters: paramDetails).response { response in
            let data = response.data
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetClientProject.self, from: data!)
                if let projectStatus = root.status {
                    if projectStatus == "1"{
                        self.hideProgressBar()
                        self.arrCLientProject = root.result ?? []
                        self.lblHidden.isHidden = true
                    }else{
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                        self.lblHidden.isHidden = false
                    }
                    DispatchQueue.main.async {
                        self.clientTableView.reloadData()
                    }
                }
            }catch{
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteClientAccount()
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
                        self.clientProjects()
                    }else{
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                    }
                    DispatchQueue.main.async {
                        self.clientTableView.reloadData()
                    }
                }
            }catch{
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
}

extension ClientContainerVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrCLientProject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellForClients", for: indexPath) as! CellForClients
        cell.lblClientName.text = "\(self.arrCLientProject[indexPath.row].first_name ?? "") \(self.arrCLientProject[indexPath.row].last_name ?? "")"
        cell.lblClientEmail.text = self.arrCLientProject[indexPath.row].email ?? ""
        
        if let imageUrl = URL(string: self.arrCLientProject[indexPath.row].image ?? ""){
            cell.imageOutlet.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "profile_ic"), options: .continueInBackground,completed: nil)
        }
        
        cell.cloTimesheet = {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "CompanyTimeSheetVC") as! CompanyTimeSheetVC
            vc.selectedProjectId = self.arrCLientProject[indexPath.row].id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.cloPresent = {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "PresentUserDeleteVC") as! PresentUserDeleteVC
            
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            
            vc.cloCancel = {
                self.dismiss(animated: true)
            }
            
            vc.cloOk = {
                self.showProgressBar()
                self.deleteClientAccount()
            }
            
            self.present(vc, animated: true, completion: nil)
        }
        return cell
    }
}

extension ClientContainerVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "CompanyClientProfileVC") as! CompanyClientProfileVC
        vc.userId = self.arrCLientProject[indexPath.row].id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
