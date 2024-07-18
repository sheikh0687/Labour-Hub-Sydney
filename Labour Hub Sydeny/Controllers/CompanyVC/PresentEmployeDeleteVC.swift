//
//  PresentEmployeDeleteVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 08/05/23.
//

import UIKit

class PresentEmployeDeleteVC: UIViewController {

    var cloCancel: (() -> Void)?
    var cloOk: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        self.cloCancel?()
    }
    
    @IBAction func btnOk(_ sender: UIButton) {
        self.cloOk?()
    }
}
