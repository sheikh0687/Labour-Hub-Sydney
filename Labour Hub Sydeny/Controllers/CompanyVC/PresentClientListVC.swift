//
//  PresentClientListVC.swift
//  Labour Hub Sydeny
//
//  Created by Techimmense Software Solutions on 15/07/23.
//

import UIKit
import Alamofire

class PresentClientListVC: UIViewController {
    
    @IBOutlet weak var clientTableView: UITableView!
    @IBOutlet weak var lblHidden: UILabel!
    @IBOutlet weak var btnAllCheck: UIButton!
    
    
    var arrCLientList: [ResClientProjectDetail] = []
    var selectedClientId = ""
    let identifier = "EmployeSelecteionCell"
    var valueSelect = ""
    var cloSelectedvalue: ((String) -> Void)?
    var selectedItems = [Int : Bool]()
    var strSelectedId = ""
    var strSelectedName = ""
    var sendSelectdId: ((String) -> Void)?
    var totalNoOfWorker = ""
    var cloToCheck:(([ResClientProjectDetail]) -> Void)?
    var selectedServiceId = ""
    var cloProjectId: ((String) -> Void)?
    var arrAllValues = [String]()
    
    var arrStruct: [selectedItems] = []
    
    @IBOutlet weak var vwHide: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clientTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getClientList()
        self.clientTableView.allowsMultipleSelection = true
    }
    
    private func blankSelected()
    {
        for i in 0...arrCLientList.count
        {
            selectedItems[i] = false
        }
    }
    
    func getClientList() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_company_user?"
        let paramDetails =
        [
            "company_code": k.userDefault.value(forKey: k.session.commonCompanyCode) as! String
        ]
        
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            if let responseData = response.data {
                do {
                    
                    let root = try JSONDecoder().decode(GetClientProject.self, from: responseData)
                    print(root)
                    if let CategoryListStatus = root.status {
                        if CategoryListStatus == "1" {
                            self.hideProgressBar()
                            self.arrCLientList = root.result ?? []
                            self.lblHidden.isHidden = true
                            self.vwHide.isHidden = false
                        }else{
                            self.hideProgressBar()
                            self.lblHidden.isHidden = false
                            self.vwHide.isHidden = true
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
    
    @IBAction func btnCheckedALl(_ sender: UIButton) {
        self.selectedItems.removeAll()
        
        if sender.isSelected {
            for row in 0..<arrCLientList.count {
                if let cell = self.clientTableView.cellForRow(at: IndexPath(row: row, section: 0)) as? EmployeSelecteionCell {
                    cell.imageOutlet.image = UIImage(named: "UnChecked18")
                }
                // Set the selected state in the dictionary
                self.selectedItems[row] = false
            }
            sender.isSelected = false
            sender.setImage(UIImage(named: "RectangleUncheck"), for: .normal)
        } else {
            // Select all rows
            for row in 0..<arrCLientList.count {
                if let cell = self.clientTableView.cellForRow(at: IndexPath(row: row, section: 0)) as? EmployeSelecteionCell {
                    cell.imageOutlet.image = UIImage(named: "Checked18")
                }
                self.selectedItems[row] = true
            }
            sender.isSelected = true
            sender.setImage(UIImage(named: "Checked18"), for: .normal)
        }
        self.clientTableView.reloadData()
    }
    
    @IBAction func btnOk(_ sender: UIButton) {
        self.validate()
    }
    
    func validate()
    {
        var strId = [String]()
        var strName = [String]()
        for val in selectedItems {
            let obj = self.arrCLientList[val.key]
            strId.append(obj.id ?? "")
            strName.append("\(obj.first_name ?? "") \(obj.last_name ?? "")")
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
}

extension PresentClientListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrCLientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeSelecteionCell", for: indexPath) as! EmployeSelecteionCell
        if selectedItems[indexPath.row] == true
        {
            
            cell.lblName.text = "\(self.arrCLientList[indexPath.row].first_name ?? "") \(self.arrCLientList[indexPath.row].last_name ?? "")"
            self.valueSelect = "\(self.arrCLientList[indexPath.row].first_name ?? "") \(self.arrCLientList[indexPath.row].last_name ?? "")"
            self.selectedClientId = self.arrCLientList[indexPath.row].id ?? ""
            cell.imageOutlet.image = UIImage(named: "Checked18")
        }
        else
        {
            cell.lblName.text = "\(self.arrCLientList[indexPath.row].first_name ?? "") \(self.arrCLientList[indexPath.row].last_name ?? "")"
            self.valueSelect = "\(self.arrCLientList[indexPath.row].first_name ?? "") \(self.arrCLientList[indexPath.row].last_name ?? "")"
            self.selectedClientId = self.arrCLientList[indexPath.row].id ?? ""
            cell.imageOutlet.image = UIImage(named: "UnChecked18")
        }
        return cell
    }
}

extension PresentClientListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = clientTableView.cellForRow(at: indexPath) as! EmployeSelecteionCell
        cell.imageOutlet.image = UIImage(named: "Checked18")
        self.selectedItems[indexPath.row] = true
        print(selectedItems)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = clientTableView.cellForRow(at: indexPath) as! EmployeSelecteionCell
        cell.btnAllCheck.setImage(R.image.rectangleUncheck(), for: .normal)
        cell.imageOutlet.image = UIImage(named: "UnChecked18")
        self.selectedItems[indexPath.row] = false
    }
}
