//
//  EmployeeProfileVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 10/04/23.
//

import UIKit
import Alamofire
import DropDown
import CountryPickerView
import SDWebImage

class EmployeeProfileVC: UIViewController {

    @IBOutlet weak var imageOutlet: UIButton!
    @IBOutlet weak var lblEmployeName: UILabel!
    @IBOutlet weak var lblEmployeEmail: UILabel!
    @IBOutlet weak var textFristName: UITextField!
    @IBOutlet weak var textLastName: UITextField!
    @IBOutlet weak var textMobileNumbe: UITextField!
    @IBOutlet weak var textEmailAddress: UITextField!
    @IBOutlet weak var textAddress: UITextView!
    @IBOutlet weak var textCompanyName: UITextField!
    @IBOutlet weak var textCompanyCode: UITextField!
    @IBOutlet weak var textABNNumber: UITextField!
    @IBOutlet weak var textSkills: UITextField!
    @IBOutlet weak var btnDrop: UIButton!
    @IBOutlet weak var textBankDetails: UITextField!
    @IBOutlet weak var textBSBNumber: UITextField!
    @IBOutlet weak var lblNumber: UILabel!
    
    let cpvInternal = CountryPickerView()
    weak var cpvTextField: CountryPickerView!
    var phoneKey:String?
    let dropDown = DropDown()
    var arrCategoryList: [ResCategoryList] = []
    var arrImage:[[String: AnyObject]] = []
    var image = UIImage()
    var selectedCategoryId = ""
    var selectedCategoryName = ""
    var numberType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCountryView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showProgressBar()
        self.getUserProfileDetials()
        self.getCategoryList()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
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
        let cp = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        self.textMobileNumbe.leftView = cp
        self.textMobileNumbe.leftViewMode = .always
        self.cpvTextField = cp
        cp.delegate = self
        [cp].forEach {
            $0?.dataSource = self
        }
        cp.countryDetailsLabel.font = UIFont(name: "Apercu-Regular", size: 14.0)
        self.phoneKey = cp.selectedCountry.phoneCode
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
                            self.arrCategoryList = root.result ?? []
                        }else{
                            self.arrCategoryList = []
                        }
                        DispatchQueue.main.async {
                            self.configureCategoryDropdown()
                        }
                    }
                }catch {
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
        dropDown.bottomOffset = CGPoint(x: -5, y: 45)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectedCategoryId = arrCategoryId[index]
            self.selectedCategoryName = item
            self.btnDrop.setTitle(item, for: .normal)
        }
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
                        self.lblEmployeName.text = "\(root.result?.first_name ?? "") \(root.result?.last_name ?? "")"
                        self.lblEmployeEmail.text = root.result?.email ?? ""
                        self.textFristName.text = root.result?.first_name ?? ""
                        self.textLastName.text = root.result?.last_name ?? ""
                        self.textEmailAddress.text = root.result?.email ?? ""
                        self.textAddress.text = root.result?.address ?? ""
                        self.textCompanyName.text = root.result?.company_name ?? ""
                        self.textCompanyCode.text = root.result?.company_code ?? ""
                        self.textABNNumber.text = root.result?.aBN_number ?? ""
                        self.textMobileNumbe.text = root.result?.mobile ?? ""
                        self.btnDrop.setTitle(root.result?.cat_name ?? "", for: .normal)
                        self.textBankDetails.text = root.result?.bank_account ?? ""
                        self.textBSBNumber.text = root.result?.bank_branch ?? ""
                        
                        self.numberType = root.result?.number_type ?? ""
                        print(self.numberType)
                        
                        if self.numberType == "ABN"{
                            self.lblNumber.text! = "ABN Number"
                        }else if self.numberType == "TFN"{
                            self.lblNumber.text! = "TFN Number"
                        }
                        
                        if let imageUrl = URL(string: root.result?.image ?? ""){
                            self.imageOutlet.sd_setImage(with: imageUrl, for: .normal, placeholderImage: UIImage(named: "profile_ic"), options: .continueInBackground,completed: nil)
                        }else{
                        }
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
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        Api.shared.updatedEmployeProfile(self, self.paramUdatedProfile(), images: self.imageDictUpdatedProfile(), videos: [:]) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: "Profile Updated Successfully!", delegate: nil, parentViewController: self) { boool in
                print("Updated Successfully!")
            }
        }
    }

    func paramUdatedProfile() -> [String: String] {
        let paramAnswer = [
            "user_id": UserDefaults.standard.value(forKey: "user_id") as! String,
            "first_name": self.textFristName.text!,
            "last_name": self.textLastName.text!,
            "mobile": self.textMobileNumbe.text!,
            "mobile_code": "",
            "email": self.textEmailAddress.text!,
            "lat": String(kAppDelegate.coordinate2.coordinate.latitude),
            "lon": String(kAppDelegate.coordinate2.coordinate.longitude),
            "about_dog": "",
            "address": self.textAddress.text!,
            "cat_id": self.selectedCategoryId,
            "cat_name": self.selectedCategoryName,
            "company_name": self.textCompanyName.text!,
            "company_code": self.textCompanyCode.text!,
            "ABN_number": self.textABNNumber.text!,
            "bank_account": self.textBankDetails.text!,
            "bank_branch": self.textBSBNumber.text!,
            "skill": self.textSkills.text!,
            "number_type": ""
        ]
        print(paramAnswer)
        return paramAnswer
    }
    
    func imageDictUpdatedProfile() -> [String: UIImage] {
        var dict : [String: UIImage] = [:]
        dict["image"] = image
        return dict
    }
    
    @IBAction func btnSignOut(_ sender: UIButton) {
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
    
    @IBAction func btnChnagePassword(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension EmployeeProfileVC: CountryPickerViewDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.phoneKey = country.phoneCode
    }
}

extension EmployeeProfileVC: CountryPickerViewDataSource {
    
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
