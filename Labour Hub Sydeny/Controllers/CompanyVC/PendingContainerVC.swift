//
//  PendingContainerVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 19/04/23.
//

import UIKit
import Alamofire

class PendingContainerVC: UIViewController {

    @IBOutlet weak var pendingInvoiceTableView: UITableView!
    @IBOutlet weak var lblHidden: UILabel!
    
    let identifier = "CompanyInvoiceCell"
    var arrRequestInvoice: [ResRequestedInvoice] = []
    
    var invoiceID = ""
    var idProject = ""
    var clientId = ""
    var selectedStartDate = ""
    var selectedEndDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pendingInvoiceTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showProgressBar()
        self.requestedInvoice()
    }
    
    func requestedInvoice()
    {
        let urlSting = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_user_request_invoice?"
        let paramDetails =
        [
        
            "user_id": self.clientId,
            "company_code": k.userDefault.value(forKey: k.session.commonCompanyCode) as! String,
            "project_id": self.idProject,
            "start_date": self.selectedStartDate,
            "end_date": self.selectedEndDate,
            "status": "PENDING"
        
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
                        print("Something Went Wrong!")
                        self.lblHidden.isHidden = false
                    }
                    DispatchQueue.main.async {
                        self.pendingInvoiceTableView.reloadData()
                    }
                }
            }catch{
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
}

extension PendingContainerVC: UITableViewDataSource {
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
        
        cell.cloDetails = {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "CompanyViewInvoiceVC") as! CompanyViewInvoiceVC
            vc.selectedInvoiceId = self.invoiceID
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
}
