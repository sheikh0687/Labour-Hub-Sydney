//
//  ActiveProjectCell.swift
//  Labour Hub Sydeny
//
//  Created by mac on 05/04/23.
//

import UIKit

class ActiveProjectCell: UITableViewCell {

 
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    var cloSeeDetails: (() -> Void)?
    var cloTimesheet: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnSeeDetails(_ sender: UIButton) {
        self.cloSeeDetails?()
    }
    
    @IBAction func btnTimesheet(_ sender: UIButton) {
        self.cloTimesheet?()
    }
    
}
