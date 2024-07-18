//
//  ProjectDetailsVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 25/03/23.
//

import UIKit
import Alamofire
import SDWebImage

class ProjectDetailsVC: UIViewController {
    
    @IBOutlet weak var projectDetailsCollection: UICollectionView!
    @IBOutlet weak var workerTableView: UITableView!
    @IBOutlet weak var workerHeightTable: NSLayoutConstraint!
    @IBOutlet weak var lblProjectTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblStartTim: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var lblNumberOfWorker: UILabel!
    @IBOutlet weak var imageOutlert: UIImageView!
    @IBOutlet weak var ViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lblAddress: UILabel!
    
    let identifier = "CellForProjectDetails"
    let identifier1 = "ComapnyAssignWorkerCell"
    
    var arrdetails: [CompanyRequestImages] = []
    var arrService: [Company_Service_list] = []
    var arrAssign: [Company_Assign_employee] = []
    var arrImage:[[String: AnyObject]] = []
    
    var assingedStatus = ""
    var selectedProjectId = ""
    var deletedId = ""
    var assignedId = ""
    var selectedCatID = ""
    var requestId = ""
    var selectedUSerID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.projectDetailsCollection.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        
        self.workerTableView.register(UINib(nibName: identifier1, bundle: nil), forCellReuseIdentifier: identifier1)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showProgressBar()
        self.getCompanyProjectDetials()
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getCompanyProjectDetials() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_project_details?"
        
        let paramDetails =
        [
            "project_id": self.selectedProjectId
        ]
        
        print(paramDetails)
        
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            let data = response.data
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetCompanyProjectDetails.self, from: data!)
                print(root)
                if let loginStatus = root.status {
                    if loginStatus == "1"{
                        self.hideProgressBar()
                        self.arrService = root.result?.service_list ?? []
                        self.arrdetails = root.result?.user_request_images ?? []
                        self.lblProjectTitle.text = root.result?.title ?? ""
                        self.lblDescription.text = root.result?.description ?? ""
                        self.lblStartTim.text = "\(root.result?.start_date ?? "")  \(root.result?.start_time ?? "" )"
                        self.lblEndTime.text = "\(root.result?.end_date ?? "")  \(root.result?.end_time ?? "" )"
                        self.lblAddress.text = root.result?.address ?? ""
                        self.lblNumberOfWorker.text = String(root.result?.no_of_worker ?? 0)
                        self.selectedUSerID = root.result?.user_details?.id ?? ""
                        self.workerHeightTable.constant = self.calculateTableHeight()
                    }else{
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                    }
                    DispatchQueue.main.async {
                        self.workerTableView.reloadData()
                        self.projectDetailsCollection.reloadData()
                    }
                }
            } catch {
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
    
    func calculateTableHeight() -> CGFloat
    {
        var tableHeight = 0
        for val in self.arrService
        {
            if val.assign_employee?.count ?? 0 > 0
            {
                let rowCount = val.assign_employee?.count ?? 0
                let rowHeight = 70 + (rowCount * 140)
                tableHeight = tableHeight + rowHeight
            }
            else
            {
                tableHeight = tableHeight + 70
            }
        }
        return CGFloat(tableHeight)
    }
    
    func deleteProject() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/delete_project_worker?"
        let paramDetails =
        [
            "id": self.deletedId
        ]
        
        print(paramDetails)
        
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            let data = response.data
            do{
                let decoder = JSONDecoder()
                let root = try decoder.decode(DeletedProjectWorker.self, from: data!)
                if let documentStatus = root.status {
                    if documentStatus == "1" {
                        self.hideProgressBar()
                        self.getCompanyProjectDetials()
                    }else{
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                    }
                    DispatchQueue.main.async {
                        self.workerTableView.reloadData()
                    }
                }
            }catch{
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
    
    func removeEmpStatus() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/remove_assign_employee?"
        let paramDetails =
        [
            "assign_id": self.assignedId
        ]
        
        print( "hello \(paramDetails)")
        
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            let data = response.data
            do{
                let decoder = JSONDecoder()
                let root = try decoder.decode(RemoveAssignedStatus.self, from: data!)
                if let documentStatus = root.status {
                    if documentStatus == "1" {
                        self.hideProgressBar()
                        self.getCompanyProjectDetials()
                    }else{
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                    }
                    DispatchQueue.main.async {
                        self.workerTableView.reloadData()
                    }
                }
            }catch{
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
    
    func companyAssignedEmployee(_ valueToGet : String)
    {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/assign_request_by_company?"
        let paramDetails =
        [
            "emp_id": valueToGet,
            "request_id": self.requestId,
            "request_service_id": self.selectedCatID,
            "client_id": self.selectedUSerID
        ]
        
        print(paramDetails)
        
        Alamofire.request(urlString,parameters: paramDetails).response { response in
            let data = response.data
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(AssignEmployees.self, from: data!)
                if let projectStatus = root.status {
                    if projectStatus == "1"{
                        self.hideProgressBar()
                        self.getCompanyProjectDetials()
                    }else{
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                    }
                    DispatchQueue.main.async {
                        self.workerTableView.reloadData()
                    }
                }
            }catch{
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
}

extension ProjectDetailsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrService.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComapnyAssignWorkerCell", for: indexPath) as! ComapnyAssignWorkerCell
        cell.lblCategory.text = self.arrService[indexPath.row].cat_name ?? ""
        cell.lblWorkerCount.text = self.arrService[indexPath.row].no_of_worker ?? ""
        cell.btnStatusOt.setTitle(self.arrService[indexPath.row].status ?? "", for: .normal)
        self.assingedStatus = self.arrService[indexPath.row].status ?? ""
        print(self.assingedStatus)
        cell.arrWorkerAssign = self.arrService[indexPath.row].assign_employee ?? []
        cell.listTableViewHeight.constant = CGFloat((self.arrService[indexPath.row].assign_employee?.count ?? 0) * 140)
        cell.listTableView.reloadData()
        
        cell.cloPresent = {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "PresentUpdateVC") as! PresentUpdateVC
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            vc.workerCategory = self.arrService[indexPath.row].cat_name ?? ""
            vc.workerCount = self.arrService[indexPath.row].no_of_worker ?? ""
            vc.serviceId = self.arrService[indexPath.row].id ?? ""
            vc.requestId = self.arrService[indexPath.row].request_id ?? ""
            
            vc.cloCheck = {
                self.getCompanyProjectDetials()
            }
            
            self.present(vc, animated: true, completion: nil)
        }
        
        cell.cloPresentStatus = {
            
            if self.arrService[indexPath.row].status ?? "" == "Assign" {
                self.alert(alertmessage: "You have already assigned employees for this service!")
            } else {
                let vc = Kstoryboard.instantiateViewController(withIdentifier: "CompanyPresentAssignedVC") as! CompanyPresentAssignedVC
                
                vc.noOfWorker = String(self.arrService[indexPath.row].total_remaining_worker ?? 0)
                
                vc.cloSubmint = { gotValue in
                    self.requestId = self.arrService[indexPath.row].request_id ?? ""
                    self.selectedCatID = self.arrService[indexPath.row].id ?? ""
                    self.showProgressBar()
                    self.companyAssignedEmployee(gotValue)
                }
                
                vc.selectedAssignId = self.arrService[indexPath.row].cat_id ?? ""
                vc.selectedService = self.arrService[indexPath.row].id ?? ""
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
        
        if self.arrService[indexPath.row].assign_employee != nil
        {
            cell.viewToHide.isHidden = false
        }else{
            cell.viewToHide.isHidden = false
        }
        
        if self.assingedStatus == "Assign"{
            cell.btnStatusOt.setTitle("Assigned", for: .normal)
        }else{
            cell.btnStatusOt.setTitle("Pending", for: .normal)
        }
        
        cell.cloPresentDelete = {
            self.deletedId = self.arrService[indexPath.row].id ?? ""
            print(self.deletedId)
            self.showProgressBar()
            self.deleteProject()
        }
        
        cell.cloRemove = { getId in
            self.assignedId = getId
            print(self.assignedId)
            self.showProgressBar()
            self.removeEmpStatus()
        }
        return cell
    }
}

extension ProjectDetailsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let assignedStatus = self.arrService[indexPath.row].status ?? ""
        if self.arrService[indexPath.row].assign_employee?.count ?? 0 > 0
        {
            let rowCount = self.arrService[indexPath.row].assign_employee?.count ?? 0
            let rowHeight = 70 + (rowCount * 140)
            return CGFloat(rowHeight)
        }
        else
        {
            return 70
        }
    }
}

extension ProjectDetailsVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrdetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellForProjectDetails", for: indexPath) as! CellForProjectDetails
        
        let obj = arrdetails[indexPath.row]
        
        if Router.BASE_IMAGE_URL != obj.image {
            Utility.setImageWithSDWebImage(obj.image ?? "", cell.imageOutlet)
        } else {
            cell.imageOutlet.image = R.image.placeholder()
        }
//        if self.arrdetails.count > 0
//        {
//            if let imageUrl = URL(string: self.arrdetails[indexPath.row].image ?? ""){
//                cell.imageOutlet.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"), options: .continueInBackground, completed: nil)
//            }
//            self.imageOutlert.isHidden = true
//        }
//        else
//        {
//            self.imageOutlert.isHidden = false
//        }
        return cell
    }
}

extension ProjectDetailsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: 200)
    }
}
