//
//  ActiveContainerVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 23/03/23.
//

import UIKit
import Alamofire

class ExistingContainerVC: UIViewController {

    @IBOutlet weak var activeTableView: UITableView!
    @IBOutlet weak var lblHidden: UILabel!
    
    let identifier = "CellForExistingProject"
    var arrAdminProject: [ResAdminProject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activeTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showProgressBar()
        self.adminProject()
    }
    
    func adminProject(){
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_project_admin_side?"
        let paramDetails =
        [
            "status": "Accept",
            "company_code": k.userDefault.value(forKey: k.session.commonCompanyCode) as! String
        ]
        
        print(paramDetails)
        
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            let data = response.data
            do{
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetAdminProject.self, from: data!)
                if let adminStatus = root.status {
                    if adminStatus == "1"{
                        self.hideProgressBar()
                        self.arrAdminProject = root.result ?? []
                        self.lblHidden.isHidden = true
                    }else{
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                        self.lblHidden.isHidden = false
                    }
                    DispatchQueue.main.async {
                        self.activeTableView.reloadData()
                    }
                }
            }catch{
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func btnNewProject(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewProjectVC") as! NewProjectVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ExistingContainerVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrAdminProject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellForExistingProject", for: indexPath) as! CellForExistingProject
        cell.CloSeeDetails = {
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProjectDetailsVC") as! ProjectDetailsVC
            vc.selectedProjectId = self.arrAdminProject[indexPath.row].id ?? ""
            print(vc.selectedProjectId)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.lblTitle.text = self.arrAdminProject[indexPath.row].title ?? ""
        cell.lblDescription.text = self.arrAdminProject[indexPath.row].description ?? ""
        cell.lblStartTime.text = "Start date/time: \(self.arrAdminProject[indexPath.row].start_date ?? "") \(self.arrAdminProject[indexPath.row].start_time ?? "")"
        cell.lblEndTime.text = "End date/time: \(self.arrAdminProject[indexPath.row].end_date ?? "") \(self.arrAdminProject[indexPath.row].end_time ?? "")"
        return cell
    }
}

