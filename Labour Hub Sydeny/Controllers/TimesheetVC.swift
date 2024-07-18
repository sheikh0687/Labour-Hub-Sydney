//
//  TimesheetVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 07/04/23.
//

import UIKit
import Alamofire
import SDWebImage

class TimesheetVC: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var lblOvertime: UILabel!
    @IBOutlet weak var lblLunchTime: UILabel!
    @IBOutlet weak var lblRegular: UILabel!
    @IBOutlet weak var lblEmployename: UILabel!
    @IBOutlet weak var lblSiteManager: UILabel!
    @IBOutlet weak var lblClientName: UILabel!
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var contentViewOt: UIView!
    
    let identifier = "CellForTimeSheet"
    var selectedProjectId = ""
    var arrTimesheetdt: ResDetailTimesheet?
    var arrProjectDt: Project_details?
    var signatureId = ""
    var client_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.showProgressBar()
        self.getTimesheet()
    }
    
    
    @IBAction func btnDownload(_ sender: UIButton) {
        guard let snapshot = contentViewOt.snapshotViewHierarchy() else {
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
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getTimesheet(){
        let url = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_time_sheet_details?"
        let paramDetails =
        [
            "time_sheet_id" : self.selectedProjectId
        ]
        
        print(paramDetails)
        
        Alamofire.request(url,parameters: paramDetails).response { response in
            let data = response.data
            do{
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiDetailTimesheet.self, from: data!)
                print(root)
                if let loginStatus = root.status {
                    if loginStatus == "1" {
                        self.hideProgressBar()
                        //                        self.arrTimesheetdt = root.result ?? []
                        self.lblTitle.text = root.result?.project_details?.title ?? ""
                        self.lblAddress.text = root.result?.project_details?.address ?? ""
                        self.lblStartDate.text = root.result?.date ?? ""
                        self.lblStartTime.text = root.result?.start_time ?? ""
                        self.lblEndTime.text = root.result?.end_time ?? ""
                        self.lblOvertime.text = "\(root.result?.extra_total_time ?? "") Hours"
                        self.lblLunchTime.text = "\(root.result?.lunch_break_duration ?? "") Min"
                        self.lblRegular.text = "\(root.result?.total_time ?? "") Hours"
                        self.lblEmployename.text = "\(root.result?.worker_details?.first_name ?? "") \(root.result?.worker_details?.last_name ?? "")"
                        self.lblSiteManager.text = root.result?.site_manager_name ?? ""
                        self.lblClientName.text = "\(root.result?.client_details?.first_name ?? "") \(root.result?.client_details?.last_name ?? "")"
                        
                        if let imageUrl = URL(string: root.result?.signature_image ?? "")
                        {
                            self.imageOutlet.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder_2"), options: .continueInBackground,completed: nil)
                        }
                        
                    } else {
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
    
    func paramAddSignature() -> [String: String] {
        let paramAnswer =
        [
            "id": self.signatureId,
            "signature_status": "Yes",
        ]
        
        print(paramAnswer)
        
        return paramAnswer
    }
    
    func imageDictAddTimesheet(_ image : UIImage) -> [String: UIImage] {
        var dict : [String: UIImage] = [:]
        dict["signature_image"] = image
        print(dict)
        return dict
    }
}

