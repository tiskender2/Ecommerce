//
//  MenuViewController.swift
//  Eticaret
//
//  Created by MacMini on 26.10.2017.
//  Copyright © 2017 MacMini. All rights reserved.
//

import UIKit

struct User {
    var uyeIsim:String=""
    var uyeEposta:String=""
    var kayitli_Adres:String=""
    var siparis_Toplami:String=""
    var basHarf:String=""
}
struct Tablo {
    var s_id=[String]()
    var baslik=[String]()
}
class MenuViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var clickView: UIView!
    @IBOutlet weak var kayitliAdres: UILabel!
    @IBOutlet weak var siparis: UILabel!
    @IBOutlet weak var imageIcon: UIButton!
    @IBOutlet weak var isimLabel: UILabel!
    @IBOutlet weak var epostaLabel: UILabel!
    @IBOutlet weak var submenuBtn: UIButton!
    @IBOutlet weak var siparisSorgula: UILabel!
    @IBOutlet weak var sepetim: UILabel!
    @IBOutlet weak var girişyapLogin: UILabel!
    @IBOutlet weak var girisyapBtn: UIButton!
    @IBOutlet weak var uyeOl: UIButton!
    @IBOutlet weak var adreslerBtn: UIButton!
    @IBOutlet weak var siparisBtn: UIButton!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var ayarlarBtn: UIButton!
    @IBOutlet weak var cikisBtn: UIButton!
    @IBOutlet weak var anasayfaBtn: UIButton!
    @IBOutlet weak var kategoriBtn: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var acılırview: UIView!
    @IBOutlet weak var tableView: UITableView!
    var icongonder = true
    var uyeid=0
    var user = User()
    var tablo = Tablo()

    override func viewDidLoad() {
        super.viewDidLoad()
        borderCustimize()
       
       
      
    }
    @IBAction func favorilerClick(_ sender: Any) {
        let revealViewController:SWRevealViewController = self.revealViewController()
        let mainStroyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desController = mainStroyBoard.instantiateViewController(withIdentifier: "FavorilerimViewController") as! FavorilerimViewController
        desController.uyeid=uyeid
        let newFrontViewController = UINavigationController.init(rootViewController:desController)
        revealViewController.pushFrontViewController(newFrontViewController, animated: true)
    }
    @IBAction func adreslerClick(_ sender: Any) {
        let revealViewController:SWRevealViewController = self.revealViewController()
        let mainStroyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desController = mainStroyBoard.instantiateViewController(withIdentifier: "AdreslerViewController") as! AdreslerViewController
        desController.uyeid=uyeid
        let newFrontViewController = UINavigationController.init(rootViewController:desController)
        revealViewController.pushFrontViewController(newFrontViewController, animated: true)
    }
    
    @IBAction func ayarlarClick(_ sender: Any) {
        let revealViewController:SWRevealViewController = self.revealViewController()
        let mainStroyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desController = mainStroyBoard.instantiateViewController(withIdentifier: "AyarlarViewController") as! AyarlarViewController
        desController.uyeid=uyeid
        let newFrontViewController = UINavigationController.init(rootViewController:desController)
        revealViewController.pushFrontViewController(newFrontViewController, animated: true)
    }
    
    @IBAction func anaSayfa(_ sender: Any) {
        let revealViewController:SWRevealViewController = self.revealViewController()
        let mainStroyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desController = mainStroyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let newFrontViewController = UINavigationController.init(rootViewController:desController)
        revealViewController.pushFrontViewController(newFrontViewController, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tablo.s_id.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuTableViewCell
        tableView.separatorColor=UIColor.clear
        cell.menuisimLabel.text!=self.tablo.baslik[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let revealViewController:SWRevealViewController = self.revealViewController()
        let mainStroyboard:UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        let desController = mainStroyboard.instantiateViewController(withIdentifier: "DetayViewController") as! DetayViewController
        desController.sid=tablo.s_id[indexPath.row]
        let newFrontViewController = UINavigationController.init(rootViewController: desController)
        revealViewController.pushFrontViewController(newFrontViewController, animated: true)
    }
    
    @IBAction func submenuAction(_ sender: Any) {
        
        if !icongonder
        {
            
            let firstView = stackView.arrangedSubviews[2]
            UIView.animate(withDuration: 0.5){
                firstView.isHidden = true
                self.submenuBtn.setImage(UIImage(named: "ikinci"), for: .normal)
        }
              icongonder = true
        }
        else
            {
         
                let firstView = self.stackView.arrangedSubviews[2]
            UIView.animate(withDuration: 0.5){
                firstView.isHidden = false
                let bottomborder = UIView(frame: CGRect(x: 1, y:self.acılırview.frame.size.height-1 , width: self.acılırview.frame.size.width, height: 0.5))
                bottomborder.backgroundColor=UIColor.lightGray
                self.acılırview.addSubview(bottomborder)
                   self.submenuBtn.setImage(UIImage(named: "ilk"), for: .normal)
        }
                icongonder = false
        
    }
    }
    
   
     
        
    @objc func siparisFunction(sender:UITapGestureRecognizer) {
        print("tap working")
    }
    @objc func kayitAdresFunction(sender:UITapGestureRecognizer) {
        print("tap working")
    }
    @objc func viewClick(sender:UITapGestureRecognizer) {
        if !icongonder
        {
            
            let firstView = stackView.arrangedSubviews[2]
            UIView.animate(withDuration: 0.5){
                firstView.isHidden = true
                self.submenuBtn.setImage(UIImage(named: "ikinci"), for: .normal)
            }
            icongonder = true
        }
        else
        {
            
            let firstView = self.stackView.arrangedSubviews[2]
            UIView.animate(withDuration: 0.5){
                firstView.isHidden = false
                let bottomborder = UIView(frame: CGRect(x: 1, y:self.acılırview.frame.size.height-1 , width: self.acılırview.frame.size.width, height: 0.5))
                bottomborder.backgroundColor=UIColor.lightGray
                self.acılırview.addSubview(bottomborder)
                self.submenuBtn.setImage(UIImage(named: "ilk"), for: .normal)
            }
            icongonder = false
            
        }
    }
    @IBAction func cıkısBtn(_ sender: Any) {
         UserDefaults.standard.removeObject(forKey: "uyeid")
        let firstView = stackView.arrangedSubviews[1]
        let firstView2 = stackView.arrangedSubviews[0]
        let firstView3 = stackView.arrangedSubviews[2]
        UIView.animate(withDuration: 0.5) {
            firstView.isHidden = false
            firstView2.isHidden = true
            firstView3.isHidden = true
        }
        
       
    }
    
    func borderCustimize()
    {
        
        imageIcon.layer.cornerRadius = 20
        imageIcon.clipsToBounds = true
        submenuBtn.setImage(UIImage(named: "arrow"), for: .normal)
        //siparis.isUserInteractionEnabled = true
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(MenuViewController.viewClick))
        clickView.addGestureRecognizer(tap2)
        let tap = UITapGestureRecognizer(target: self, action: #selector(MenuViewController.siparisFunction))
        siparis.isUserInteractionEnabled = true
        siparis.addGestureRecognizer(tap)
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(MenuViewController.kayitAdresFunction))
        kayitliAdres.isUserInteractionEnabled = true
        kayitliAdres.addGestureRecognizer(tap3)
        //ustLabel.backgroundColor = UIColor(patternImage: UIImage(named: "gradbg")!)
        let leftborder = UIView(frame: CGRect(x: 1, y: 0, width: 0.5, height: siparis.frame.size.height))
        leftborder.backgroundColor=UIColor.white
        siparis.addSubview(leftborder)
        let leftborder2 = UIView(frame: CGRect(x: 1, y: 0, width: 0.5, height: sepetim.frame.size.height+girişyapLogin.frame.size.height))
        leftborder2.backgroundColor=UIColor.white
        sepetim.addSubview(leftborder2)
        let bottomborder = UIView(frame: CGRect(x: 1, y:siparis.frame.size.height-1 , width: siparis.frame.size.width, height: 0.5))
        bottomborder.backgroundColor=UIColor.white
        siparis.addSubview(bottomborder)
        let bottomborder5 = UIView(frame: CGRect(x: 1, y:sepetim.frame.size.height-1 , width: sepetim.frame.size.width, height: 0.5))
        bottomborder5.backgroundColor=UIColor.white
        sepetim.addSubview(bottomborder5)
        let bottomborder4 = UIView(frame: CGRect(x: 1, y:siparisSorgula.frame.size.height-1 , width: siparisSorgula.frame.size.width, height: 0.5))
        bottomborder4.backgroundColor=UIColor.white
        siparisSorgula.addSubview(bottomborder4)
        let bottomborder3 = UIView(frame: CGRect(x: 1, y:self.kategoriBtn.frame.size.height-1 , width: self.stackView.frame.size.width, height: 0.5))
        bottomborder3.backgroundColor=UIColor.lightGray
        self.kategoriBtn.addSubview(bottomborder3)
        kategoriBtn.setTitle("    KATEGORİLER", for: .normal)
        let bottomborder2 = UIView(frame: CGRect(x: 1, y:kayitliAdres.frame.size.height-1 , width: kayitliAdres.frame.size.width, height: 0.5))
        bottomborder2.backgroundColor=UIColor.white
        kayitliAdres.addSubview(bottomborder2)
        adreslerBtn.contentHorizontalAlignment = .left
        siparisBtn.contentHorizontalAlignment = .left
        favBtn.contentHorizontalAlignment = .left
        ayarlarBtn.contentHorizontalAlignment = .left
        cikisBtn.contentHorizontalAlignment = .left
        anasayfaBtn.contentHorizontalAlignment = .left
        kategoriBtn.contentHorizontalAlignment = .left
        girisyapBtn.layer.cornerRadius = 3
        uyeOl.layer.cornerRadius = 3
        girisyapBtn.layer.borderWidth = 0.5
        girisyapBtn.layer.borderColor = UIColor.white.cgColor
        tabloDoldur(urlString: WebService.sayfaları_cek, secilen_dil: Dil.tr)
       
        if  UserDefaults.standard.object(forKey: "uyeid")  != nil
        {
            self.uyeid = UserDefaults.standard.object(forKey: "uyeid") as! Int
            let firstView = stackView.arrangedSubviews[1]
             firstView.isHidden = true
              uyebilgi(urlString: WebService.uye_bilgileri, uyeid: "\(uyeid)")
            
        }
        else
        {
            let firstView = stackView.arrangedSubviews[0]
            firstView.isHidden = true
        }
        
        self.submenuBtn.setImage(UIImage(named: "ikinci"), for: .normal)
       
        let secondView = stackView.arrangedSubviews[2]
        secondView.isHidden = true
    }

    @IBAction func girisYapBtn(_ sender: Any) {
        let revealViewController:SWRevealViewController = self.revealViewController()
        let mainStroyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desController = mainStroyBoard.instantiateViewController(withIdentifier: "GirisViewController") as! GirisViewController
        let newFrontViewController = UINavigationController.init(rootViewController:desController)
        revealViewController.pushFrontViewController(newFrontViewController, animated: true)
    }
    @IBAction func uyeolBtn(_ sender: Any) {
        let revealViewController:SWRevealViewController = self.revealViewController()
        let mainStroyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desController = mainStroyBoard.instantiateViewController(withIdentifier: "KayitViewController") as! KayitViewController
        let newFrontViewController = UINavigationController.init(rootViewController:desController)
        revealViewController.pushFrontViewController(newFrontViewController, animated: true)
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
                    if let uyeIsım = json!["isim"] as? String
                    {
                        self.user.uyeIsim=uyeIsım
                        DispatchQueue.main.async {
                            self.isimLabel.text=self.user.uyeIsim
                        }
                        
                    }
                    if let uyePosta = json!["eposta"] as? String
                    {
                        self.user.uyeEposta=uyePosta
                        DispatchQueue.main.async {
                            self.epostaLabel.text=self.user.uyeEposta
                        }
                       
                    }
                    if let kAdres = json!["kayitli_adres"] as? String
                    {
                        self.user.kayitli_Adres=kAdres
                        DispatchQueue.main.async {
                            self.kayitliAdres.numberOfLines = 0
                            self.kayitliAdres.text=self.user.kayitli_Adres+"\nKayitli Adres"
                        }
                    }
                    if let sToplam = json!["siparis_toplami"] as? String
                    {
                        self.user.siparis_Toplami=sToplam
                        DispatchQueue.main.async {
                            self.siparis.numberOfLines = 0
                            self.siparis.text=self.user.siparis_Toplami+"\nSipariş"
                        }
                    }
                    if let basharf = json!["basharf"] as? String
                    {
                        self.user.basHarf = basharf
                        DispatchQueue.main.async {
                            self.imageIcon.setTitle(self.user.basHarf, for: .normal)
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
    func tabloDoldur(urlString:String,secilen_dil:String)
    {
        self.tablo.s_id.removeAll()
        self.tablo.baslik.removeAll()
        let urlRequest = URL(string: urlString)
        var request = URLRequest(url: urlRequest! as URL)
        request.httpMethod = "POST"
        let parameters = "secilen_dil="+secilen_dil
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
                            if let sId = jsonVeri["s_id"] as? String
                            {
                                self.tablo.s_id.append(sId)
                            }
                            if let baslik = jsonVeri["baslik"] as? String
                            {
                                self.tablo.baslik.append(baslik)
                            }

                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
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

