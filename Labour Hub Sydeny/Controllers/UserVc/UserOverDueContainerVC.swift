//
//  UserOverDueContainerVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 08/05/23.
//

import UIKit
import Alamofire

class UserOverDueContainerVC: UIViewController {
    
    @IBOutlet weak var invoiceTableView: UITableView!
    @IBOutlet weak var lblHidden: UILabel!
    var arrRequestInvoice: [ResRequestedInvoice] = []
    var arrRequestedService: [Requested_Service_lis] = []
    var invoiceID = ""
    
    let identifier = "CompanyInvoiceCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.invoiceTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        self.showProgressBar()
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
                        self.hideProgressBar()
                        self.arrRequestInvoice = root.result ?? []
                        self.lblHidden.isHidden = true
                    }else{
                        self.hideProgressBar()
                        print("Something Went Wrong")
                        self.lblHidden.isHidden = false
                    }
                    DispatchQueue.main.async {
                        self.invoiceTableView.reloadData()
                    }
                }
            }catch{
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
}

extension UserOverDueContainerVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrRequestInvoice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyInvoiceCell", for: indexPath) as! CompanyInvoiceCell
        
        cell.lblInvoiceNo.text = "Invoice Number: \(self.arrRequestInvoice[indexPath.row].invoicenumber ?? "")"
        cell.lblIssueDate.text = "Issue Date: \(self.arrRequestInvoice[indexPath.row].invoicedate ?? "")"
        cell.lblProjectTitle.text = self.arrRequestInvoice[indexPath.row].projecttitle ?? ""
        cell.lblAddress.text = self.arrRequestInvoice[indexPath.row].projectaddress ?? ""
        cell.lblDescription.text = self.arrRequestInvoice[0].service_lis?[0].cat_name ?? ""
        cell.lblQuantity.text = self.arrRequestInvoice[0].service_lis?[0].noOfWorker ?? ""
        cell.lblUnitPrice.text = self.arrRequestInvoice[0].service_lis?[0].hrRate ?? ""
        cell.lblRegularHours.text = self.arrRequestInvoice[0].service_lis?[0].totalWorkHour ?? ""
        cell.lblOvertime.text = self.arrRequestInvoice[0].service_lis?[0].extraTotalTime ?? ""
        cell.lblDiscount.text = "\(self.arrRequestInvoice[0].service_lis?[0].discount ?? "")%"
        cell.lblGst.text = "\(self.arrRequestInvoice[0].service_lis?[0].gst ?? "")%"
        cell.lblTotalPay.text = self.arrRequestInvoice[0].service_lis?[0].fianlPayAmount ?? ""
        
        self.invoiceID = self.arrRequestInvoice[indexPath.row].id ?? ""
        
        cell.cloDetails = {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "CompanyViewInvoiceVC") as! CompanyViewInvoiceVC
            vc.selectedInvoiceId = self.invoiceID
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
}
