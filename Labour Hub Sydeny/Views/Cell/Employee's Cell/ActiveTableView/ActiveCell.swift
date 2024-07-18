//
//  ActiveCell.swift
//  Labour Hub Sydeny
//
//  Created by mac on 12/04/23.
//

import UIKit

class ActiveCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    var cloSeeDetails: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnSeeDetails(_ sender: UIButton) {
        self.cloSeeDetails?()
    }
}
