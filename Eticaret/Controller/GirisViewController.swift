//
//  GirisViewController.swift
//  Eticaret
//
//  Created by MacMini on 7.12.2017.
//  Copyright © 2017 MacMini. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class GirisViewController: UIViewController {

    @IBOutlet weak var sideMenu: UIBarButtonItem!
    @IBOutlet weak var girisBtn: UIButton!
    @IBOutlet weak var sifreUnuttumBtn: UIButton!
    @IBOutlet weak var eposta: SkyFloatingLabelTextField!
    @IBOutlet weak var sifre: SkyFloatingLabelTextField!
    var uyeid:Int=0
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        customize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func customize()
    {
        girisBtn.layer.cornerRadius = 5
        girisBtn.layer.borderColor=UIColor.lightGray.cgColor
        girisBtn.layer.borderWidth=0.5
        girisBtn.layer.shadowOpacity = 0.2
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
    
    @IBAction func girisBtnAction(_ sender: Any) {
        girisJson(urlString: "https://ortakfikir.com/eticaret/sistem/API/webservices/android_services/service_app_20102017_versionv4_php/giris_yap.php", ePosta: eposta.text!, Sifre: sifre.text!)
    }
    func girisJson(urlString:String,ePosta:String,Sifre:String)
    {
        let urlRequest = URL(string: urlString)
        var request = URLRequest(url: urlRequest! as URL)
        request.httpMethod = "POST"
        let parameters = "eposta="+ePosta+"&sifre="+Sifre
        
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
                    
                     self.uyeid = json!["uyeid"] as! Int
                    if let sonuc = json!["sonuc_kodu"] as? String
                    {
                        switch sonuc {
                        case "100":
                            DispatchQueue.main.async {
                                let alertView = UIAlertController(title: "Tebrikler!", message: json!["sonuc_mesaji"] as? String, preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default) {
                                    UIAlertAction in
                                    let next = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                                    next.loadView()
                                    let nesne:MenuViewController=next.rearViewController as! MenuViewController
                                    nesne.uyeid=self.uyeid
                                     UserDefaults.standard.set(self.uyeid,forKey:"uyeid")
                                    self.present(next, animated: true, completion: nil)

                                }
                                 alertView.addAction(okAction)
                                self.present(alertView, animated: true, completion: nil)
                               
                          
                                
                            }
                            break
                            
                        case "101":
                            DispatchQueue.main.async {
                                let alertView = UIAlertController(title: "Uyarı!", message: json!["sonuc_mesaji"] as? String, preferredStyle: .alert)
                                alertView.addAction(UIAlertAction(title: "Tamam", style:.default, handler: nil))
                                self.present(alertView, animated: true, completion: nil)
                                
                            }
                            break
                        case "102":
                            DispatchQueue.main.async {
                                let alertView = UIAlertController(title: "Uyarı!", message: json!["sonuc_mesaji"] as? String, preferredStyle: .alert)
                                alertView.addAction(UIAlertAction(title: "Tamam", style:.default, handler: nil))
                                self.present(alertView, animated: true, completion: nil)
                                
                            }
                            break
                        case "103":
                            DispatchQueue.main.async {
                                let alertView = UIAlertController(title: "Uyarı!", message: json!["sonuc_mesaji"] as? String, preferredStyle: .alert)
                                alertView.addAction(UIAlertAction(title: "Tamam", style:.default, handler: nil))
                                self.present(alertView, animated: true, completion: nil)
                                
                            }
                            break
                        case "104":
                            DispatchQueue.main.async {
                                let alertView = UIAlertController(title: "Uyarı!", message: json!["sonuc_mesaji"] as? String, preferredStyle: .alert)
                                alertView.addAction(UIAlertAction(title: "Tamam", style:.default, handler: nil))
                                self.present(alertView, animated: true, completion: nil)
                                
                            }
                            break
                        case "105":
                            DispatchQueue.main.async {
                                let alertView = UIAlertController(title: "Uyarı!", message: json!["sonuc_mesaji"] as? String, preferredStyle: .alert)
                                alertView.addAction(UIAlertAction(title: "Tamam", style:.default, handler: nil))
                                self.present(alertView, animated: true, completion: nil)
                                
                            }
                            break
                        default:
                            print( json!["sonuc_mesaji"] as! String)
                        }
                    }
                }
                catch
                {
                }
                
                }
        }
        task.resume()
    }
}
