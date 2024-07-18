//
//  UserDetailsInvoiceVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 11/04/23.
//

import UIKit
import Alamofire

class UserDetailsInvoiceVC: UIViewController {
    
    @IBOutlet weak var lblInvoiceDate: UILabel!
    @IBOutlet weak var lblinvoiceNumber: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lbltitleAddres: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblUnitPrice: UILabel!
    @IBOutlet weak var lblRegularHours: UILabel!
    @IBOutlet weak var lblOvertimehours: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblGst: UILabel!
    @IBOutlet weak var lblSubAUd: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblTotalGSt: UILabel!
    @IBOutlet weak var lblTotalAUD: UILabel!
    @IBOutlet weak var lblCompanyHUb: UILabel!
    
    var arrProjectInvoice: ResProjectInvoice?
    var arrServiceList: [Invoice_Service_list] = []
    var projectId = ""
    var selectedStartDate = ""
    var selectedEndDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.projectInvoice()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func projectInvoice(){
        let UrlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_project_invoice?"
        let paramDetails = [
            "company_code": k.userDefault.value(forKey: k.session.commonCompanyCode) as! String,
            "client_id": UserDefaults.standard.value(forKey: "user_id") as! String,
            "project_id": self.projectId,
            "start_date": self.selectedStartDate,
            "end_date": self.selectedEndDate
        ]
        
        print(paramDetails)
        Alamofire.request(UrlString, parameters: paramDetails).response { response in
            let data = response.data
            do{
                let decode = JSONDecoder()
                let root = try decode.decode(GetProjectInvoice.self, from: data!)
                if let invoiceStatus = root.status {
                    if invoiceStatus == "1" {
                        self.arrServiceList = root
                            .result?.service_list ?? []
                        self.lblTitle.text = root.result?.title ?? ""
                        self.lblAddress.text = root.result?.address ?? ""
                        self.lbltitleAddres.text = root.result?.address ?? ""
                        self.lblDescription.text = root.result?.service_list?[0].cat_name ?? ""
                        self.lblQuantity.text = root.result?.service_list?[0].no_of_worker ?? ""
                        self.lblUnitPrice.text = root.result?.service_list?[0].hr_rate ?? ""
                        self.lblRegularHours.text = root.result?.service_list?[0].total_work_hour ?? ""
                        self.lblOvertimehours.text = root.result?.service_list?[0].extra_total_time ?? ""
                        self.lblDiscount.text = "\(root.result?.service_list?[0].discount ?? "")%"
                        self.lblGst.text = "\(root.result?.service_list?[0].gST ?? "")%"
                        self.lblSubAUd.text = root.result?.service_list?[0].fianl_pay_amount ?? ""
                        self.lblSubTotal.text = root.result?.f_sub_total_amount ?? ""
                        self.lblTotalGSt.text = root.result?.f_gst_total_amount ?? ""
                        self.lblTotalAUD.text = root.result?.f_total_amount ?? ""
                    }else {
                        print("Something Went Wrong!")
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}
