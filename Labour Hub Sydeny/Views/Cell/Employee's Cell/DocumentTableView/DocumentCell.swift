//
//  DocumentCell.swift
//  Labour Hub Sydeny
//
//  Created by mac on 12/04/23.
//

import UIKit

class DocumentCell: UITableViewCell {

    @IBOutlet weak var lblDocName: UILabel!
    var cloViewDocument: (() -> Void)?
    var cloDeleteDoc: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnViewDocument(_ sender: UIButton) {
        self.cloViewDocument?()
    }
    
    @IBAction func btnDeleteDocument(_ sender: UIButton) {
        self.cloDeleteDoc?()
    }
    
}
