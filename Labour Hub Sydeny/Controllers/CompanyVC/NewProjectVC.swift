//
//  NewProjectVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 18/03/23.
//

import UIKit
import Alamofire
import DropDown
import Gallery

class NewProjectVC: UIViewController {
    
    @IBOutlet weak var selectedWorkertableView: UITableView!
    @IBOutlet weak var selectedWorkerTableHeight: NSLayoutConstraint!
    @IBOutlet weak var textWorkerNumber: UITextField!
    @IBOutlet weak var imageOutlet: UIImageView!
    
    @IBOutlet var viewOutlet: UIView!
    @IBOutlet weak var viewToHide: UIView!
    @IBOutlet weak var btnDrop: UIButton!
    @IBOutlet weak var btnDrop2: UIButton!
    @IBOutlet weak var collection_photo: UICollectionView!
    @IBOutlet weak var textTitle: UITextField!
    @IBOutlet weak var textAddress: UITextView!
    @IBOutlet weak var textDescription: UITextField!
    @IBOutlet weak var btnStartDate: UIButton!
    @IBOutlet weak var btnStartTime: UIButton!
    @IBOutlet weak var btnEndDate: UIButton!
    @IBOutlet weak var btnEndTime: UIButton!
    
    
    var arrString = [Any]()
    let dropDown = DropDown()
    let dropDown2 = DropDown()
    var arrCategoryList: [ResCategoryList] = []
    var arrCLientProject: [ResClientProjectDetail] = []
    var arrImage:[[String: AnyObject]] = []
    
    var selectedCategoryId = ""
    var selectedCategoryName = ""
    var selectedClientProjectId = ""
    var selectedClientProjectName = ""
    var strDate = ""
    var strTime = ""
    var strEndDate = ""
    var strEndTime = ""
    var strNoOfWorker = ""
    
    var totalCategoryId:[String] = []
    var totalCategoryName:[String] = []
    var noOfWorker:[String] = []
    
    var totalNoOfWorker = 0
    var strCategoryId = ""
    var strCategoryName = ""
    var newAddress = ""
    var projectLat = 0.0
    var projectLon = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.selectedWorkertableView.isHidden = true
        self.showProgressBar()
        self.getCategoryList()
        self.getClientProjectList()
    }
    
    
    @IBAction func btnBAck(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnLocation(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "AddressPickerVC") as! AddressPickerVC
        vc.locationPickedBlock = { (addressCoordinate, latVal, lonVal, addressVal) in
            self.textAddress.text = addressVal
            self.newAddress = addressVal
            self.projectLat = latVal
            self.projectLon = lonVal
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnImageTapped(_ sender: UIButton) {
        Config.Camera.recordLocation = true
        Config.Camera.imageLimit = 3
        Config.tabsToShow = [.imageTab, .cameraTab]
        let gallery = GalleryController()
        gallery.delegate = self
        present(gallery, animated: true, completion: nil)
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
        dropDown.bottomOffset = CGPoint(x: -5, y: 45)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectedCategoryId = arrCategoryId[index]
            self.selectedCategoryName = item
            self.btnDrop.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func btnDropCLientList(_ sender: UIButton) {
        self.dropDown2.show()
    }
    
    func getClientProjectList() {
        let urlString = "https://labourhubsydney.com.au/LabourHubSydney/webservice/get_company_user?"
        let paramDetails =
        [
            "company_code": k.userDefault.value(forKey: k.session.commonCompanyCode) as! String
        ]
        
        Alamofire.request(urlString, parameters: paramDetails).response { response in
            if let responseData = response.data {
                do {
                    
                    let root = try JSONDecoder().decode(GetClientProject.self, from: responseData)
                    print(root)
                    if let CategoryListStatus = root.status {
                        if CategoryListStatus == "1" {
                            self.arrCLientProject = root.result ?? []
                        }else{
                            self.arrCLientProject = []
                        }
                        DispatchQueue.main.async {
                            self.configureClientProjectDropdown()
                        }
                    }
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func configureClientProjectDropdown() {
        var arrClientProjectId:[String] = []
        var arrClientProjectName:[String] = []
        for val in self.arrCLientProject {
            arrClientProjectId.append(val.id ?? "")
            arrClientProjectName.append("\(val.first_name ?? "") \(val.last_name ?? "")")
        }
        dropDown2.anchorView = self.btnDrop2
        dropDown2.dataSource = arrClientProjectName
        dropDown2.bottomOffset = CGPoint(x: -5, y: 45)
        dropDown2.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.selectedClientProjectId = arrClientProjectId[index]
            self.selectedClientProjectName = item
            self.btnDrop2.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func btnStartDate(_ sender: UIButton) {
        self.datePickerTapped(strFormat: "YYYY-MM-dd", mode: .date) { dateString in
            self.strDate = dateString
            self.btnStartDate.setTitle(dateString, for: .normal)
        }
    }
    
    @IBAction func btnStartTime(_ sender: UIButton) {
        self.datePickerTapped(strFormat: "HH:mm", mode: .time) { dateString in
            self.strTime = dateString
            self.btnStartTime.setTitle(dateString, for: .normal)
        }
    }
    
    @IBAction func btnEndDate(_ sender: UIButton) {
        self.datePickerTapped(strFormat: "YYYY-MM-dd", mode: .date) { dateString in
            self.strEndDate = dateString
            self.btnEndDate.setTitle(dateString, for: .normal)
        }
    }
    
    @IBAction func btnEndTime(_ sender: UIButton) {
        self.datePickerTapped(strFormat: "HH:mm", mode: .time) { dateString in
            self.strEndTime = dateString
            self.btnEndTime.setTitle(dateString, for: .normal)
        }
    }
    
    @IBAction func btnAddWorker(_ sender: UIButton) {
        let worker = self.textWorkerNumber.text
        if worker == ""{
            self.alert(alertmessage: "Please enter number of workers!")
        }else if self.selectedCategoryId == "" {
            self.alert(alertmessage: "Please Select Category!")
        }else{
            self.selectedWorkertableView.isHidden = false
            self.arrString.insert(viewToHide, at: 0)
            self.selectedWorkertableView.beginUpdates()
            self.selectedWorkertableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .right)
            self.selectedWorkertableView.endUpdates()
            self.selectedWorkerTableHeight.constant = CGFloat(45 * self.arrString.count)
            self.totalCategoryId.append(self.selectedCategoryId)
            print(self.totalCategoryId)
            self.totalCategoryName.append(self.selectedCategoryName)
            print(self.totalCategoryName)
            self.totalNoOfWorker = self.totalNoOfWorker + Int(Int(self.textWorkerNumber.text!) ?? 0)
            self.noOfWorker.append(self.textWorkerNumber.text!)
            self.btnDrop.setTitle("Select Category", for: .normal)
            self.textWorkerNumber.text! = ""
        }
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        self.strCategoryId = self.totalCategoryId.joined(separator: ",")
        self.strCategoryName = self.totalCategoryName.joined(separator: ",")
        self.strNoOfWorker = self.noOfWorker.joined(separator: ",")
        self.RagistationValidation()
    }
    
    func RagistationValidation()
    {
        
        if self.selectedClientProjectId.isEmpty
        {
            self.alert(alertmessage: "Please Select the Client!")
        }
        else if textTitle.text!.isEmpty
        {
            self.alert(alertmessage: "Please Enter Title For Project!")
        }
        else if textAddress.text!.isEmpty
        {
            self.alert(alertmessage: "Please Enter Address!")
        }
        else if textDescription.text!.isEmpty
        {
            self.alert(alertmessage: "Please Enter Description!")
        }
        else if self.selectedCategoryId.isEmpty
        {
            self.alert(alertmessage: "Please Select the Category!")
        }
        else if arrString.isEmpty
        {
            self.alert(alertmessage: "Please Click On Add Button To Choose Worker!")
        }
        else if strDate.isEmpty
        {
            self.alert(alertmessage: "Please Select Start Date!")
        }
        else if strTime.isEmpty
        {
            self.alert(alertmessage: "Please Select Start Time!")
        }
        else
        {
            Api.shared.addUserProjectDt(self, self.paramAddProjectDetails(), images: self.imageDictAddPProject(), videos: [:]) { responseData in
                Utility.showAlertWithAction(withTitle: k.appName, message: "Project Added Successfully Added Successfully!", delegate: nil, parentViewController: self) { boool in
                    Switcher.checkLoginStatus()
                }
            }
        }
    }
    
    func paramAddProjectDetails() -> [String: String] {
        let paramAnswer = [
            "user_id": self.selectedClientProjectId,
            "title": self.textTitle.text!,
            "cat_id": self.strCategoryId,
            "cat_name": self.strCategoryName,
            "description": self.textDescription.text!,
            "company_code": k.userDefault.value(forKey: k.session.commonCompanyCode) as! String,
            "company_id": "1",
            "timezone": localTimeZoneIdentifier,
            "no_of_worker": self.strNoOfWorker,
            "total_worker_count": String(self.totalNoOfWorker),
            "start_date": self.strDate,
            "start_time": self.strTime,
            "end_date": self.strEndDate,
            "end_time": self.strEndTime,
            "type": "SUBADMIN",
            "address": self.newAddress,
            "lat": String(self.projectLat),
            "lon":  String(self.projectLon),
            "status": "Accept",
            "color_code": "#ffffff",
        ]
        print(paramAnswer)
        return paramAnswer
        
    }
    
    func imageDictAddPProject() -> [String: Array<Any>] {
        var dict : [String: Array<Any>] = [:]
        var paramImage:[UIImage] = []
        if self.arrImage.count > 0 {
            for val in self.arrImage {
                if let type = val["type"] as? String, type == "local" {
                    paramImage.append(val["image"] as! UIImage)
                }
            }
        }
        dict["request_images[]"] = paramImage
        return dict
    }
}

extension NewProjectVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrString.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellForSelectedWorker", for: indexPath) as! CellForSelectedWorker
        
        
        cell.lblCategory.text  = self.selectedCategoryName
        cell.lblWorkerCount.text = self.textWorkerNumber.text ?? ""
        
        cell.cloMinus = { [self] in
            let point = cell.`btnMinusOt`.convert(CGPoint.zero, to: selectedWorkertableView)
            guard let indexpath = self.selectedWorkertableView.indexPathForRow(at: point) else {return}
            self.arrString.remove(at: indexpath.row)
            self.selectedWorkertableView.beginUpdates()
            self.selectedWorkertableView.deleteRows(at: [IndexPath(row: indexpath.row, section: 0)], with: .left)
            self.selectedWorkertableView.endUpdates()
            self.selectedWorkerTableHeight.constant = CGFloat(45 * self.arrString.count - 1)
            if self.arrString.count > 0 {
                let valueOfWorker = Int(cell.lblWorkerCount.text!) ?? 0
                self.totalCategoryId.remove(at: indexpath.row)
                print(self.totalCategoryId)
                self.totalCategoryName.remove(at: indexpath.row)
                print(self.totalCategoryName)
                self.totalNoOfWorker = self.totalNoOfWorker - valueOfWorker
            }
        }
        return cell
    }
}

extension NewProjectVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}

extension NewProjectVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCell
        if let img = arrImage[indexPath.row]["image"] as? UIImage {
            cell.btn_Image.setImage(img, for: .normal)
        }
        cell.btn_Image.tag = indexPath.row
        cell.btn_Image.addTarget(self, action: #selector(click_On_tab(button:)), for: .touchUpInside)
        
        cell.btn_cross.isHidden = false
        cell.btn_cross.tag = indexPath.row
        cell.btn_cross.addTarget(self, action: #selector(click_On_Cross(button:)), for: .touchUpInside)
        if self.arrImage.count > 0{
            self.imageOutlet.isHidden = true
        }else{
            self.imageOutlet.isHidden = false
        }
        return cell
    }
    
    @objc func click_On_Cross(button:UIButton)  {
        print(button.tag)
        self.collection_photo.reloadData()
    }
    
    @objc func click_On_tab(button:UIButton)  {
    }
}

extension NewProjectVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: 200)
    }
}

extension NewProjectVC: GalleryControllerDelegate {
    
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        
        Image.resolve(images: images, completion: { [weak self] resolvedImages in
            print(resolvedImages.compactMap({ $0 }))
            for img in resolvedImages {
                var dict : [String:AnyObject] = [:]
                dict["image"] = img as AnyObject
                dict["type"] = "local" as AnyObject
                self?.arrImage.append(dict)
            }
            self!.collection_photo.reloadData()
        })
        self.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        print(video)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        print([Image].self)
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        self.dismiss(animated: true, completion: nil)
    }
}
