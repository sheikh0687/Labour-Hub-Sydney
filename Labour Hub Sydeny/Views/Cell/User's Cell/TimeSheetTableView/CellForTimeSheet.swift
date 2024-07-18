//
//  CellForTimeSheet.swift
//  Labour Hub Sydeny
//
//  Created by mac on 18/03/23.
//

import UIKit
import Alamofire

class CellForTimeSheet: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var lblOvertime: UILabel!
    @IBOutlet weak var lblLunchTime: UILabel!
    @IBOutlet weak var lblRegular: UILabel!
    @IBOutlet weak var lblEmployename: UILabel!
    @IBOutlet weak var lblSiteManager: UILabel!
    @IBOutlet weak var lblClientName: UILabel!
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var contentViewOt: UIView!
    @IBOutlet weak var btnHide: UIButton!
    @IBOutlet weak var btnApprove: UIButton!
    
    var cloDelete: (() -> Void)?
    var cloApprove: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func btnDelete(_ sender: UIButton)
    {
        self.cloDelete?()
    }
    
    
    @IBAction func btnApprove(_ sender: UIButton)
    {
        self.cloApprove?()
    }
    
    @IBAction func btnDownload(_ sender: UIButton) {
        guard let snapshot = contentViewOt.snapshotViewHierarchy() else {
            return
        }
        
        // save photo
        UIImageWriteToSavedPhotosAlbum(snapshot, nil, nil, nil)
        self.exportToPDF(snapshot)
    }
    
    func exportToPDF(_ uiImage:UIImage) {
        let outputFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("testing" + ".pdf")
        let pageSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size:  uiImage.size))
        DispatchQueue.main.async {
            do {
                let imageBounds = CGRect(origin: .zero, size: uiImage.size)
                try pdfRenderer.writePDF(to: outputFileURL, withActions: { (context) in
                    context.beginPage()
                    uiImage.draw(in: imageBounds)
                  
                })
                print("wrote file to: \(outputFileURL.path)")
                let documentoPath = outputFileURL.path
                let fileManager = FileManager.default
                if fileManager.fileExists(atPath: documentoPath){
                                let documento = NSData(contentsOfFile: documentoPath)
                                let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [documento!], applicationActivities: nil)
                    UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
                            }
                            else {
                                print("wrote file to: No Document \(outputFileURL.path)")
                            }
            } catch {
                print("Could not create PDF file: \(error.localizedDescription)")
            }
        }
    }
}
