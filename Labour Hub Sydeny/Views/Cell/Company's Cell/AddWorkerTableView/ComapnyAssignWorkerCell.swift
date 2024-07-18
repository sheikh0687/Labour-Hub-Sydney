//
//  ComapnyAssignWorkerCell.swift
//  Labour Hub Sydeny
//
//  Created by mac on 15/04/23.
//

import UIKit
import SDWebImage

class ComapnyAssignWorkerCell: UITableViewCell {

    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblWorkerCount: UILabel!
    @IBOutlet weak var lblEmpName: UILabel!
    @IBOutlet weak var lblEmpCategory: UILabel!
    @IBOutlet weak var lblEmpEmail: UILabel!
    @IBOutlet weak var btnStatusOt: UIButton!
    @IBOutlet weak var viewToHide: UIStackView!
    @IBOutlet weak var listTableView: UITableView!
   
    @IBOutlet weak var listTableViewHeight: NSLayoutConstraint!
    
    var cloPresent: (() -> Void)?
    var cloPresentStatus: (() -> Void)?
    var cloPresentDelete: (() -> Void)?
    var cloRemove: ((_ _id: String) -> Void)?
    var arrWorkerAssign: [Company_Assign_employee] = []
    var statusAssign = ""
    var assignId = ""
    
    let identifier = "ComListCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.listTableView.register(UINib(nibName: identifier, bundle: nil),forCellReuseIdentifier: identifier)
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnEdit(_ sender: UIButton) {
        self.cloPresent?()
    }
    
    @IBAction func btnDelete(_ sender: UIButton) {
        self.cloPresentDelete?()
    }
    
    @IBAction func btnStatus(_ sender: UIButton) {
        self.cloPresentStatus?()
    }
    
    @IBAction func btnRemove(_ sender: UIButton) {
        self.cloRemove?(assignId)
    }
}

extension ComapnyAssignWorkerCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrWorkerAssign.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComListCell", for: indexPath) as! ComListCell
        
        self.statusAssign = self.arrWorkerAssign[indexPath.row].status ?? ""
        cell.lblEmpName.text = "\(self.arrWorkerAssign[indexPath.row].first_name ?? "") \(self.arrWorkerAssign[indexPath.row].last_name ?? "")"
        cell.lblEmpCate.text = "(\(self.arrWorkerAssign[indexPath.row].cat_name ?? ""))"
        cell.lblEmpEmail.text = self.arrWorkerAssign[indexPath.row].email ?? ""
//        self.listTableViewHeight.constant = CGFloat(self.arrWorkerAssign.count * 150)
        
        if let imageUrl = URL(string: self.arrWorkerAssign[indexPath.row].image ?? ""){
            cell.img.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "profile_ic"), options: .continueInBackground,completed: nil)
        }
        
       
        cell.cloRemove = {
            self.assignId = self.arrWorkerAssign[indexPath.row].assign_id ?? ""
            print(" Assigned Time Id \(self.assignId)")
            self.cloRemove?(self.assignId)
        }

        return cell
    }
}

extension ComapnyAssignWorkerCell: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 140
    }
}

