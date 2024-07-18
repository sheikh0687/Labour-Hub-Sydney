//
//  E-SignatureVC.swift
//  Labour Hub Sydeny
//
//  Created by Techimmense Software Solutions on 20/06/23.
//

import UIKit

class E_SignatureVC: UIViewController {

    @IBOutlet weak var signatureView: YPDrawSignatureView!
    
    var cloSubmit:( (_ img : UIImage) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func btnClear(_ sender: UIButton) {
        signatureView.clear()
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        let image = signatureView.getSignature()
        print(image!)
        self.cloSubmit?(image!)
        self.dismiss(animated: true)
    }
}
