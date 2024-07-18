//
//  CompanyReportsCell.swift
//  Labour Hub Sydeny
//
//  Created by mac on 19/04/23.
//

import UIKit
import Alamofire
import DropDown
import SDWebImage

class CompanyReportsCell: UITableViewCell {

    @IBOutlet weak var lblProjectTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblEmpName: UILabel!
    @IBOutlet weak var lblWorkHour: UILabel!
    @IBOutlet weak var lblOvertime: UILabel!
    @IBOutlet weak var lblTotalWorkHour: UILabel!
    @IBOutlet weak var contentViewOt: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lblTotalSubHour: UILabel!
    @IBOutlet weak var lblTotalOvertime: UILabel!
    @IBOutlet weak var lblTotalFinalHour: UILabel!
    
    let identifier = "ReportDtCell"
//    var arrReportList: [ResCompanyReportList] = []
    var arrWorkerDetails: [Worker_details_Report] = []
    var cellClientId = ""
    var cellProjectId = ""
    var cellStartDate = ""
    var cellEndDate = ""
    var totalHoursVal = 0
    var totalOvertimeVal = 0
    var totalFHourVal = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
//        self.listOfReport()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnDownload(_ sender: UIButton) {
        guard let snapshot = contentViewOt.snapshotViewHierarchy() else {
            return
        }
        
        // save photo
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
                            else{
                                print("wrote file to: No Document \(outputFileURL.path)")
                            }
            }catch{
                print("Could not create PDF file: \(error.localizedDescription)")
            }
        }
    }
}

extension CompanyReportsCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrWorkerDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportDtCell", for: indexPath) as! ReportDtCell

        if self.arrWorkerDetails.count > 0 {
            cell.lblHour.text! = String(self.arrWorkerDetails[indexPath.row].work_hour ?? 0)
            cell.lblOvertime.text! = String(self.arrWorkerDetails[indexPath.row].overtime_hour ?? 0)
            cell.lblTotalHours.text! = String(self.arrWorkerDetails[indexPath.row].total_hour ?? 0)
            cell.lblDescription.text! = "\(self.arrWorkerDetails[indexPath.row].first_name ?? "") \(self.arrWorkerDetails[indexPath.row].last_name ?? "")"
        }
        
        if let imageUrl = URL(string: self.arrWorkerDetails[indexPath.row].image ?? ""){
            cell.img.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "profile_ic"), options: .continueInBackground,completed: nil)
        }
        
//        let myIndexPath = IndexPath(item: 0, section: 0)
//        let cell: ReportDtCell = self.tableView.cellForRow(at: myIndexPath) as! ReportDtCell
       
       
        
        self.totalHoursVal = self.totalHoursVal + (Int(cell.lblHour.text!) ?? 0)
        print(self.totalHoursVal)
        self.totalOvertimeVal = self.totalOvertimeVal + (Int(cell.lblOvertime.text!) ?? 0)
        print(self.totalOvertimeVal)
        self.totalFHourVal = self.totalFHourVal + (Int(cell.lblTotalHours.text!) ?? 0)
        print(self.totalFHourVal)
        
        self.lblTotalSubHour.text! = String(self.totalHoursVal)
        self.lblTotalOvertime.text! = ""
        self.lblTotalOvertime.text! = String(self.totalOvertimeVal)
        self.lblTotalFinalHour.text! = ""
        self.lblTotalFinalHour.text! = String(self.totalFHourVal)
        
        return cell
    }
}

extension CompanyReportsCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
