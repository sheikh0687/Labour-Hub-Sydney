//
//  CellForExistingProject.swift
//  Labour Hub Sydeny
//
//  Created by mac on 27/03/23.
//

import UIKit

class CellForExistingProject: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    var CloSeeDetails: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnSeeDetails(_ sender: UIButton) {
        self.CloSeeDetails?()
    }
}
