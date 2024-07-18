//
//  ReportDtCell.swift
//  Labour Hub Sydeny
//
//  Created by Techimmense Software Solutions on 19/05/23.
//

import UIKit

class ReportDtCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var lblOvertime: UILabel!
    @IBOutlet weak var lblTotalHours: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
