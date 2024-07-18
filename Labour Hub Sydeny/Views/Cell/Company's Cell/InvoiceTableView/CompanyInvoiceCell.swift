//
//  CompanyInvoiceCell.swift
//  Labour Hub Sydeny
//
//  Created by mac on 19/04/23.
//

import UIKit

class CompanyInvoiceCell: UITableViewCell {

    var cloDetails: (() -> Void)?
    @IBOutlet weak var lblInvoiceNo: UILabel!
    @IBOutlet weak var lblIssueDate: UILabel!
    @IBOutlet weak var lblProjectTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblUnitPrice: UILabel!
    @IBOutlet weak var lblRegularHours: UILabel!
    @IBOutlet weak var lblOvertime: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblGst: UILabel!
    @IBOutlet weak var lblTotalPay: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnVeiwDetails(_ sender: UIButton) {
        self.cloDetails?()
    }
}
