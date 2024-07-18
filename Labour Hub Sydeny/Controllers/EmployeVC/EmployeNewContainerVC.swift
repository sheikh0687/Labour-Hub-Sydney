//
//  EmployeNewContainerVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 11/04/23.
//

import UIKit
import Alamofire

class EmployeNewContainerVC: UIViewController {

    @IBOutlet weak var newTableView: UITableView!
    @IBOutlet weak var lblHidden: UILabel!
    
    let identifier = "ActiveCell"
    var arrEmployeProject: [ResEmployeeProject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showProgressBar()
        self.getEmployeeActivejob()
    }
    
    func getEmployeeActivejob(){
        let url = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_employee_assign_project?"
        let paramDetails =
        [
            "employee_id": UserDefaults.standard.value(forKey: "user_id") as! String,
            "status": "inactive"
        ]
        
        print(paramDetails)
        
        Alamofire.request(url,parameters: paramDetails).response { response in
            let data = response.data
            do{
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetEmployeProject.self, from: data!)
                print(root)
                if let loginStatus = root.status {
                    if loginStatus == "1" {
                        self.hideProgressBar()
                        self.arrEmployeProject = root.result ?? []
                        self.lblHidden.isHidden = true
                    } else {
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                        self.lblHidden.isHidden = false
                    }
                    DispatchQueue.main.async {
                        self.newTableView.reloadData()
                    }
                }
            }catch{
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
}

extension EmployeNewContainerVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrEmployeProject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActiveCell", for: indexPath) as! ActiveCell
        cell.lblTitle.text = self.arrEmployeProject[indexPath.row].title ?? ""
        cell.lblDescription.text = self.arrEmployeProject[indexPath.row].description ?? ""
        return cell
    }
}


