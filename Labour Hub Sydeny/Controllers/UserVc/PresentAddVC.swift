//
//  PresentAddVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 10/04/23.
//

import UIKit
import Alamofire
import DropDown

class PresentAddVC: UIViewController {
    
    @IBOutlet weak var btnDrop: UIButton!
    @IBOutlet weak var textWorkerCount: UITextField!
    
    let dropDown = DropDown()
    var arrCategoryList: [ResCategoryList] = []
    var selectedCategoryId = ""
    var selectedCategoryName = ""
    var getRequestId = ""
    var cloCheck: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showProgressBar()
        self.getCategoryList()
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnDropDown(_ sender: UIButton) {
        self.dropDown.show()
    }
    
    func getCategoryList() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_category?"
        
        Alamofire.request(urlString, parameters: [:]).response { response in
            if let responseData = response.data {
                do {
                    
                    let root = try JSONDecoder().decode(GetGategory.self, from: responseData)
                    print(root)
                    if let CategoryListStatus = root.status {
                        if CategoryListStatus == "1" {
                            self.hideProgressBar()
                            self.arrCategoryList = root.result ?? []
                        }else{
                            self.hideProgressBar()
                            self.arrCategoryList = []
                        }
                        DispatchQueue.main.async {
                            self.configureCategoryDropdown()
                        }
                    }
                }catch {
                    self.hideProgressBar()
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func configureCategoryDropdown() {
        var arrCategoryId:[String] = []
        var arrCategoryName:[String] = []
        for val in self.arrCategoryList {
            arrCategoryId.append(val.id ?? "")
            arrCategoryName.append(val.name ?? "")
        }
        dropDown.anchorView = self.btnDrop
        dropDown.dataSource = arrCategoryName
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectedCategoryId = arrCategoryId[index]
            self.selectedCategoryName = item
            self.btnDrop.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        if let workerCount = self.textWorkerCount.text {
            if self.selectedCategoryId == "" {
                self.alert(alertmessage: "Please Select Category")
            }else if workerCount == "" {
                self.alert(alertmessage: "Please Add Number of Workers")
            }else{
                self.showProgressBar()
                self.addExtraService()
            }
        }
    }
    
    
    func addExtraService() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/add_user_request_extra_service?"
        let paramDetails = [
            "cat_id": self.selectedCategoryId,
            "cat_name": self.selectedCategoryName,
            "request_id": self.getRequestId,
            "no_of_worker": self.textWorkerCount.text!
        ]
        
        print(paramDetails)
        
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            let data = response.data
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(AddExtraServices.self, from: data!)
                print(root)
                if let loginStatus = root.status {
                    if loginStatus == "1"{
                        self.hideProgressBar()
                        let alert = UIAlertController(title: k.appName, message: "Service Added Successfully!", preferredStyle: .alert)
                        
                        let Ok = UIAlertAction(title: "Ok", style: .default) { (action) in
                            self.cloCheck?()
                            self.dismiss(animated: true)
                        }
                        
                        alert.addAction(Ok)
                        
                        self.present(alert, animated: true, completion: nil)
                        
                    }else{
                        self.hideProgressBar()
                        print("Something Went Wrong!")
                    }
                    DispatchQueue.main.async {
                    }
                }
            } catch {
                self.hideProgressBar()
                print(error.localizedDescription)
            }
        }
    }
}
