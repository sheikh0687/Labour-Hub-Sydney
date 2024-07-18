//
//  AssignedWorkerCell.swift
//  Labour Hub Sydeny
//
//  Created by mac on 12/04/23.
//

import UIKit
import SDWebImage

class AssignedWorkerCell: UITableViewCell {

    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblWorkerCount: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblEmployeName: UILabel!
    @IBOutlet weak var lblEmployeCategory: UILabel!
    @IBOutlet weak var lblEmpEmail: UILabel!
    @IBOutlet weak var viewToHide: UIView!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var listTableViewHeight: NSLayoutConstraint!
    
    let identifier = "EmpListCell"
    var arrWorkerAssign: [Assign_employee] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.listTableView.register(UINib(nibName: identifier, bundle: nil),forCellReuseIdentifier: identifier)
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension AssignedWorkerCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrWorkerAssign.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmpListCell", for: indexPath) as! EmpListCell
        
        cell.lblEmpName.text = "\(self.arrWorkerAssign[indexPath.row].first_name ?? "") \(self.arrWorkerAssign[indexPath.row].last_name ?? "")"
        cell.lblEmpCate.text = "(\(self.arrWorkerAssign[indexPath.row].cat_name ?? ""))"
        cell.lblEmpEmail.text = self.arrWorkerAssign[indexPath.row].email ?? ""
        if let imageUrl = URL(string: self.arrWorkerAssign[indexPath.row].image ?? ""){
            cell.img.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "profile_ic"), options: .continueInBackground,completed: nil)
        }
//        self.listTableViewHeight.constant = CGFloat(self.arrWorkerAssign.count * 120)
        return cell
    }
}

extension AssignedWorkerCell: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
