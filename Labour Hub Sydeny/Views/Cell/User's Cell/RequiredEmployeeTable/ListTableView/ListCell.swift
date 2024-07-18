//
//  ListCell.swift
//  Labour Hub Sydeny
//
//  Created by Techimmense Software Solutions on 30/05/23.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblEmpName: UILabel!
    @IBOutlet weak var lblEmpCate: UILabel!
    @IBOutlet weak var lblEmpEmail: UILabel!
    
    var cloRemove: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnRemove(_ sender: UIButton) {
        self.cloRemove?()
    }
}
