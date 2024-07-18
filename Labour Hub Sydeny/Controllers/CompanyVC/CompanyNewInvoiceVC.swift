//
//  CompanyNewInvoiceVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 20/04/23.
//

import UIKit
import Alamofire

class CompanyNewInvoiceVC: UIViewController {
    
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
    
    var arrProjectInvoice: ResClientProjectInvoice?
    var arrNewServiceList: [Client_Project_Invoice_Service] = []
    var clientId = ""
    var ProjectID = ""
    var categoryId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.showProgressBar()
        self.requestedNewInvoice()
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func requestedNewInvoice()
    {
        let urlSting = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_project_invoice?"
        let paramDetails =
        [
            "client_id": self.clientId,
            "company_code": k.userDefault.value(forKey: k.session.commonCompanyCode) as! String,
            "project_id": self.ProjectID,
            "start_date": "",
            "end_date": ""
        ]
        
        print(paramDetails)
        
        Alamofire.request(urlSting, parameters: paramDetails).response { response in
            let data = response.data
            do{
                let decode = JSONDecoder()
                let root = try decode.decode(GetClientProjectInvoice.self, from: data!)
                if let invoiceStatus = root.status {
                    if invoiceStatus == "1" {
                        self.hideProgressBar()
                        self.arrNewServiceList = root.result?.service_list ?? []
                        self.lblTitle.text = root.result?.title ?? ""
                        self.lbltitleAddres.text = root.result?.address ?? ""
                        self.categoryId = root.result?.cat_id ?? ""
                        self.lblDescription.text = root.result?.cat_name ?? ""
                        self.lblQuantity.text = root.result?.no_of_worker ?? ""
                        self.lblUnitPrice.text = root.result?.service_list?[0].hr_rate ?? ""
                        self.lblRegularHours.text = root.result?.service_list?[0].total_work_hour ?? ""
                        self.lblOvertimehours.text = root.result?.service_list?[0].extra_total_time ?? ""
                        self.lblDiscount.text = "\(root.result?.service_list?[0].discount ?? "")%"
                        self.lblGst.text = "\(root.result?.service_list?[0].gST ?? "")%"
                        self.lblSubAUd.text = root.result?.service_list?[0].fianl_pay_amount ?? ""
                        self.lblSubTotal.text = root.result?.f_sub_total_amount ?? ""
                        self.lblTotalGSt.text = root.result?.f_gst_total_amount ?? ""
                        self.lblTotalAUD.text = root.result?.f_total_amount ?? ""
                    }else{
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                    }
                    DispatchQueue.main.async {
                    }
                }
            }catch{
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func btnCreateInvoice(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "PresentCreateInvoiceVC") as! PresentCreateInvoiceVC
        
        vc.selectedProjectId = self.ProjectID
        
        vc.selectedProjectTittle = self.lblTitle.text ?? ""
        print(vc.selectedProjectTittle)
        vc.selectedProjectAddress = self.lbltitleAddres.text ?? ""
        print(vc.selectedProjectAddress)
        vc.selectedCatId = self.categoryId
        print(vc.selectedCatId)
        vc.selectedCatName = self.lblDescription.text ?? ""
        print(vc.selectedCatName)
        vc.selectedNoOfWorker = self.lblQuantity.text ?? ""
        print(vc.selectedNoOfWorker)
        vc.selectedHrRate = self.lblUnitPrice.text ?? ""
        print(vc.selectedHrRate)
        vc.selectedTotalWorkerHour = self.lblRegularHours.text ?? ""
        print(vc.selectedTotalWorkerHour)
        vc.selectedExtraTotalTime = self.lblOvertimehours.text ?? ""
        print(vc.selectedExtraTotalTime)
        vc.selectedDiscount = self.lblDiscount.text ?? ""
        print(vc.selectedDiscount)
        vc.selectedGst = self.lblGst.text ?? ""
        print(vc.selectedGst)
        vc.selectedAud = self.lblSubAUd.text ?? ""
        print(vc.selectedAud)
        vc.selectedSubTotal = self.lblSubTotal.text ?? ""
        print(vc.selectedSubTotal)
        vc.selectedTotalGst = self.lblTotalGSt.text ?? ""
        print(vc.selectedTotalGst)
        vc.selectedFinalPayAmount = self.lblTotalAUD.text ?? ""
        print(vc.selectedFinalPayAmount)
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
