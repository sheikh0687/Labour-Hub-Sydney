//
//  EmployeDocumentDetailVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 05/05/23.
//

import UIKit
import WebKit

class EmployeDocumentDetailVC: UIViewController{

    @IBOutlet weak var viewOt: UIView!
    @IBOutlet weak var viewDocument: WKWebView!
    
    var webView : WKWebView!
    var pickedImage = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.pickedImage)
        viewDocument.load(URLRequest(url: URL(string: self.pickedImage)!))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension EmployeDocumentDetailVC: WKNavigationDelegate {
}
