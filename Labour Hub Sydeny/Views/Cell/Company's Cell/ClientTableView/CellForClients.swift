//
//  CellForClients.swift
//  Labour Hub Sydeny
//
//  Created by mac on 27/03/23.
//

import UIKit

class CellForClients: UITableViewCell {

    @IBOutlet weak var lblClientName: UILabel!
    @IBOutlet weak var lblClientEmail: UILabel!
    @IBOutlet weak var imageOutlet: UIImageView!
    
    var cloPresent: (() -> Void)?
    var cloTimesheet: (() -> Void)?
    
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

}
