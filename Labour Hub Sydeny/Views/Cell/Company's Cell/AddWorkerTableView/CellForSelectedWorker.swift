//
//  CellForSelectedWorker.swift
//  Labour Hub Sydeny
//
//  Created by mac on 15/04/23.
//

import UIKit

class CellForSelectedWorker: UITableViewCell {

    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var btnMinusOt: UIButton!
    @IBOutlet weak var lblWorkerCount: UILabel!
    
    var cloMinus: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func btnMinus(_ sender: UIButton) {
        self.cloMinus?()
    }
}
