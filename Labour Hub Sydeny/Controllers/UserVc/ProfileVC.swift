//
//  ProfileVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 18/03/23.
//

import UIKit
import Alamofire
import CountryPickerView
import SDWebImage

class ProfileVC: UIViewController {
    
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var textFristName: UITextField!
    @IBOutlet weak var textLastName: UITextField!
    @IBOutlet weak var textMobile: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textAddress: UITextView!
    @IBOutlet weak var textCompanyName: UITextField!
    @IBOutlet weak var textCompanyCode: UITextField!
    @IBOutlet weak var textABNNumber: UITextField!
    @IBOutlet weak var lblAbnTfn: UILabel!
    @IBOutlet weak var imageOutlet: UIButton!
    
    
    let cpvInternal = CountryPickerView()
    weak var cpvTextField: CountryPickerView!
    var phoneKey:String?
    var image = UIImage()
    var numberType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showProgressBar()
        self.getUserProfileDetials()
        self.configureCountryView()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func btnImage(_ sender: UIButton) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.image = image
            sender.contentMode = .scaleToFill
            sender.setImage(image, for: .normal)
        }
    }
    
    func configureCountryView() {
        let cp = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 80, height: 16))
        self.textMobile.leftView = cp
        self.textMobile.leftViewMode = .always
        self.cpvTextField = cp
        cp.delegate = self
        [cp].forEach {
            $0?.dataSource = self
        }
        cp.countryDetailsLabel.font = UIFont(name: "Apercu-Regular", size: 14.0)
        self.phoneKey = cp.selectedCountry.phoneCode
    }
    
    func getUserProfileDetials() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_profile?"
        let paramDetails = [
            "user_id": UserDefaults.standard.value(forKey: "user_id") as! String
        ]
        
        print(paramDetails)
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            let data = response.data
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(getProfile.self, from: data!)
                print(root)
                if let loginStatus = root.status {
                    if loginStatus == "1"{
                        self.hideProgressBar()
                        self.lblFullName.text = "\(root.result?.first_name ?? "") \(root.result?.last_name ?? "")"
                        self.lblEmail.text = root.result?.email ?? ""
                        self.textFristName.text = root.result?.first_name ?? ""
                        self.textLastName.text = root.result?.last_name ?? ""
                        self.textEmail.text = root.result?.email ?? ""
                        self.textAddress.text = root.result?.address ?? ""
                        self.textCompanyName.text = root.result?.company_name ?? ""
                        self.textCompanyCode.text = root.result?.company_code ?? ""
                        self.textABNNumber.text = root.result?.aBN_number ?? ""
                        self.textMobile.text = root.result?.mobile ?? ""
                        self.numberType = root.result?.number_type ?? ""
                        print(self.numberType)
                        
                        if self.numberType == "ABN"{
                            self.lblAbnTfn.text! = "ABN Number"
                        }else if self.numberType == "TFN"{
                            self.lblAbnTfn.text! = "TFN Number"
                        }
                        
                        if let imageUrl = URL(string: root.result?.image ?? ""){
                            self.imageOutlet.sd_setImage(with: imageUrl, for: .normal, placeholderImage: UIImage(named: "profile_ic"), options: .continueInBackground,completed: nil)
                        }else{
                        }
                    }
                    else{
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
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        Api.shared.updatedUserProfile(self, self.paramUdatedProfile(), images: self.imageupdatedDict(), videos: [:]) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: "Profile Updated Successfully!", delegate: nil, parentViewController: self) { boool in
                self.getUserProfileDetials()
            }
        }
    }
    
    func paramUdatedProfile() -> [String: String] {
        let paramAnswer = [
            "user_id": UserDefaults.standard.value(forKey: "user_id") as! String,
            "first_name": self.textFristName.text!,
            "last_name": self.textLastName.text!,
            "mobile": self.textMobile.text!,
            "mobile_code": String(self.phoneKey ?? ""),
            "email": self.textEmail.text!,
            "lat": String(kAppDelegate.coordinate2.coordinate.latitude),
            "lon": String(kAppDelegate.coordinate2.coordinate.longitude),
            "about_dog": "",
            "address": self.textAddress.text!,
            "cat_id": "",
            "cat_name": "",
            "company_name": self.textCompanyName.text!,
            "company_code": self.textCompanyCode.text!,
            "ABN_number": self.textABNNumber.text!,
            "bank_account": "",
            "bank_branch": "",
            "skill": ""
        ]
        print(paramAnswer)
        return paramAnswer
        
    }
    
    func imageupdatedDict() -> [String: UIImage]{
        var imgDict: [String: UIImage] = [:]
        imgDict["image"] = image
        return imgDict
    }
    
    @IBAction func btnSingOut(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "LogOutVC") as! LogOutVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func btnDeleteAccount(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "PresentAccountDelete") as! PresentAccountDelete
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnChangePassword(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileVC: CountryPickerViewDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.phoneKey = country.phoneCode
    }
}

extension ProfileVC: CountryPickerViewDataSource {
    
    func preferredCountries(in countryPickerView: CountryPickerView) -> [Country] {
        var countries = [Country]()
        ["SA"].forEach { code in
            if let country = countryPickerView.getCountryByCode(code) {
                countries.append(country)
            }
        }
        return countries
    }
    
    func sectionTitleForPreferredCountries(in countryPickerView: CountryPickerView) -> String? {
        return "Preferred title"
    }
    
    func showOnlyPreferredSection(in countryPickerView: CountryPickerView) -> Bool {
        return false
    }
    
    func navigationTitle(in countryPickerView: CountryPickerView) -> String? {
        return "Select a Country"
    }
}
