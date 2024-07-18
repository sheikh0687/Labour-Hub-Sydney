//
//  UserProjectDetailVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 06/04/23.
//

import UIKit
import Alamofire
import SDWebImage

class UserProjectDetailVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblProjectTitle: UILabel!
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblStartTim: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var lblNumberOfWorker: UILabel!
    @IBOutlet weak var workerTableVIew: UITableView!
    @IBOutlet weak var workerTableHeight: NSLayoutConstraint!
    @IBOutlet weak var workerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lblAddress: UILabel!
    
    let identifier = "RequiredEmployeCell"
    let identifier1 = "CellForProjectDetails"
    var arrProjectDetails: UserProjectdetails?
    var arrserviceList: [Service_list] = []
    var arrAssignedEmploye: [Assign_employee] = []
    var arrImage: [User_request_images] = []
    var selectedProjectId = ""
    var assingedStatus = ""
    var deletedId = ""
    var assignedId = ""
    
    var workerCategory = ""
    var workerCount = ""
    var serviceId = ""
    var requestId = ""
    var textWorkerNumber: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.workerTableVIew.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        
        self.collectionView.register(UINib(nibName: identifier1, bundle: nil), forCellWithReuseIdentifier: identifier1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showProgressBar()
        self.getUserProjectDetials()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getUserProjectDetials() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_project_details?"
        let paramDetails = [
            "project_id": self.selectedProjectId
        ]
        
        print(paramDetails)
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            let data = response.data
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetUserProjectDetails.self, from: data!)
                print(root)
                if let loginStatus = root.status {
                    if loginStatus == "1"{
                        self.hideProgressBar()
                        self.arrserviceList = root.result?.service_list ?? []
                        self.arrImage = root.result?.user_request_images ?? []
                        self.lblProjectTitle.text = root.result?.title ?? ""
                        self.lblDescription.text = root.result?.description ?? ""
                        self.lblStartTim.text = "\(root.result?.start_date ?? "")  \(root.result?.start_time ?? "" )"
                        self.lblEndTime.text = "\(root.result?.end_date ?? "")  \(root.result?.end_time ?? "" )"
                        self.lblAddress.text = root.result?.address ?? ""
                        self.lblNumberOfWorker.text = String(root.result?.no_of_worker ?? 0)
                        self.workerTableHeight.constant = self.calculateTableHeight()
                    }else{
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                    }
                    DispatchQueue.main.async {
                        self.workerTableVIew.reloadData()
                        self.collectionView.reloadData()
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
        for val in self.arrserviceList
        {
            let assignedStatus = val.status ?? ""
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
    
    func addUpdatedService() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/update_service_worker?"
        let paramDetails = [
            "service_id": self.serviceId,
            "request_id": self.requestId,
            "no_of_worker": self.textWorkerNumber?.text!
        ]
        
        print(paramDetails)
        
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            let data = response.data
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(getUpdatedService.self, from: data!)
                print(root)
                if let loginStatus = root.status {
                    if loginStatus == "1"{
                        self.hideProgressBar()
                        self.getUserProjectDetials()
                        let alert = UIAlertController(title: k.appName, message: "Updated Successfully!", preferredStyle: .alert)
                        
                        let Ok = UIAlertAction(title: "Ok", style: .default) { (action) in
                            self.dismiss(animated: true)
                        }
                        
                        alert.addAction(Ok)
                        
                        self.present(alert, animated: true, completion: nil)
                        
                    }else{
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                    }
                    DispatchQueue.main.async {
                    }
                }
            } catch {
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
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
                        self.getUserProjectDetials()
                    }else{
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                    }
                    DispatchQueue.main.async {
                        self.workerTableVIew.reloadData()
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
        
        print(paramDetails)
        
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            let data = response.data
            do{
                let decoder = JSONDecoder()
                let root = try decoder.decode(RemoveAssignedStatus.self, from: data!)
                if let documentStatus = root.status {
                    if documentStatus == "1" {
                        self.hideProgressBar()
                        self.getUserProjectDetials()
                    }else{
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                    }
                    DispatchQueue.main.async {
                        self.workerTableVIew.reloadData()
                    }
                }
            }catch{
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
}

extension UserProjectDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrserviceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequiredEmployeCell", for: indexPath) as! RequiredEmployeCell
        cell.lblName.text = self.arrserviceList[indexPath.row].cat_name ?? ""
        cell.lblNumberOfWorker.text = self.arrserviceList[indexPath.row].no_of_worker ?? ""
        cell.lblStatus.text = self.arrserviceList[indexPath.row].status ?? ""
        self.assingedStatus = self.arrserviceList[indexPath.row].status ?? ""
        print(self.assingedStatus)
        cell.arrWorkerAssign = self.arrserviceList[indexPath.row].assign_employee ?? []
        cell.listTableViewHeight.constant = CGFloat((self.arrserviceList[indexPath.row].assign_employee?.count ?? 0) * 140)
        cell.listTableView.reloadData()
        
        if self.arrserviceList[indexPath.row].assign_employee != nil
        {
            cell.listTableView.isHidden = false
        }else{
            cell.listTableView.isHidden = false
        }
        
        cell.cloPresentEdit = {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "PresentUpdateVC") as! PresentUpdateVC
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            
            vc.workerCategory = self.arrserviceList[indexPath.row].cat_name ?? ""
            vc.workerCount = self.arrserviceList[indexPath.row].no_of_worker ?? ""
            vc.serviceId = self.arrserviceList[indexPath.row].id ?? ""
            vc.requestId = self.arrserviceList[indexPath.row].request_id ?? ""
            
            vc.cloCheck = {
                self.getUserProjectDetials()
            }
            vc.cloPresentWorker = { takeArgument in
                self.textWorkerNumber = takeArgument
                self.addUpdatedService()
            }
            self.present(vc, animated: true, completion: nil)
        }
        
        
        cell.clodelete = {
            self.deletedId = self.arrserviceList[indexPath.row].id ?? ""
            print(self.deletedId)
            self.showProgressBar()
            self.deleteProject()
        }
        
        cell.cloRemove = {
            if self.arrserviceList[indexPath.row].assign_employee?.count ?? 0 > 0 {
                self.assignedId = self.arrserviceList[indexPath.row].assign_employee?[0].assign_id ?? ""
            }
            print(self.assignedId)
            self.showProgressBar()
            self.removeEmpStatus()
        }
        
        return cell
    }
}

extension UserProjectDetailVC: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let assignedStatus = self.arrserviceList[indexPath.row].status ?? ""
        if self.arrserviceList[indexPath.row].assign_employee?.count ?? 0 > 0
        {
            let rowCount = self.arrserviceList[indexPath.row].assign_employee?.count ?? 0
            let rowHeight = 70 + (rowCount * 140)
            return CGFloat(rowHeight)
        }
        else
        {
            return 70
        }
    }
}

extension UserProjectDetailVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellForProjectDetails", for: indexPath) as! CellForProjectDetails
        
        if self.arrImage.count > 0
        {
            if let imageUrl = URL(string: self.arrImage[indexPath.row].image ?? "")
            {
                cell.imageOutlet.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"), options: .continueInBackground, completed: nil)
            }
            else
            {
                cell.imageOutlet.image = UIImage(named: "placeholder")
            }
            self.imageOutlet.isHidden = true
        }else
        {
            self.imageOutlet.isHidden = false
        }
        return cell
    }
}

extension UserProjectDetailVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: 200)
    }
}
