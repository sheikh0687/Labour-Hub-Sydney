//
//  CompanyEmployeDocumentVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 11/05/23.
//

import UIKit
import Alamofire

class CompanyEmployeDocumentVC: UIViewController {

    @IBOutlet weak var documentTableView: UITableView!
    @IBOutlet weak var lblHidden: UILabel!
    
    var arrDoucmentList: [ResDocument] = []
    var documentId = ""
    var employeId = ""
    let identifier = "DocumentCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.documentTableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.employeDocument()
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func employeDocument() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_user_document?"
        let paramDetails =
        [
            "user_id": self.employeId
        ]
        
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            let data = response.data
            do{
                let decoder = JSONDecoder()
                let root = try decoder.decode(GetEmployeDocument.self, from: data!)
                if let documentStatus = root.status {
                    if documentStatus == "1" {
                        self.arrDoucmentList = root.result ?? []
                        self.lblHidden.isHidden = true
                    }else{
                        self.arrDoucmentList = []
                        self.lblHidden.isHidden = false
                    }
                    DispatchQueue.main.async {
                        self.documentTableView.reloadData()
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteDocument() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/delete_user_document?"
        let paramDetails =
        [
            "document_id": self.documentId
        ]
        
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            let data = response.data
            do{
                let decoder = JSONDecoder()
                let root = try decoder.decode(DeletedDocument.self, from: data!)
                if let documentStatus = root.status {
                    if documentStatus == "1" {
                        self.alert(alertmessage: "Document Deleted Successfully!")
                        self.employeDocument()
                    }else{
                       print("Something Went Wrong!")
                    }
                    DispatchQueue.main.async {
                        self.documentTableView.reloadData()
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}

extension CompanyEmployeDocumentVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrDoucmentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath) as! DocumentCell
        
        cell.lblDocName.text = self.arrDoucmentList[indexPath.row].name ?? ""
        cell.cloDeleteDoc = {
            self.documentId = self.arrDoucmentList[indexPath.row].id ?? ""
            self.deleteDocument()
        }
        
        cell.cloViewDocument = {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "EmployeDocumentDetailVC") as! EmployeDocumentDetailVC
            vc.pickedImage = self.arrDoucmentList[indexPath.row].image ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
}
