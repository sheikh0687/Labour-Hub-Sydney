//
//  ProjectInvoiceOverDueConatinerVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 02/05/23.
//

import UIKit
import Alamofire

class ProjectInvoiceOverDueConatinerVC: UIViewController {

    @IBOutlet weak var invoiceTableView: UITableView!
    
    let identifier = "CompanyInvoiceCell"
    var arrRequestInvoice: [ResRequestedInvoice] = []
    var arrRequestedService: [Requested_Service_lis] = []
    var invoiceID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.invoiceTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.requestedInvoice()
    }
    
    func requestedInvoice()
    {
        let urlSting = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_user_request_invoice?"
        let paramDetails =
        [
        
            "user_id": UserDefaults.standard.value(forKey: "user_id") as! String,
            "company_code": k.userDefault.value(forKey: k.session.commonCompanyCode) as! String,
            "project_id": "",
            "start_date": "",
            "end_date": "",
            "status": "OVERDUE"
        
        ]
        
        print(paramDetails)
        
        Alamofire.request(urlSting, parameters: paramDetails).response { response in
            let data = response.data
            do{
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetUserRequestInvoice.self, from: data!)
                if let statusDetails = root.status {
                    if statusDetails == "1"{
                        self.arrRequestInvoice = root.result ?? []
                    }else{
                        print("Something Went Wrong!")
                    }
                    DispatchQueue.main.async {
                        self.invoiceTableView.reloadData()
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}

extension ProjectInvoiceOverDueConatinerVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrRequestInvoice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyInvoiceCell", for: indexPath) as! CompanyInvoiceCell
        
        cell.lblInvoiceNo.text = "Invoice Number: \(self.arrRequestInvoice[indexPath.row].invoicenumber ?? "")"
        cell.lblIssueDate.text = "Issue Date: \(self.arrRequestInvoice[indexPath.row].invoicedate ?? "")"
        cell.lblProjectTitle.text = self.arrRequestInvoice[indexPath.row].projecttitle ?? ""
        cell.lblAddress.text = self.arrRequestInvoice[indexPath.row].projectaddress ?? ""
        
        if self.arrRequestInvoice[indexPath.row].service_lis?.count ?? 0 > 0 {
            cell.lblDescription.text = self.arrRequestInvoice[indexPath.row].service_lis?[0].cat_name ?? ""
            cell.lblQuantity.text = self.arrRequestInvoice[indexPath.row].service_lis?[0].noOfWorker ?? ""
            cell.lblUnitPrice.text = self.arrRequestInvoice[indexPath.row].service_lis?[0].hrRate ?? ""
            cell.lblRegularHours.text = self.arrRequestInvoice[indexPath.row].service_lis?[0].totalWorkHour ?? ""
            cell.lblOvertime.text = self.arrRequestInvoice[indexPath.row].service_lis?[0].extraTotalTime ?? ""
            cell.lblDiscount.text = "\(self.arrRequestInvoice[indexPath.row].service_lis?[0].discount ?? "")%"
            cell.lblGst.text = "\(self.arrRequestInvoice[0].service_lis?[0].gst ?? "")%"
            cell.lblTotalPay.text = self.arrRequestInvoice[indexPath.row].service_lis?[0].fianlPayAmount ?? ""
            self.invoiceID = self.arrRequestInvoice[indexPath.row].id ?? ""
        }
        
        self.invoiceID = self.arrRequestInvoice[indexPath.row].id ?? ""
        return cell
    }
}

