//
//  ClientSignUpVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 27/03/23.
//

import UIKit
import Alamofire
import CountryPickerView

class ClientSignUpVC: UIViewController {
    
    @IBOutlet weak var textFirstName: UITextField!
    @IBOutlet weak var textLastName: UITextField!
    @IBOutlet weak var textMobileNumber: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textAddress: UITextView!
    @IBOutlet weak var textCompanyName: UITextField!
    @IBOutlet weak var textCompanyCOde: UITextField!
    @IBOutlet weak var textABNNumber: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textConfirmPassword: UITextField!
    @IBOutlet weak var abnOt: UIButton!
    @IBOutlet weak var tfnOt: UIButton!
    @IBOutlet weak var btnChecked: UIButton!
    
    let cpvInternal = CountryPickerView()
    weak var cpvTextField: CountryPickerView!
    var phoneKey:String?
    var addressClient = ""
    var clientLat = 0.0
    var clientLon = 0.0
    var numberType = "ABN"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCountryView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.textABNNumber.delegate = self
        self.textABNNumber.attributedPlaceholder = NSAttributedString(string: "Enter your Comapny ABN Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        self.btnChecked.setImage(UIImage.init(named: "Uncheck"), for: .normal)
    }
    
    @IBAction func btnLocation(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "AddressPickerVC") as! AddressPickerVC
        vc.locationPickedBlock = { (addressCoordinate, latVal, lonVal, addressVal) in
            self.textAddress.text = addressVal
            self.addressClient = addressVal
            self.clientLat = latVal
            self.clientLon = lonVal
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSignIn(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureCountryView() {
        let cp = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 80, height: 16))
        self.textMobileNumber.leftView = cp
        self.textMobileNumber.leftViewMode = .always
        self.cpvTextField = cp
        cp.delegate = self
        [cp].forEach {
            $0?.dataSource = self
        }
        cp.countryDetailsLabel.font = UIFont(name: "Apercu-Regular", size: 14.0)
        self.phoneKey = cp.selectedCountry.phoneCode
    }
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        let status = self.RagistationValidation()
    }
    
    func RagistationValidation()->Bool
        {
               if textFirstName.text!.isEmpty
               {
                self.alert(alertmessage: "Required First Name")
                return false
                }
               else if textLastName.text!.isEmpty
               {
                self.alert(alertmessage: "Required Last Name")
                return false
               }
               else if textMobileNumber.text!.isEmpty
               {
                   self.alert(alertmessage: "Please Enter Mobile Number")
                return false
               }
               else if textEmail.text!.isEmpty
               {
                   self.alert(alertmessage: "Email Address Not Found")
                return false
               }
               else if textAddress.text!.isEmpty
               {
                self.alert(alertmessage: "Select Address")
                return false
               }
               else if textCompanyName.text!.isEmpty
               {
                self.alert(alertmessage: "Enter Company Name")
                return false
               }
               else if textCompanyCOde.text!.isEmpty
               {
                   self.alert(alertmessage: "Enter Company Code")
                   return false
               }
            else if textABNNumber.text!.isEmpty
            {
                self.alert(alertmessage: "Enter ABN Number")
                return false
            }
            else if textPassword.text!.isEmpty
            {
                self.alert(alertmessage: "Please Enter the Password")
                return false
            }
            else if textConfirmPassword.text!.isEmpty
            {
                self.alert(alertmessage: "Please Confirm Password")
                return false
            }else if self.btnChecked.image(for: .normal) == UIImage.init(named: "Uncheck")
            {
                self.alert(alertmessage: "Please Read the Terms And Condition For Proceed")
                return false
            }
            else
            {
                self.registerNow()
                return true
            }
        }
    
    
    func paramSignup() -> [String:AnyObject] {
        var dict:[String:AnyObject] = [:]
        dict["first_name"] = self.textFirstName.text! as AnyObject
        dict["last_name"] = self.textLastName.text!  as AnyObject
        dict["email"] = self.textEmail.text! as AnyObject
        dict["mobile"] = self.textMobileNumber.text! as AnyObject
        dict["lat"] = String(kAppDelegate.coordinate2.coordinate.latitude) as AnyObject
        dict["lon"] = String(kAppDelegate.coordinate2.coordinate.longitude) as AnyObject
        dict["password"] = self.textPassword.text! as AnyObject
        dict["register_id"] = k.emptyString as AnyObject
        dict["ios_register_id"] = k.iosRegisterId as AnyObject
        dict["use_referral_code"] = k.emptyString as AnyObject
        dict["type"] = k.userType as AnyObject
        dict["mobile_with_code"] = k.emptyString as AnyObject
        dict["company_name"] = self.textCompanyName.text! as AnyObject
        dict["company_code"] = self.textCompanyCOde.text! as AnyObject
        dict["ABN_number"] = self.textABNNumber.text! as AnyObject
        dict["address"] = self.textAddress.text! as AnyObject
        dict["bank_account"] = k.emptyString as AnyObject
        dict["bank_branch"] = k.emptyString as AnyObject
        dict["number_type"] = self.numberType as AnyObject
        print(dict)
        return dict
    }
    
    func registerNow() {
        print(self.paramSignup())
        Api.shared.signUpUser(self, self.paramSignup()) { (response) in
            Utility.showAlertWithAction(withTitle: k.appName, message: "Your Account has created successfully!", delegate: nil, parentViewController: self) { (boool) in
                k.userDefault.set(true, forKey: k.session.status)
                k.userDefault.set(response.id ?? "", forKey: k.session.userId)
                k.userDefault.set("\(response.first_name ?? "") \(response.last_name ?? "")", forKey: k.session.userName)
                k.userDefault.set(response.image ?? "", forKey: k.session.userImage)
                k.userDefault.set(response.email ?? "", forKey: k.session.userEmail)
                k.userDefault.set(response.type ?? "", forKey: k.session.userType)
                k.userDefault.set(response.company_code ?? "", forKey: k.session.commonCompanyCode)
                Switcher.checkLoginStatus()
            }
        }
    }
    
    @IBAction func btnABN(_ sender: UIButton) {
        self.tappedToChange()
        self.textABNNumber.attributedPlaceholder = NSAttributedString(string: "Enter your Company ABN Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        self.numberType = "ABN"
    }
    
    @IBAction func btnTFN(_ sender: UIButton) {
        self.tappedToChange2()
        self.textABNNumber.attributedPlaceholder = NSAttributedString(string: "Enter your Company TFN Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        self.numberType = "TFN"
    }
    
    func tappedToChange()
    {
        self.tfnOt.setImage(UIImage(named: "mdi_checkbox-blank-circle-outline"), for: .normal)
        self.abnOt.setImage(UIImage(named: "mdi_checkbox-blank-circle-outline-1"), for: .normal)
    }
    
    func tappedToChange2()
    {
        self.abnOt.setImage(UIImage(named: "mdi_checkbox-blank-circle-outline"), for: .normal)
        self.tfnOt.setImage(UIImage(named: "mdi_checkbox-blank-circle-outline-1"), for: .normal)
        
    }
    
    @IBAction func btnCheckBox(_ sender: UIButton) {
        if self.btnChecked.image(for: .normal) == UIImage.init(named: "Uncheck") {
            self.btnChecked.setImage(UIImage.init(named: "Checked"), for: .normal)
        } else {
            self.btnChecked.setImage(UIImage.init(named: "Uncheck"), for: .normal)
        }
    }
    
    @IBAction func btnTermsNCondition(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "TermsAndConditionVC") as! TermsAndConditionVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ClientSignUpVC: UITextFieldDelegate
{
    
}

extension ClientSignUpVC: CountryPickerViewDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.phoneKey = country.phoneCode
    }
}

extension ClientSignUpVC: CountryPickerViewDataSource {
    
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
