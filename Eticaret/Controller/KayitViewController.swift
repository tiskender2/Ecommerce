//
//  KayitViewController.swift
//  Eticaret
//
//  Created by MacMini on 7.12.2017.
//  Copyright © 2017 MacMini. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class KayitViewController: UIViewController,BEMCheckBoxDelegate{
    
    @IBOutlet weak var sideMenu: UIBarButtonItem!
    @IBOutlet weak var isimText: SkyFloatingLabelTextField!
    @IBOutlet weak var soyisimText: SkyFloatingLabelTextField!
    @IBOutlet weak var ePostaText: SkyFloatingLabelTextField!
    @IBOutlet weak var telefonText: SkyFloatingLabelTextField!
    @IBOutlet weak var dogumTarihiText: SkyFloatingLabelTextField!
    @IBOutlet weak var sifreText: SkyFloatingLabelTextField!
    @IBOutlet weak var kadınCheck: BEMCheckBox!
    @IBOutlet weak var erkekCheck: BEMCheckBox!
    @IBOutlet weak var kadınLabel: UILabel!
    @IBOutlet weak var erkekLabel: UILabel!
    @IBOutlet weak var kayıtOlBtn: UIButton!
    @IBOutlet weak var kadınView: UIView!
    @IBOutlet weak var erkekView: UIView!
    var radioGroup=[BEMCheckBox]()
    var uyeid:Int = 0
    let toolbar = UIToolbar()
    let datePicker = UIDatePicker()
    var cinsiyet:String=""
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        customize()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func dogumTarihi(_ sender: Any) {
        tarih()
    }
    func tarih()
    {
        datePicker.datePickerMode = .date
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Vazgeç", style: .plain, target: self, action:  #selector(self.doneButton))
        let bosluk = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let tamam = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action:  #selector(self.tamamButton))
        toolbar.setItems([tamam,bosluk,doneButton], animated: false)
        dogumTarihiText.inputAccessoryView = toolbar
        dogumTarihiText.inputView=datePicker
    }
    @objc func doneButton()
    {
       
        
     self.view.endEditing(true)
    }
    @objc func tamamButton()
    {
        let dateformat = DateFormatter()
        dateformat.dateStyle = .short
        dateformat.timeStyle = .none
        dogumTarihiText.text=dateformat.string(for: datePicker.date)
        self.view.endEditing(true)
    }
    func customize()
    {
        erkekView.layer.cornerRadius=5
        erkekView.layer.borderColor=UIColor.lightGray.cgColor
        erkekView.layer.borderWidth=0.5
        kadınView.layer.cornerRadius=5
        kadınView.layer.borderColor=UIColor.lightGray.cgColor
        kadınView.layer.borderWidth=0.5
        kayıtOlBtn.layer.cornerRadius=5
        kayıtOlBtn.layer.borderColor=UIColor.lightGray.cgColor
        kayıtOlBtn.layer.borderWidth=0.5
        kayıtOlBtn.layer.shadowOpacity = 0.2
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.erkekClick(sender:)))
        self.erkekView.addGestureRecognizer(gesture)
        let gesture2 = UITapGestureRecognizer(target: self, action:  #selector (self.kadınClick(sender:)))
        self.kadınView.addGestureRecognizer(gesture2)
        radioGroup.append(erkekCheck)
        radioGroup.append(kadınCheck)
        erkekCheck.onAnimationType = BEMAnimationType.fade
        erkekCheck.offAnimationType = BEMAnimationType.fade
        kadınCheck.onAnimationType = BEMAnimationType.fade
        kadınCheck.offAnimationType = BEMAnimationType.fade
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
     @objc func erkekClick(sender : UITapGestureRecognizer)
     {
        
        cinsiyet="e"
        kadınCheck.setOn(false, animated: true)
        erkekCheck.setOn(true, animated: true)
     }
     @objc func kadınClick(sender : UITapGestureRecognizer)
     {
        
        cinsiyet="k"
        erkekCheck.setOn(false, animated: true)
        kadınCheck.setOn(true, animated: true)
     }
    func didTap(_ checkBox: BEMCheckBox) {
        let currentTag = checkBox.tag
        if currentTag==1
        {
              cinsiyet="e"
        }
        else
        {
               cinsiyet="k"
        }
        for box in radioGroup where box.tag != currentTag {
            box.on = false
        }
    }
    @IBAction func kayitOlBtn(_ sender: Any)
    {
        
        kayitolJson(urlString:WebService.kayit_ol , isim: isimText.text!, soyisim:soyisimText.text! , ePosta: ePostaText.text!, Telefon: telefonText.text!, dTarihi: dogumTarihiText.text!, Cinsiyet: cinsiyet, Sifre: sifreText.text!)
       
    }
    func kayitolJson(urlString:String,isim:String,soyisim:String,ePosta:String,Telefon:String,dTarihi:String,Cinsiyet:String,Sifre:String)
    {
        let urlRequest = URL(string: urlString)
        var request = URLRequest(url: urlRequest! as URL)
        request.httpMethod = "POST"
        let parameters = "isim="+isim+"&soyisim="+soyisim+"&eposta="+ePosta+"&telefon="+Telefon+"&dogumtarihi="+dTarihi+"&cinsiyet="+Cinsiyet+"&sifre="+Sifre
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
                    
                    self.uyeid = json!["uye_id"] as! Int
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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == isimText || textField == soyisimText
        {
            let allowed =  CharacterSet.letters
            let characterset =  CharacterSet(charactersIn: string)
            return allowed.isSuperset(of: characterset)
        }
        else if textField == telefonText
        {
            let allowed =  CharacterSet.decimalDigits
            let characterset =  CharacterSet(charactersIn: string)
            return allowed.isSuperset(of: characterset)
        }
        else
        {
            return true
        }
    }
    
    
    
}
