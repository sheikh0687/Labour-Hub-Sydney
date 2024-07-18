//
//  CellForNewProject.swift
//  Labour Hub Sydeny
//
//  Created by mac on 27/03/23.
//

import UIKit

class CellForNewProject: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    
    var cloAccept: (() -> Void)?
    var cloReject: (() -> Void)?
    var cloCheck: (() -> Void)?
    var status = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnAccept(_ sender: UIButton) {
        self.cloAccept?()
        self.cloCheck?()
    }
    
    @IBAction func btnDecline(_ sender: UIButton) {
        self.cloReject?()
    }
}
