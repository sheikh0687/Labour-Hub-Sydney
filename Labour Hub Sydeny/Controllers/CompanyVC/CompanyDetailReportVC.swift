//
//  CompanyDetailReportVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 19/04/23.
//

import UIKit
import Alamofire

class CompanyDetailReportVC: UIViewController {
    
    @IBOutlet weak var reportTableView: UITableView!
    @IBOutlet weak var lblHidden: UILabel!
    
    let identifier = "CompanyReportsCell"
    
    var arrReportList: [ResCompanyReportList] = []
    var arrworkerDt: [Any] = []
    var clientId = ""
    var projectId = ""
    var startDate = ""
    var endDate = ""
    var totalWork = ""
    var totalOvertime = ""
    var toatalFinalHour = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reportTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showProgressBar()
        self.listOfReport()
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func listOfReport()
    {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_project_and_time_sheet?"
        let paramDetails =
        [
            "company_code": k.userDefault.value(forKey:k.session.commonCompanyCode) as! String,
            "client_id": self.clientId,
            "project_id": self.projectId,
            "start_date": self.startDate,
            "end_date": self.endDate
        ]
        
        print(paramDetails)
        
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            let data = response.data
            do{
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetCompanyReportList.self, from: data!)
                if let statusDetail = root.status {
                    if statusDetail == "1"{
                        self.hideProgressBar()
                        self.arrReportList = root.result ?? []
                        self.lblHidden.isHidden = true
                    }else{
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                        self.lblHidden.isHidden = false
                    }
                    DispatchQueue.main.async{
                        self.reportTableView.reloadData()
                    }
                }
            }catch{
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
}

extension CompanyDetailReportVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrReportList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyReportsCell", for: indexPath) as! CompanyReportsCell
        
        cell.cellClientId = self.clientId
        cell.cellProjectId = self.projectId
        cell.cellStartDate = self.startDate
        cell.cellEndDate = self.endDate
        cell.lblProjectTitle.text = self.arrReportList[indexPath.row].title ?? ""
        cell.lblAddress.text = self.arrReportList[indexPath.row].address ?? ""
        print(self.arrReportList[indexPath.row].worker_details ?? [])
        cell.arrWorkerDetails = self.arrReportList[indexPath.row].worker_details ?? []
        
        cell.totalHoursVal = 0
        cell.totalOvertimeVal = 0
        cell.totalFHourVal = 0
        
        cell.tableViewHeight.constant = CGFloat((self.arrReportList[indexPath.row].worker_details?.count ?? 0) * 60)
        cell.tableView.reloadData()
        
        return cell
    }
}
