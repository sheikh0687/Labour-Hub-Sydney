//
//  CellForEmployee.swift
//  Labour Hub Sydeny
//
//  Created by mac on 27/03/23.
//

import UIKit

class CellForEmployee: UITableViewCell {

    @IBOutlet weak var lblEmpName: UILabel!
    @IBOutlet weak var lblEmpEmail: UILabel!
    @IBOutlet weak var imageOutlet: UIImageView!
    
    var cloTimesheet: (() -> Void)?
    var cloPresent: (() -> Void)?
    var cloDocument: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnDelete(_ sender: UIButton) {
        self.cloPresent?()
    }
    
    @IBAction func btnSeeTimesheet(_ sender: UIButton) {
        self.cloTimesheet?()
    }
    
    @IBAction func btnSeeDocument(_ sender: UIButton) {
        self.cloDocument?()
    }
}
