//
//  AdresViewController.swift
//  Eticaret
//
//  Created by MacMini on 29.11.2017.
//  Copyright © 2017 MacMini. All rights reserved.
//

import UIKit

class AdresViewController: UIViewController,BEMCheckBoxDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate{
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var sepetButton: UIButton!
    @IBOutlet weak var adresButton: UIButton!
    @IBOutlet weak var odemeButton: UIButton!
    @IBOutlet weak var siparisButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var faturaView: UIView!
    @IBOutlet weak var tıklaView: UIView!
    @IBOutlet weak var check: BEMCheckBox!
    @IBOutlet weak var isimText: UITextField!
    @IBOutlet weak var telefonText: UITextField!
    @IBOutlet weak var epostaText: UITextField!
    @IBOutlet weak var ilButton: UIButton!
    @IBOutlet weak var ilceButton: UIButton!
    @IBOutlet weak var postakoduText: UITextField!
    @IBOutlet weak var detaylıAdresText: UITextField!
    @IBOutlet weak var fisimText: UITextField!
    @IBOutlet weak var ftelText: UITextField!
    @IBOutlet weak var fepostaText: UITextField!
    @IBOutlet weak var filText: UIButton!
    @IBOutlet weak var filçeText: UIButton!
    @IBOutlet weak var fpostaKoduText: UITextField!
    @IBOutlet weak var fDetaylıAdresText: UITextField!
     let toolbar = UIToolbar()
    let pickerView = UIPickerView()
    var ilDizi=[String]()
    var ilIds=[String]()
    var ilId = ""
    var ilceBaslık=[String]()
    var ilceIds=[String]()
    var kontrol = 0
    @IBOutlet weak var olusturButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barCustomize()
        sideMenus()
        
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if kontrol == 1
        {
            return ilDizi.count
        }
        else if kontrol == 2
        {
            return ilceBaslık.count
        }
        else if kontrol == 3
        {
            return ilDizi.count
        }
        else
        {
            return ilceBaslık.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if kontrol == 1
        {
        return ilDizi[row]
        }
        else if kontrol == 2
        {
            return ilceBaslık[row]
        }
        else if kontrol == 3
        {
            return ilDizi[row]
        }
        else
        {
            return ilceBaslık[row]
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if kontrol == 1
        {
            ilButton.setTitle(" \(ilDizi[row])", for: .normal)
            ilId=ilIds[row]
        }
        else  if kontrol == 2
        {
            ilceButton.setTitle(" \(ilceBaslık[row])", for: .normal)
            ilId=ilIds[row]
        }
        else  if kontrol == 3
        {
            filText.setTitle(" \(ilDizi[row])", for: .normal)
            ilId=ilIds[row]
        }
        else
        {
            filçeText.setTitle(" \(ilceBaslık[row])", for: .normal)
            ilId=ilIds[row]
        }
       
        
    }
    override func viewDidAppear(_ animated: Bool) {
      /*  isimText.borderStyle = UITextBorderStyle.roundedRect
        telefonText.borderStyle = UITextBorderStyle.roundedRect
        epostaText.borderStyle = UITextBorderStyle.roundedRect
        postakoduText.borderStyle = UITextBorderStyle.roundedRect
        detaylıAdresText.borderStyle = UITextBorderStyle.roundedRect
        fisimText.borderStyle = UITextBorderStyle.roundedRect
        ftelText.borderStyle = UITextBorderStyle.roundedRect
        fepostaText.borderStyle = UITextBorderStyle.roundedRect
        fpostaKoduText.borderStyle = UITextBorderStyle.roundedRect
        fDetaylıAdresText.borderStyle = UITextBorderStyle.roundedRect*/
        
    }
    func didTap(_ checkBox: BEMCheckBox) {
        let firstView = stackView.arrangedSubviews[1]
        
        if check.on == true
        {
           
            UIView.animate(withDuration: 0.5, animations: {
                firstView.isHidden = true
            })
            
            
        }
        else
        {
            
            UIView.animate(withDuration: 0.5, animations: {
                firstView.isHidden = false
            })
          
        }
    }
    
    func barCustomize()
    {
        check.delegate=self
        pickerView.delegate=self
        pickerView.dataSource=self
        check.boxType=BEMBoxType.square
        
        ilButton.contentHorizontalAlignment = .left
        ilceButton.contentHorizontalAlignment = .left
        filText.contentHorizontalAlignment = .left
        filçeText.contentHorizontalAlignment = .left
        ilceButton.setTitle("-İlçe Seç-", for: .normal)
        ilButton.setTitle("-İl Seç-", for: .normal)
        filText.setTitle("-İl Seç-", for: .normal)
        filçeText.setTitle("-İlçe Seç-", for: .normal)
        filçeText.layer.cornerRadius = 5
        filçeText.layer.borderColor=UIColor.lightGray.cgColor
        filçeText.layer.borderWidth = 0.3
        filText.layer.cornerRadius = 5
        filText.layer.borderColor=UIColor.lightGray.cgColor
        filText.layer.borderWidth = 0.3
        ilButton.layer.cornerRadius = 5
        ilButton.layer.borderColor=UIColor.lightGray.cgColor
        ilButton.layer.borderWidth = 0.3
        ilceButton.layer.cornerRadius = 5
        ilceButton.layer.borderColor=UIColor.lightGray.cgColor
        ilceButton.layer.borderWidth = 0.3
        sepetButton.layer.cornerRadius=14
        adresButton.layer.cornerRadius=14
        odemeButton.layer.cornerRadius=14
        siparisButton.layer.cornerRadius=14
        tıklaView.layer.cornerRadius = 3
        tıklaView.layer.borderWidth = 0.3
        tıklaView.layer.borderColor = UIColor.lightGray.cgColor
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AdresViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.checkAction(sender:)))
        self.tıklaView.addGestureRecognizer(gesture)
      
    }
   
    @objc func checkAction(sender : UITapGestureRecognizer) {
        let firstView = stackView.arrangedSubviews[1]
        
        if check.on == true
        {
            check.on = false
            UIView.animate(withDuration: 0.5, animations: {
                firstView.isHidden = false
            })
            
        }
        else
        {
            check.on = true
            UIView.animate(withDuration: 0.5, animations: {
                firstView.isHidden = true
            })
        }
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @IBAction func ilClick(_ sender: Any) {
        kontrol = 1
        ilListele(urlString: "https://ortakfikir.com/eticaret/sistem/API/webservices/android_services/service_app_20102017_versionv4_php/il_listesi.php")
        popUpPicker()
        /*if let viewWithTag = self.view.viewWithTag(1) {
            viewWithTag.removeFromSuperview()
        }*/
        
      
    }
    @IBAction func ilceClick(_ sender: Any) {
        if ilButton.currentTitle! != "-İl Seç-"
        {
            kontrol = 2
            ilçeListele(urlString:"https://ortakfikir.com/eticaret/sistem/API/webservices/android_services/service_app_20102017_versionv4_php/ilce_listesi.php",ilid:ilId)
            
            popUpPicker()
        }
        else
        {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Uyarı!", message:  "Lütfen İl Seçiniz", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Tamam", style:.default, handler: nil))
                self.present(alertView, animated: true, completion: nil)
                
            }
        }
        
    }
    @IBAction func filClick(_ sender: Any) {
        
            kontrol = 3
            ilListele(urlString: "https://ortakfikir.com/eticaret/sistem/API/webservices/android_services/service_app_20102017_versionv4_php/il_listesi.php")
            popUpPicker()
        
    }
   
    @IBAction func filceClick(_ sender: Any) {
        if filText.currentTitle! != "-İl Seç-"
        {
            kontrol = 4
            ilçeListele(urlString:"https://ortakfikir.com/eticaret/sistem/API/webservices/android_services/service_app_20102017_versionv4_php/ilce_listesi.php",ilid:ilId)
            
            popUpPicker()
        }
        else
        {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Uyarı!", message: "Lütfen İl Seçiniz", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Tamam", style:.default, handler: nil))
                self.present(alertView, animated: true, completion: nil)
                
            }
        }
    }
    
    
    @objc func doneButton()
    {
        if kontrol == 1
        {
             ilButton.setTitle("-İl Seç-", for: .normal)
        }
        else  if kontrol == 2
        {
             ilceButton.setTitle("-İlçe Seç-", for: .normal)
        }
        else  if kontrol == 3
        {
            filText.setTitle("-İl Seç-", for: .normal)
        }
        else
        {
            filçeText.setTitle("-İlçe Seç-", for: .normal)
        }
        
       
        view.endEditing(true)
    }
    @objc func tamamButton()
    {
        view.endEditing(true)
    }
    func popUpPicker()
    {
        let sampleTextField =  UITextField(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        view.addSubview(sampleTextField)
        
        sampleTextField.tag = 1
        sampleTextField.inputView = pickerView
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Vazgeç", style: .plain, target: self, action:  #selector(AdresViewController.doneButton))
        let bosluk = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let tamam = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action:  #selector(AdresViewController.tamamButton))
        toolbar.setItems([tamam,bosluk,doneButton], animated: false)
        sampleTextField.inputAccessoryView = toolbar
        sampleTextField.becomeFirstResponder()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == isimText || textField == fisimText
        {
            let allowed =  CharacterSet.letters
            let characterset =  CharacterSet(charactersIn: string)
            return allowed.isSuperset(of: characterset)
        }
        else if textField == telefonText || textField == ftelText || textField == fpostaKoduText || textField == postakoduText
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
    
    func sideMenus()
    {
        if revealViewController() != nil
        {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = self.view.frame.width - 50
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }
    func ilListele(urlString:String)
    {
        ilDizi.removeAll()
        ilIds.removeAll()
        let urlRequest = URL(string: urlString)
        var request = URLRequest(url: urlRequest! as URL)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil
            {
                print(error!)
            }
            else
            {
                do
                {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSArray
                    for i in 0..<json!.count
                    {
                        if let jsonVeri = json![i] as? NSDictionary
                        {
                            if let il = jsonVeri["baslik"] as? String
                            {
                                self.ilDizi.append(il)
                                
                            }
                            if let id = jsonVeri["id"] as? String
                            {
                                self.ilIds.append(id)
                                
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.pickerView.reloadAllComponents()
                        
                    }
                    
                    
                }
                catch
                {
                    
                }
            }
        }
        task.resume()
    }
    func ilçeListele(urlString:String,ilid:String)
    {
        ilceBaslık.removeAll()
        ilceIds.removeAll()
        let urlRequest = URL(string: urlString)
        var request = URLRequest(url: urlRequest! as URL)
        request.httpMethod = "POST"
        let parameters = "ilid="+ilid
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
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSArray
                    for i in 0..<json!.count
                    {
                        if let jsonVeri = json![i] as? NSDictionary
                        {
                            if let ilçe = jsonVeri["baslik"] as? String
                            {
                                self.ilceBaslık.append(ilçe)
                                
                            }
                            if let ilçeid = jsonVeri["id"] as? String
                            {
                                self.ilceIds.append(ilçeid)
                                
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.pickerView.reloadAllComponents()
                        
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
