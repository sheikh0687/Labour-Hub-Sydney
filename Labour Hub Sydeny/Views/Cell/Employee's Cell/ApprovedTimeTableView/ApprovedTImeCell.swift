//
//  ApprovedTImeCell.swift
//  Labour Hub Sydeny
//
//  Created by mac on 12/04/23.
//

import UIKit

class ApprovedTImeCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    var cloTimesheet: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnSeeTimesheet(_ sender: UIButton) {
        self.cloTimesheet?()
    }
    
}
