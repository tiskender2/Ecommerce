//
//  AyarlarViewController.swift
//  Eticaret
//
//  Created by MacMini on 12.12.2017.
//  Copyright © 2017 MacMini. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class AyarlarViewController: UIViewController ,BEMCheckBoxDelegate{

    @IBOutlet weak var isimText: SkyFloatingLabelTextField!
    
    @IBOutlet weak var kView: UIView!
    @IBOutlet weak var eVeiew: UIView!
    @IBOutlet weak var sideMenu: UIBarButtonItem!
    @IBOutlet weak var şifreGuncelle: UIButton!
    @IBOutlet weak var checkBox2: BEMCheckBox!
    @IBOutlet weak var checkBox: BEMCheckBox!
    @IBOutlet weak var yeniSifreTekarText: SkyFloatingLabelTextField!
    @IBOutlet weak var yeniSifreText: SkyFloatingLabelTextField!
    @IBOutlet weak var eskiSifreText: SkyFloatingLabelTextField!
    @IBOutlet weak var ayarlarBtn: UIButton!
    @IBOutlet weak var dTarihiText: SkyFloatingLabelTextField!
    @IBOutlet weak var telText: SkyFloatingLabelTextField!
    @IBOutlet weak var epostaTex: SkyFloatingLabelTextField!
    @IBOutlet weak var soyisimTexrt: SkyFloatingLabelTextField!
    var uyeid=0
    var dTarihi=""
    var datePicker = UIDatePicker()
    var toolbar = UIToolbar()
    var radio = [BEMCheckBox]()
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        uyebilgi(urlString: WebService.uye_bilgileri, uyeid: "\(uyeid)")
        customize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func dtarihiClicks(_ sender: Any) {
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
        dTarihiText.inputAccessoryView = toolbar
        dTarihiText.inputView=datePicker
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
        dTarihiText.text=dateformat.string(for: datePicker.date)
        self.view.endEditing(true)
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        let currentTag = checkBox.tag
        for box in radio where box.tag != currentTag {
            box.on = false
        }
        
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
    func uyebilgi(urlString:String,uyeid:String)
    {
        
        let urlRequest = URL(string: urlString)
        var request = URLRequest(url: urlRequest! as URL)
        request.httpMethod = "POST"
        let parameters = "uyeid="+uyeid
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
                    if let uyeIsım = json!["ad"] as? String
                    {
                        
                        DispatchQueue.main.async {
                            self.isimText.text=uyeIsım
                        }
                        
                    }
                    if let uyeSoyad = json!["soyad"] as? String
                    {
                        
                        DispatchQueue.main.async {
                            self.soyisimTexrt.text=uyeSoyad
                        }
                        
                    }
                    if let uyePosta = json!["eposta"] as? String
                    {
                        
                        DispatchQueue.main.async {
                            self.epostaTex.text=uyePosta
                        }
                        
                    }
                    if let uyeCep = json!["ceptelefonu"] as? String
                    {
                        
                        DispatchQueue.main.async {
                            self.telText.text=uyeCep
                        }
                        
                    }
                    if let uyeCep = json!["ceptelefonu"] as? String
                    {
                        
                        DispatchQueue.main.async {
                            self.telText.text=uyeCep
                        }
                        
                    }
                    if let dtarihi = json!["dogum_tarihi"] as? NSDictionary
                    {
                        if let ay = dtarihi["ay"] as? String
                        {
                            self.dTarihi=ay
                        }
                       if let gun = dtarihi["gun"] as? String
                        {
                            self.dTarihi="\(self.dTarihi)"+"/"+gun
                            
                        }
                        if let yıl = dtarihi["yil"] as? String
                        {
                            self.dTarihi="\(self.dTarihi)"+"/"+yıl
                            
                        }
                        DispatchQueue.main.async {
                            self.dTarihiText.text=self.dTarihi
                        }
                        
                    }
                    if let cinsiyet = json!["cinsiyet"] as? String
                    {
                       if cinsiyet == "e"
                       {
                        DispatchQueue.main.async {
                            self.checkBox.setOn(true, animated: false)
                        }
                        }
                        else
                       {
                        self.checkBox2.setOn(true, animated: false)
                        }
                        
                    }
                 
                    
                    
                }
                catch
                {
                    print(error)
                }
            }
        }
        task.resume()
    }
    func customize()
    {
        radio.append(checkBox)
        radio.append(checkBox2)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.clickeviewFunction))
        eVeiew.addGestureRecognizer(tap)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.clickekviewFunction))
        kView.addGestureRecognizer(tap2)
    }
    @objc func clickeviewFunction()
    {
        checkBox.setOn(true, animated: true)
        checkBox2.setOn(false, animated: false)
    }
    @objc func clickekviewFunction()
    {
        checkBox.setOn(false, animated: false)
        checkBox2.setOn(true, animated: true)
    }
   

}
