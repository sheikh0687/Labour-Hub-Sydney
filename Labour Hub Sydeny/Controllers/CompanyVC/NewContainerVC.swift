import UIKit
import Alamofire

class NewContainerVC: UIViewController {

    @IBOutlet weak var inactiveTableView: UITableView!
    @IBOutlet weak var lblHidden: UILabel!
    
    let identifier = "CellForNewProject"
    var arrAdminProject: [ResAdminProject] = []
    
    var selectedProjectId = ""
    var selectedStatus = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inactiveTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showProgressBar()
        self.adminProject()
    }
    
    func refreshContainer() {
        if let containerViewController = CompanyProjectVC.self as? ExistingContainerVC {
            print("Enter Or Not!")
               containerViewController.activeTableView.reloadData()
           }
       }
    
    func adminProject(){
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_project_admin_side?"
        let paramDetails =
        [
            "status": "Pending",
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
                        print("Something went wrong!")
                        self.lblHidden.isHidden = false
                    }
                    DispatchQueue.main.async {
                        self.inactiveTableView.reloadData()
                       
                    }
                }
            }catch{
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
    
    func projectStatus(){
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/change_project_status?"
        let paramDetails =
        [
            "status": self.selectedStatus,
            "company_id": UserDefaults.standard.value(forKey: "user_id") as! String,
            "project_id": self.selectedProjectId
        ]
        
        print(paramDetails)
        
        Alamofire.request(urlString, parameters: paramDetails).response { [self] response in
            let data = response.data
            do{
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetProjectStatus.self, from: data!)
                if let adminStatus = root.status {
                    if adminStatus == "1"{
                        self.hideProgressBar()
                        self.adminProject()
                    }else{
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                    }
                    DispatchQueue.main.async {
                        self.inactiveTableView.reloadData()
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

extension NewContainerVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrAdminProject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellForNewProject", for: indexPath) as! CellForNewProject
        cell.lblTitle.text = self.arrAdminProject[indexPath.row].title ?? ""
        cell.lblDescription.text = self.arrAdminProject[indexPath.row].description ?? ""
        cell.lblStartTime.text = "Start date/time: \(self.arrAdminProject[indexPath.row].start_date ?? "") \(self.arrAdminProject[indexPath.row].start_time ?? "")"
        cell.lblEndTime.text = "End date/time: \(self.arrAdminProject[indexPath.row].end_date ?? "") \(self.arrAdminProject[indexPath.row].end_time ?? "")"
       
        
        cell.cloAccept = {
            self.showProgressBar()
            self.selectedProjectId = self.arrAdminProject[indexPath.row].id ?? ""
            print(self.selectedProjectId)
            self.selectedStatus = "Accept"
            self.projectStatus()
        }
        
        cell.cloCheck =
        {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "CompanyProjectVC") as! CompanyProjectVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        cell.cloReject = {
            self.showProgressBar()
            self.selectedProjectId = self.arrAdminProject[indexPath.row].id ?? ""
            print(self.selectedProjectId)
            self.selectedStatus = "Reject"
            self.projectStatus()
        }
        return cell
    }
}

//extension NewContainerVC: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200
//    }
//}

