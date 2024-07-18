//
//  CompanyViewInvoiceVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 19/04/23.
//

import UIKit
import Alamofire

class CompanyViewInvoiceVC: UIViewController {

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
    @IBOutlet weak var contentView: UIView!
    
    var selectedInvoiceId = ""
    var arrRequestInvoiceDt: ResRequestedDetailInvoice?
    var arrRequestedServiceDt: [Requested_Details_Service_lis] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showProgressBar()
        self.requestedDetailsInvoice()
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
  
    
    func requestedDetailsInvoice()
    {
        let urlSting = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_user_request_invoice_details?"
        let paramDetails =
        [
            "request_invoice_id": self.selectedInvoiceId
        ]
        
        print(paramDetails)
        
        Alamofire.request(urlSting, parameters: paramDetails).response { response in
            let data = response.data
            do{
                let decode = JSONDecoder()
                let root = try decode.decode(GetDetailsRequestedInvoice.self, from: data!)
                if let invoiceStatus = root.status {
                    if invoiceStatus == "1" {
                        self.hideProgressBar()
                        self.arrRequestedServiceDt = root
                            .result?.service_lis ?? []
                        self.lblinvoiceNumber.text = root.result?.invoicenumber ?? ""
                        self.lblInvoiceDate.text = "\(root.result?.invoicedate ?? "") & \(root.result?.due_date ?? "")"
                        self.lblCompanyName.text = root.result?.companyname ?? ""
                        self.lblAddress.text = root.result?.companyaddress ?? ""
                        self.lblTitle.text = root.result?.projecttitle ?? ""
                        self.lbltitleAddres.text = root.result?.projectaddress ?? ""
                        self.lblDescription.text = root.result?.service_lis?[0].cat_name ?? ""
                        self.lblQuantity.text = root.result?.service_lis?[0].noOfWorker ?? ""
                        self.lblUnitPrice.text = root.result?.service_lis?[0].hrRate ?? ""
                        self.lblRegularHours.text = root.result?.service_lis?[0].totalWorkHour ?? ""
                        self.lblOvertimehours.text = root.result?.service_lis?[0].extraTotalTime ?? ""
                        self.lblDiscount.text = "\(root.result?.service_lis?[0].discount ?? "")%"
                        self.lblGst.text = "\(root.result?.service_lis?[0].gst ?? "")%"
                        self.lblSubAUd.text = root.result?.service_lis?[0].fianlPayAmount ?? ""
                        self.lblSubTotal.text = root.result?.subtotal ?? ""
                        self.lblTotalGSt.text = root.result?.totalgst ?? ""
                        self.lblTotalAUD.text = root.result?.totalaud ?? ""
                    }else {
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                    }
                }
            }catch{
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func btnDownloadInvoice(_ sender: UIButton) {
        guard let snapshot = contentView.snapshotViewHierarchy() else {
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(snapshot, nil, nil, nil)
        self.exportToPDF(snapshot)
    }
    
    func exportToPDF(_ uiImage:UIImage) {
        let outputFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("testing" + ".pdf")
        let pageSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size:  uiImage.size))
        DispatchQueue.main.async {
            do {
                let imageBounds = CGRect(origin: .zero, size: uiImage.size)
                try pdfRenderer.writePDF(to: outputFileURL, withActions: { (context) in
                    context.beginPage()
                    uiImage.draw(in: imageBounds)
                  
                })
                print("wrote file to: \(outputFileURL.path)")
                let documentoPath = outputFileURL.path
                let fileManager = FileManager.default
                if fileManager.fileExists(atPath: documentoPath){
                                let documento = NSData(contentsOfFile: documentoPath)
                                let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [documento!], applicationActivities: nil)
                    UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
                            }
                            else {
                                print("wrote file to: No Document \(outputFileURL.path)")
                            }
            } catch {
                print("Could not create PDF file: \(error.localizedDescription)")
            }
        }
    }
}
