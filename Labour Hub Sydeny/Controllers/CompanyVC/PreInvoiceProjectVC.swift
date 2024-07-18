//
//  PreInvoiceProjectVC.swift
//  Labour Hub Sydeny
//
//  Created by Techimmense Software Solutions on 14/08/23.
//

import UIKit
import Alamofire

class PreInvoiceProjectVC: UIViewController {
    
    @IBOutlet weak var projectTableView: UITableView!
    @IBOutlet weak var lblHidden: UILabel!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var vwHide: UIView!
    
    
    var arrProjectList: [ResMultipleProjects] = []
    var selectedClientId = ""
    let identifier = "EmployeSelecteionCell"
    var valueSelect = ""
    var cloSelectedvalue: ((String) -> Void)?
    var selectedItems = [Int : Bool]()
    var strSelectedId = ""
    var strSelectedName = ""
    var sendSelectdId: ((String) -> Void)?
    var totalNoOfWorker = ""
    var selectedServiceId = ""
    var ClientID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.projectTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getAllProjectList()
    }
    
    
    private func blankSelected()
    {
        for i in 0...arrProjectList.count
        {
            selectedItems[i] = false
        }
    }
    
    @IBAction func btnChecked(_ sender: UIButton) {
        self.selectedItems.removeAll()

        if sender.isSelected {
            for row in 0..<arrProjectList.count {
                if let cell = self.projectTableView.cellForRow(at: IndexPath(row: row, section: 0)) as? EmployeSelecteionCell {
                    cell.imageOutlet.image = UIImage(named: "UnChecked18")
                }
                self.selectedItems[row] = false
            }
            sender.isSelected = false
            sender.setImage(UIImage(named: "RectangleUncheck"), for: .normal)
        } else {
            for row in 0..<arrProjectList.count {
                if let cell = self.projectTableView.cellForRow(at: IndexPath(row: row, section: 0)) as? EmployeSelecteionCell {
                    cell.imageOutlet.image = UIImage(named: "Checked18")
                }
                self.selectedItems[row] = true
            }
            sender.isSelected = true
            sender.setImage(UIImage(named: "Checked18"), for: .normal)
        }
        self.projectTableView.reloadData()
    }
    
    @IBAction func btnOk(_ sender: UIButton) {
        self.validate()
    }
    
    func validate()
    {
        var strId = [String]()
        var strName = [String]()
        for val in selectedItems {
            let obj = self.arrProjectList[val.key]
            strId.append(obj.request_id ?? "")
            strName.append(obj.project_details?.title ?? "")
        }
        self.strSelectedId = strId.joined(separator: ",")
        print(self.strSelectedId)
        self.strSelectedName = strName.joined(separator: ",")
        print(self.strSelectedName)
        self.sendSelectdId?(self.strSelectedId)
        self.cloSelectedvalue?(self.strSelectedName)
        self.dismiss(animated: true)
    }
    
    @IBAction func btnCancrl(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnClear(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    func getAllProjectList() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_all_project_by_multipe_client?"
        let paramDetails =
        [
            "client_id": self.ClientID
        ]
        
        print(paramDetails)
        
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            if let responseData = response.data {
                do {
                    
                    let root = try JSONDecoder().decode(ApiMultipleProject.self, from: responseData)
                    print(root)
                    if let CategoryListStatus = root.status {
                        if CategoryListStatus == "1" {
                            self.arrProjectList = root.result ?? []
                            self.tableViewHeight.constant = CGFloat(self.arrProjectList.count * 45)
                            self.lblHidden.isHidden = true
                            self.vwHide.isHidden = false
                        }else{
                            self.arrProjectList = []
                            self.lblHidden.isHidden = false
                            self.vwHide.isHidden = true
                        }
                        DispatchQueue.main.async {
                            self.projectTableView.reloadData()
                        }
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension PreInvoiceProjectVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrProjectList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeSelecteionCell", for: indexPath) as! EmployeSelecteionCell
        if selectedItems[indexPath.row] == true
        {
            cell.lblName.text = self.arrProjectList[indexPath.row].project_details?.title ?? ""
            self.valueSelect = self.arrProjectList[indexPath.row].project_details?.title ?? ""
            self.selectedClientId = self.arrProjectList[indexPath.row].request_id ?? ""
            cell.imageOutlet.image = UIImage(named: "Checked18")
        }
        else
        {
            cell.lblName.text = self.arrProjectList[indexPath.row].project_details?.title ?? ""
            self.valueSelect = self.arrProjectList[indexPath.row].project_details?.title ?? ""
            self.selectedClientId = self.arrProjectList[indexPath.row].request_id ?? ""
            cell.imageOutlet.image = UIImage(named: "UnChecked18")
        }
        return cell
    }
}

extension PreInvoiceProjectVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = projectTableView.cellForRow(at: indexPath) as! EmployeSelecteionCell
        cell.imageOutlet.image = UIImage(named: "Checked18")
        selectedItems[indexPath.row] = true
        print(selectedItems)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = projectTableView.cellForRow(at: indexPath) as! EmployeSelecteionCell
        cell.imageOutlet.image = UIImage(named: "UnChecked18")
        selectedItems[indexPath.row] = false
    }
}
