//
//  EmployeeProjectDetails.swift
//  Labour Hub Sydeny
//
//  Created by mac on 12/04/23.
//

import UIKit
import Alamofire
import SDWebImage

class EmployeeProjectDetails: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var lblWorkerCOunt: UILabel!
    @IBOutlet weak var workerTableView: UITableView!
    @IBOutlet weak var workerTableHeight: NSLayoutConstraint!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var lblAddress: UILabel!
    
    let identifier = "AssignedWorkerCell"
    let identifier1 = "CellForProjectDetails"
    var arrProjectDetails: UserProjectdetails?
    var arrserviceList: [Service_list] = []
    var arrAssignedEmploye: [Assign_employee] = []
    var selectedProjectId = ""
    var assingedStatus = ""
    var arrImage: [User_request_images] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.workerTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        
        self.collectionView.register(UINib(nibName: identifier1, bundle: nil), forCellWithReuseIdentifier: identifier1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showProgressBar()
        self.getEmployeProjectDetials()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func btnBAck(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getEmployeProjectDetials() {
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
                let root = try decoder.decode(GetUserProjectDetails.self, from: data!)
                print(root)
                if let loginStatus = root.status {
                    if loginStatus == "1"{
                        self.hideProgressBar()
                        self.arrserviceList = root.result?.service_list ?? []
                        print(self.arrserviceList)
                        self.arrImage = root.result?.user_request_images ?? []
                        print(self.arrImage)
                        self.lblTitle.text = root.result?.title ?? ""
                        self.lblDescription.text = root.result?.description ?? ""
                        self.lblStartTime.text = "\(root.result?.start_date ?? "")  \(root.result?.start_time ?? "" )"
                        self.lblEndTime.text = "\(root.result?.end_date ?? "")  \(root.result?.end_time ?? "" )"
                        self.lblAddress.text = root.result?.address ?? ""
                        self.lblWorkerCOunt.text = String(root.result?.no_of_worker ?? 0)
                        self.workerTableHeight.constant = self.calculateTableHeight()
                    }else{
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                    }
                    DispatchQueue.main.async {
                        self.workerTableView.reloadData()
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
}

extension EmployeeProjectDetails: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrserviceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssignedWorkerCell", for: indexPath) as! AssignedWorkerCell
        cell.lblCategory.text = self.arrserviceList[indexPath.row].cat_name ?? ""
        cell.lblWorkerCount.text = self.arrserviceList[indexPath.row].no_of_worker ?? ""
        cell.arrWorkerAssign = self.arrserviceList[indexPath.row].assign_employee ?? []
        cell.listTableViewHeight.constant = CGFloat((self.arrserviceList[indexPath.row].assign_employee?.count ?? 0) * 140)
        cell.listTableView.reloadData()
       
        if self.arrserviceList[indexPath.row].assign_employee != nil {
            cell.listTableView.isHidden = false
        } else {
            cell.listTableView.isHidden = false
        }
        return cell
    }
}

extension EmployeeProjectDetails: UITableViewDelegate {
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

extension EmployeeProjectDetails: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellForProjectDetails", for: indexPath) as! CellForProjectDetails
    
        let obj = arrImage[indexPath.row]
  
        print(Router.BASE_IMAGE_URL)
        print(obj.image ?? "")
        if Router.BASE_IMAGE_URL != obj.image {
            Utility.setImageWithSDWebImage(obj.image ?? "", cell.imageOutlet)
        } else {
            cell.imageOutlet.image = R.image.placeholder()
        }
//        if self.arrImage.count > 0
//        {
//            if let imageUrl = URL(string: self.arrImage[indexPath.row].image ?? ""){
//                cell.imageOutlet.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"), options: .continueInBackground, completed: nil)
//            }
//            self.imageOutlet.isHidden = true
//        }
//        else
//        {
//            self.imageOutlet.isHidden = false
//        }
        
        return cell
    }
}

extension EmployeeProjectDetails: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: 200)
    }
}
