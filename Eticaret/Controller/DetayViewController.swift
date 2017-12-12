//
//  DetayViewController.swift
//  Eticaret
//
//  Created by MacMini on 8.12.2017.
//  Copyright © 2017 MacMini. All rights reserved.
//

import UIKit

class DetayViewController: UIViewController {

    @IBOutlet weak var baslikBtn: UIButton!
    @IBOutlet weak var indi: UIActivityIndicatorView!
    @IBOutlet weak var sideMenu: UIBarButtonItem!
    @IBOutlet weak var detayBaslik: UILabel!
    @IBOutlet weak var detay: UITextView!
    var sid=""
    var secilen_dil=""
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
       vericek(urlString: "https://ortakfikir.com/eticaret/sistem/API/webservices/android_services/service_app_20102017_versionv4_php/sayfa_detayi.php", secilen_dil: "tr", sid: sid)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func sideMenus()
    {
        if revealViewController() != nil
        {
            sideMenu.target = revealViewController()
            sideMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = self.view.frame.width - 50
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }
    func vericek(urlString:String,secilen_dil:String,sid:String)
    {
        let urlRequest = URL(string: urlString)
        var request = URLRequest(url: urlRequest! as URL)
        request.httpMethod = "POST"
        let parameters = "secilen_dil="+secilen_dil+"&sid="+sid
        
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil
            {
                print(error!)
            }
            else
            {
                do
                {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    DispatchQueue.main.async {
                        self.detayBaslik.text = " "+"\(String(describing: json!["baslik"] as! String))"
                        self.baslikBtn.setTitle(json!["baslik"] as? String, for: .normal)
                        self.setHTMLFromString(htmlText: (json!["icerik"] as? String)!)
                        
                    }
                  
                    
                }
                catch
                {
                    
                }
            }
        }
        task.resume()
    }
    func setHTMLFromString(htmlText: String) {
        let modifiedFont = NSString(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(14)\">%@</span>" as NSString, htmlText) as String
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        
        self.detay.attributedText = attrStr
        self.indi.stopAnimating()
    }


}
