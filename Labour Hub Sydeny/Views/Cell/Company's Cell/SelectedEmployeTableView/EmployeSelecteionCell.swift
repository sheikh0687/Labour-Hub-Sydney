//
//  EmployeSelecteionCell.swift
//  Labour Hub Sydeny
//
//  Created by mac on 09/05/23.
//

import UIKit

class EmployeSelecteionCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var btnAllCheck: UIButton!
    @IBOutlet weak var itemLabel: UILabel!
    
    var cloChecked: (() -> Void)?
    
    
    func configure(with item: String, at index: Int) {
        btnAllCheck.setTitle(item, for: .normal)
           itemLabel.text = item

           // Determine visibility based on the index
           itemLabel.isHidden = (index == 0) ? false : true
          btnAllCheck.isHidden = (index == 0) ? false : true
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
       
    }
    
    @IBAction func btnAllChecked(_ sender: UIButton) {
        self.cloChecked?()
    }
}
