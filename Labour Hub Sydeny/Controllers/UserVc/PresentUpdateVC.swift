//
//  PresentUpdateVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 08/04/23.
//

import UIKit
import Alamofire

class PresentUpdateVC: UIViewController {

    @IBOutlet weak var textWorkerName: UITextField!
    @IBOutlet weak var textWorkerNum: UITextField!
    var workerCategory = ""
    var workerCount = ""
    var serviceId = ""
    var requestId = ""
    var cloPresentWorker: ((_ _argument: UITextField) -> Void)?
    var cloCheck: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textWorkerName.text! = self.workerCategory
        self.textWorkerNum.text! = self.workerCount
    }

    
    @IBAction func btnUpdate(_ sender: UIButton) {
        self.showProgressBar()
        self.addUpdatedService()
    }
    
    func addUpdatedService() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/update_service_worker?"
        let paramDetails = [
            "service_id": self.serviceId,
            "request_id": self.requestId,
            "no_of_worker": self.textWorkerNum.text!
            ]
        
        print(paramDetails)
        
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            let data = response.data
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(getUpdatedService.self, from: data!)
                print(root)
                if let loginStatus = root.status {
                    if loginStatus == "1"{
                        self.hideProgressBar()
                        let alert = UIAlertController(title: k.appName, message: "Updated Successfully!", preferredStyle: .alert)
                        
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
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnAddWorkers(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "PresentAddVC") as! PresentAddVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        vc.getRequestId = self.requestId
        vc.cloCheck = {
            self.cloCheck?()
        }
        self.present(vc, animated: true, completion: nil)
    }
}
