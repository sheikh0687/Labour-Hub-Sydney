//
//  UserInactiveContainerVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 05/04/23.
//

import UIKit
import Alamofire

class UserInactiveContainerVC: UIViewController {

    @IBOutlet weak var inactiveTableVIew: UITableView!
    @IBOutlet weak var lblHidden: UILabel!
    
    let identifier = "InactiveProjectCell"
    var arrProject: [ResUserProject] = []
    var cloDeclare: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inactiveTableVIew.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showProgressBar()
        self.getProject()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func getProject() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_my_project?"
        
        let paramDetails =
        [
            "user_id": UserDefaults.standard.value(forKey: "user_id") as! String,
            "status": "inactive"
        ]
        
        print(paramDetails)
        
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            let data = response.data
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetUserProject.self, from: data!)
                print(root)
                if let loginStatus = root.status {
                    if loginStatus == "1"{
                        self.hideProgressBar()
                        self.arrProject = root.result ?? []
                        self.lblHidden.isHidden = true
                    }else{
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                        self.lblHidden.isHidden = false
                    }
                    DispatchQueue.main.async {
                        self.inactiveTableVIew.reloadData()
                    }
                }
            } catch {
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
}

extension UserInactiveContainerVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrProject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InactiveProjectCell", for: indexPath) as! InactiveProjectCell
        cell.lblTitle.text = self.arrProject[indexPath.row].title ?? ""
        cell.lblDescription.text = self.arrProject[indexPath.row].description ?? ""
        cell.cloSeeDetails = {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "UserProjectDetailVC") as! UserProjectDetailVC
            vc.selectedProjectId = self.arrProject[indexPath.row].id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.cloTimesheet = {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "UserTimesheetVC") as! UserTimesheetVC
            vc.selectedProjectId = self.arrProject[indexPath.row].id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
}

extension UserInactiveContainerVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
