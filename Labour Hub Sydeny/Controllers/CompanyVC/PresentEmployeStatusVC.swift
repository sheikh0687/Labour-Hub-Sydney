//
//  PresentEmployeStatusVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 18/04/23.
//

import UIKit
import Alamofire

class PresentEmployeStatusVC: UIViewController {
    
    @IBOutlet weak var employeStatusTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lblHidden: UILabel!
    
    var arrStatusDt: [ResCompanyStatus] = []
    var selectedCategoryId = ""
    let identifier = "EmployeSelecteionCell"
    var valueSelect = ""
    var cloSelectedvalue: ((String) -> Void)?
    var selectedItems = [Int : Bool]()
    var strSelectedId = ""
    var strSelectedName = ""
    var sendSelectdId: ((String) -> Void)?
    var totalNoOfWorker = ""
    var cloToCheck:(([ResCompanyStatus]) -> Void)?
    var selectedServiceId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.employeStatusTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.companyAssinedStatus()
    }
    
    private func blankSelected()
    {
        for i in 0...arrStatusDt.count
        {
            selectedItems[i] = false
        }
    }
    func companyAssinedStatus() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_company_employee_by_cat?"
        let paramDetails =
        [
            "company_code": k.userDefault.value(forKey: k.session.commonCompanyCode) as! String,
            "cat_id": self.selectedCategoryId,
            "service_id": self.selectedServiceId
        ]
        
        print(paramDetails)
        
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            let data = response.data
            do{
                let decoder = JSONDecoder()
                let root = try decoder.decode(SelectEmployeStatus.self, from: data!)
                if let statusDetails = root.status {
                    if statusDetails == "1" {
                        self.arrStatusDt = root.result ?? []
                        self.tableViewHeight.constant = CGFloat(self.arrStatusDt.count * 45)
                        self.lblHidden.isHidden = true
                    }else{
                        print("Something Went Wrong!")
                        self.lblHidden.isHidden = false
                    }
                    DispatchQueue.main.async {
                        self.employeStatusTableView.reloadData()
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func btnOk(_ sender: UIButton) {
        if Int(totalNoOfWorker) != self.selectedItems.count
        {
            self.alert(alertmessage: "Please select only \(totalNoOfWorker) workers!")
        }else{
            self.validate()
        }
    }
    
    func validate()
    {
        var strId = [String]()
        var strName = [String]()
        for val in selectedItems {
            let obj = self.arrStatusDt[val.key]
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

extension PresentEmployeStatusVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrStatusDt.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeSelecteionCell", for: indexPath) as! EmployeSelecteionCell
        if selectedItems[indexPath.row] == true
        {
           
            cell.lblName.text = "\(self.arrStatusDt[indexPath.row].first_name ?? "") \(self.arrStatusDt[indexPath.row].last_name ?? "")"
            self.valueSelect = "\(self.arrStatusDt[indexPath.row].first_name ?? "") \(self.arrStatusDt[indexPath.row].last_name ?? "")"
            cell.imageOutlet.image = UIImage(named: "Checked18")
        }
        else
        {
            cell.lblName.text = "\(self.arrStatusDt[indexPath.row].first_name ?? "") \(self.arrStatusDt[indexPath.row].last_name ?? "")"
            self.valueSelect = "\(self.arrStatusDt[indexPath.row].first_name ?? "") \(self.arrStatusDt[indexPath.row].last_name ?? "")"
            cell.imageOutlet.image = UIImage(named: "RectangleUncheck")
        }    
        return cell
    }
}

extension PresentEmployeStatusVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = employeStatusTableView.cellForRow(at: indexPath) as! EmployeSelecteionCell
        cell.imageOutlet.image = UIImage(named: "Checked18")
        selectedItems[indexPath.row] = true
        print(selectedItems)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = employeStatusTableView.cellForRow(at: indexPath) as! EmployeSelecteionCell
        cell.imageOutlet.image = UIImage(named: "RectangleUncheck")
        selectedItems[indexPath.row] = false
    }
}
