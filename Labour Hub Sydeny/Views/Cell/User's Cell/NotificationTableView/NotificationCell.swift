//
//  NotificationCell.swift
//  Labour Hub Sydeny
//
//  Created by mac on 08/04/23.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var lblRequest: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSender: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
