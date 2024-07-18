//
//  RequiredEmployeCell.swift
//  Labour Hub Sydeny
//
//  Created by mac on 06/04/23.
//

import UIKit
import SDWebImage

class RequiredEmployeCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumberOfWorker: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblEmployeName: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblEmployeEmailk: UILabel!
    @IBOutlet weak var viewToHide: UIView!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var listTableViewHeight: NSLayoutConstraint!
    
    var clodelete: (() -> Void)?
    var cloRemove: (() -> Void)?
    var cloPresentEdit: (() -> Void)?
    var arrWorkerAssign: [Assign_employee] = []
    var identifier = "ListCell"
    
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
        self.cloPresentEdit?()
    }
    
    @IBAction func btnDelete(_ sender: UIButton) {
         self.clodelete?()
    }
    
    @IBAction func btnRemove(_ sender: UIButton) {
        self.cloRemove?()
    }
}

extension RequiredEmployeCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrWorkerAssign.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        
        cell.lblEmpName.text = "\(self.arrWorkerAssign[indexPath.row].first_name ?? "") \(self.arrWorkerAssign[indexPath.row].last_name ?? "")"
        cell.lblEmpCate.text = "(\(self.arrWorkerAssign[indexPath.row].cat_name ?? ""))"
        cell.lblEmpEmail.text = self.arrWorkerAssign[indexPath.row].email ?? ""

        if let imageUrl = URL(string: self.arrWorkerAssign[indexPath.row].image ?? ""){
            cell.img.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "profile_ic"), options: .continueInBackground,completed: nil)
        }
        
        cell.cloRemove = {
            self.cloRemove?()
        }
        return cell
    }
}

extension RequiredEmployeCell: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
