//
//  UrunDetayViewController.swift
//  Eticaret
//
//  Created by MacMini on 31.10.2017.
//  Copyright © 2017 MacMini. All rights reserved.
//

import UIKit
import SDWebImage
class UrunDetayViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BEMCheckBoxDelegate{
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var enDisStack: UIStackView!
    @IBOutlet weak var sVHeight: NSLayoutConstraint!
    @IBOutlet weak var indiSecenek: UIActivityIndicatorView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var urunIsım: UILabel!
    @IBOutlet weak var urunTip: UILabel!
    @IBOutlet weak var urunFiyatı: UILabel!
    @IBOutlet weak var urunAcıklama: UITextView!
    var vids=[String]()
    var vidResim=[String]()
    var baslik=[String]()
    var fiyat=[String]()
    var indirimliFiyat=[String]()
    var secim=[String]()
    var urunResimler=[String]()
    var varyant_key=[String]()
    var varyant_tur=[String]()
    var varyantBaslik=[String]()
    var varyantId=[String]()
    var ozellikId=[String]()
    var ozellikBaslık=[String]()
    var ozellikStok=[String]()
    var secim4_id=""
    var urunSayıları=""
    var maxStok:String=""
    var secilenStok:String=""
    var stokAcıklama:String=""
    var urunBilgi=[String]()
    var secilmis=""
    var cons = CGFloat()
    var array=[Array<String>]()
    var dizi = [String]()
    var dizitur=[String]()
    var ids = ""
    var radiobutton=[Array<UIButton>]()
    var selectedIndex = IndexPath()
    var radioControl=""
    var varyantlar=[String]()
    var varyantlar2=[String]()
    var varyants=""
    var varyants2=""
    var gidenVaryantlar=""
    @IBOutlet weak var sideMenu: UIBarButtonItem!
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var adetSayi: UILabel!
    @IBOutlet weak var arttırBtn: UIButton!
    @IBOutlet weak var azaltBtn: UIButton!
    @IBOutlet weak var adetView: UIView!
    @IBOutlet weak var urunHakkindaView: UIView!
    @IBOutlet weak var urunlerCw: UICollectionView!
    @IBOutlet weak var urunResimCw: UICollectionView!
    var aralık = 30
    var genislik = 0
    var scrollgenislik=0
    var tur=""
    var stackViewSize = CGFloat()
    var vid = ""
    var count = 1
    let scrollView = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        urunDetayCustomize()
        urunDetayDatas(urlString: WebService.urun_detay ,vid:vid,dil: Dil.tr)
      /* let firstView = enDisStack.arrangedSubviews[0]
        UIView.animate(withDuration: 0.5){
            firstView.isHidden = true
 
        }*/
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    @IBAction func sepeteEkle(_ sender: Any) {
        for i in varyantlar2
        {
            if i != ""
            {
                if count == 1
                {
                    gidenVaryantlar=i
                    
                }
                if count != 1
                {
                    gidenVaryantlar=gidenVaryantlar+"&"+i
                }
                count=0
            }
        }
        if adetSayi.text != "0"
        {
            sepeteEkle(urlString: WebService.sepete_ekle, adet: adetSayi.text! , vid: vid, anonimId: globals.anonim_id, varyants: gidenVaryantlar)
            let nesne = self.storyboard?.instantiateViewController(withIdentifier: "SepetimViewController") as! SepetimViewController
            self.navigationController?.pushViewController(nesne, animated: true)
        }
        else
        {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Uyari!", message: "Adet sayısı 0 olamaz", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
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
    
    @IBAction func azaltBtnAction(_ sender: Any) {
        if adetSayi.text == "1"
        {
            if adetSayi.text != "1"
            {
                adetSayi.text = String(Int(adetSayi.text!)! - 1)
                secilenStok=adetSayi.text!
            }
        }
        else
        {
        if adetSayi.text != "0"
        {
            adetSayi.text = String(Int(adetSayi.text!)! - 1)
            secilenStok=adetSayi.text!
        }
        }
    }
    @IBAction func arttırBtnAction(_ sender: Any) {
        for i in varyant_tur
        {
           if i == "radio"
           {
            radioControl=i
            break
            }
        }
        if radioControl == "radio"
        {
            if maxStok=="0"
            {
                adetSayi.text="0"
                let alert = UIAlertController(title: "Uyari!", message: stokAcıklama, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                if adetSayi.text == maxStok
                {
                    adetSayi.text = maxStok
                }
                else
                {
                    adetSayi.text = String(Int(adetSayi.text!)! + 1)
                    secilenStok=adetSayi.text!
                }
            }
        }
        else
        {
            if adetSayi.text == maxStok
            {
                adetSayi.text = maxStok
            }
            else
            {
                adetSayi.text = String(Int(adetSayi.text!)! + 1)
                secilenStok=adetSayi.text!
            }
        }

       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.urunResimCw {
            return urunResimler.count
        }
        else
        {
            return vidResim.count
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if collectionView == self.urunResimCw {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UrunDetayCollectionViewCell
            cell.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 4
            cell.urunDetayResim.sd_setImage(with: URL(string: urunResimler[indexPath.row]))
            indicator.stopAnimating()
             return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UrunDetayCollectionViewCell
            if indexPath == selectedIndex
            {
                let cell = collectionView.cellForItem(at: indexPath)
                cell?.layer.borderWidth = 1
                cell?.layer.borderColor = UIColor.green.cgColor
                cell?.layer.cornerRadius = 4
            }
            else
            {
            cell.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 4
            }
            cell.urunlerResim.sd_setImage(with: URL(string: vidResim[indexPath.row]))
            cell.urunlerFiyat.text = indirimliFiyat[indexPath.row]
            cell.urunlerIsim.text = baslik[indexPath.row]
            
             return cell
            
        }
    
      
       
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
     
        if collectionView == self.urunResimCw
        {
            let width = urunResimCw.frame.size.width
            let height = urunResimCw.frame.size.height
           
            return CGSize(width: width, height: height)
        }
        else if collectionView == self.urunlerCw
        {
            let width = urunlerCw.frame.size.width/2
            let height = urunlerCw.frame.size.height
           
            return CGSize(width: width, height: height)
        }
     
        else
        {
            let size = UICollectionViewFlowLayout()
            let size2 = size.itemSize
            let height = urunlerCw.frame.size.height
            let witdh =  size2.width
            return CGSize(width: witdh , height:height)
           
          
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.urunlerCw
        {
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.layer.borderWidth = 1
            cell?.layer.borderColor = UIColor.green.cgColor
            cell?.layer.cornerRadius = 4
            vid=vids[indexPath.row]
            selectedIndex = indexPath
            seceneklerCustomize()
            urunDetayDatas(urlString: WebService.urun_detay,vid:vids[indexPath.row], dil: Dil.tr)
        }
    }
   func urunDetayCustomize()
    {
        stackViewSize=stackView.frame.size.height
        let size = UICollectionViewFlowLayout()
        size.minimumLineSpacing = 2
        size.scrollDirection = .horizontal
        urunlerCw.collectionViewLayout = size
        adetView.layer.borderColor = UIColor.lightGray.cgColor
        adetView.layer.borderWidth = 1
        adetView.layer.cornerRadius = 4
        azaltBtn.layer.borderWidth = 1
        azaltBtn.layer.borderColor = UIColor.lightGray.cgColor
        arttırBtn.layer.borderWidth = 1
        arttırBtn.layer.borderColor = UIColor.lightGray.cgColor
        adetSayi.layer.borderWidth = 1
        adetSayi.layer.borderColor = UIColor.lightGray.cgColor
        urunHakkindaView.layer.borderWidth = 1
        urunHakkindaView.layer.borderColor = UIColor.lightGray.cgColor
        urunHakkindaView.layer.cornerRadius = 4
        btnFav.layer.borderWidth = 1
        btnFav.layer.borderColor = UIColor(red: 147/255, green: 3/255, blue: 6/255, alpha: 1).cgColor
        btnFav.layer.cornerRadius = 28
        scrollView.frame = self.view.bounds
        scrollView.contentSize=CGSize(width: stackView.frame.size.width, height: stackView.frame.size.height)
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 3
        scrollView.delegate = self
    
    }
    func urunDetayDatas(urlString:String,vid:String,dil:String)
    {
        self.urunBilgi.removeAll()
        self.urunResimler.removeAll()
        self.vids.removeAll()
        self.vidResim.removeAll()
        self.baslik.removeAll()
        self.fiyat.removeAll()
        self.indirimliFiyat.removeAll()
        self.secim.removeAll()
        self.varyant_tur.removeAll()
        self.varyant_key.removeAll()
        self.varyantBaslik.removeAll()
    
        let urlRequest = URL(string: urlString)
        var request = URLRequest(url: urlRequest! as URL)
        request.httpMethod = "POST"
        let parameters = "vid="+vid+"&secilen_dil="+dil
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if error != nil
            {
                print(error!)
            }
            else
            {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    if let vid = json!["vid"] as? String
                    {
                        self.urunBilgi.append(vid)
                    }
                    if let ubaslik = json!["ubaslik"] as? String
                    {
                        DispatchQueue.main.async {
                            self.urunIsım.text=ubaslik
                        }
                        
                    }
                    if let vbaslik = json!["vbaslik"] as? String
                    {
                        DispatchQueue.main.async {
                            self.urunTip.text=vbaslik
                        }

                    }
                    if let fiyat = json!["fiyat"] as? String
                    {
                       self.urunBilgi.append(fiyat)
                    }
                    if let ifiyat = json!["indirimlifiyat"] as? String
                    {
                        
                        DispatchQueue.main.async {
                            self.urunFiyatı.text=ifiyat
                        }
                    }
                    if let uicerik = json!["uicerik"] as? String
                    {
                      DispatchQueue.main.async {
                        self.setHTMLFromString(htmlText: uicerik)
                        }
                    }
                    if let stoksayisi = json!["stok_sayisi"] as? Int
                    {
                        self.maxStok=String(stoksayisi)
                    }
                    
                    if let stokacıklama = json!["stok_aciklamasi"] as? String
                    {
                        self.stokAcıklama=stokacıklama
                    }
                    
                    self.urunResimler.removeAll()
                    if let resimler = json!["resimler"] as! NSArray?
                    {
                        for i in 0..<resimler.count
                        {
                            let resim = resimler[i] as! String
                            self.urunResimler.append(resim)
                            
                            
                        }
                 
                    }
                    if let dVaryants = json!["diger_varyantlar"] as?  NSArray
                    {
                        for i in 0..<dVaryants.count
                        {
                            if let jsonVeri = dVaryants[i] as? NSDictionary
                            {
                                if let vid = jsonVeri["vid"] as? String
                                {
                                    self.vids.append(vid)
                                    
                                }
                                if let resims = jsonVeri["resim"] as? String
                                {
                                    self.vidResim.append(resims)
                                    
                                }
                                if let basliks = jsonVeri["baslik"] as? String
                                {
                                    
                                    self.baslik.append(basliks)
                                    
                                    
                                }
                                if let fiyats = jsonVeri["fiyat"] as? String
                                {
                                    self.fiyat.append(fiyats)
                                    
                                }
                                if let ifiyats = jsonVeri["indirimlifiyat"] as? String
                                {
                                    self.indirimliFiyat.append(ifiyats)
                                    
                                }
                                if let secims = jsonVeri["secim"] as? String
                                {
                                    self.secim.append(secims)
                                    
                                }
                            }
                            
                        }
                      
                    }
                    if let varyants = json!["varyants"] as?  NSArray
                    {
                        for k in 0..<varyants.count
                        {
                            self.dizi.append("")
                            if let jsonVeri = varyants[k] as? NSDictionary
                            {
                                if let varkey = jsonVeri["varyant_key"] as? String
                                {
                                    self.varyant_key.append(varkey)
                                    
                                }
                                if let tur = jsonVeri["tur"] as? String
                                {
                                    self.varyant_tur.append(tur)
                                    
                                }
                                if let vbasliks = jsonVeri["baslik"] as? String
                                {
                                    self.varyantBaslik.append(vbasliks)
                                }
                             
                                if let secim_id = jsonVeri["secim_id"] as? String
                                {
                                    self.secim4_id=secim_id
                                }
                                if let secilmis = jsonVeri["secim"] as? String
                                {
                                   self.secilmis=secilmis
                                }
                               
                               
                                if let secims = jsonVeri["secimler"] as? NSArray
                                {
                                    
                                    for j in 0..<secims.count
                                    {
                                      
                                        if let jsonVeri = secims[j] as? NSDictionary
                                        {
                                            
                                            if let ids = jsonVeri["id"] as? String
                                            {
                                                self.ozellikId.append(ids)
                                            }
                                            if let secimlerbaslik = jsonVeri["baslik"] as? String
                                            {
                                                
                                                self.ozellikBaslık.append(secimlerbaslik)
                                            }
                                            if let stoks = jsonVeri["stok"] as? String
                                            {
                                                
                                                self.ozellikStok.append(stoks)
                                            }
                                            

                                        }
                                      
                                    }
                                    
                                   
                                }
                                DispatchQueue.main.sync {
                                    self.urunlers(i: k, secimler: self.ozellikBaslık, ozellik: self.varyantBaslik[k],tur:self.varyant_tur[k],secim:self.secilmis,tag:self.ozellikId,constra: varyants.count, stok:self.ozellikStok)
                                        self.indiSecenek.stopAnimating()
                                        self.ozellikId.removeAll()
                                        self.ozellikBaslık.removeAll()
                                        self.ozellikStok.removeAll()
                                }
                          
                            }
                            
                        }
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.urunResimCw.reloadData()
                        self.urunlerCw.reloadData()
                       
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
    func setHTMLFromString(htmlText: String) {
        let modifiedFont = NSString(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(18)\">%@</span>" as NSString, htmlText) as String
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        self.urunAcıklama.attributedText = attrStr
    }
    func urunlers(i:Int,secimler:Array<String>,ozellik:String,tur:String,secim:String,tag:Array<String>,constra:Int,stok:Array<String>)
    {
            array.append(secimler)
            varyantlar.append("varyant\(i+1)")
            varyantlar2.append("")
            let frame3 = CGRect(x:0, y:i * 60, width: Int(stackView.frame.size.width), height: 30 )
            let label = UILabel(frame: frame3)
            label.text=ozellik
            label.textColor = UIColor.gray
            cons += label.frame.size.height
            scrollView.addSubview(label)
            var radios = [UIButton]()
            if tur != "text"
            {
                let frame2 = CGRect(x:0, y:aralık, width: Int(stackView.frame.size.width), height: 40 )
                let scrollView2 = UIScrollView(frame: frame2)
                scrollView2.minimumZoomScale = 0.1
                scrollView2.maximumZoomScale = 3
                scrollView2.delegate = self
                cons += scrollView2.frame.size.height
                
                for index in 0..<secimler.count
                {
                    let frame1 = CGRect(x:genislik, y:0, width: 80, height: 30 )
                    let button = UIButton(frame: frame1)
                    button.setTitle(secimler[index], for: .normal)
                    button.sendActions(for: .touchUpInside)
                    button.accessibilityHint=tag[index]
                    
                    if tur == "radio"
                    {
                        button.accessibilityLabel=stok[index]
                    }
                    button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                    button.tag = i
                    button.setTitleColor(UIColor.darkGray, for: .normal)
                    button.backgroundColor = UIColor.white
                    button.layer.borderWidth=1
                    button.layer.borderColor=UIColor.lightGray.cgColor
                    button.layer.cornerRadius=5
                    button.sizeToFit()
                    button.layoutIfNeeded()
                    genislik += Int(button.frame.size.width)+10
                    scrollgenislik = genislik
                    scrollView2.reloadInputViews()
                    scrollView2.addSubview(button)
                    scrollView2.contentSize.width = CGFloat(scrollgenislik)
                    if tur == "radio" || tur == "select"
                    {
                        radios.append(button)
                    }
                }
                self.scrollView.addSubview(scrollView2)
            }
            else
            {
                let frame5 = CGRect(x:0, y:aralık, width: Int(stackView.frame.size.width), height: 20 )
                let label2 = UILabel(frame: frame5)
                label2.text = secim
                varyantlar2[i]=varyantlar[i]+"="+secim4_id
                label2.textColor = UIColor.gray
                cons += label2.frame.size.height
                scrollView.addSubview(label2)
                
            }
            radiobutton.append(radios)
            genislik = 0
            scrollView.contentSize.height = CGFloat(cons-20)
            scrollgenislik=0
            aralık = aralık+60
            if constra <= 4
            {
                sVHeight.constant=cons
            }
            else
            {
                sVHeight.constant=stackViewSize
            }
            stackView.addArrangedSubview(scrollView)
        
    }
    @objc func buttonAction(sender: UIButton!) {
    
        /*print(varyantlar)
        print(varyantlar[sender.tag])
        print(sender.accessibilityHint!)*/
        
        if varyant_tur[sender.tag] == "checkbox"
        {
            if ids.range(of:sender.accessibilityHint!+",") != nil {
                let a = sender.accessibilityHint!+","
                ids = ids.replacingOccurrences(of: a, with: "")
                dizi[sender.tag] = ids
                if ids != ""
                {
                    varyantlar2[sender.tag]=varyantlar[sender.tag]+"="+ids
                }
                else
                {
                    varyantlar2[sender.tag]=""
                }
                
                
                
            }
            else
            {
                ids = dizi[sender.tag]+sender.accessibilityHint!+","
                dizi[sender.tag] = ids
                
                varyantlar2[sender.tag]=varyantlar[sender.tag]+"="+ids
             
            }
            if sender.layer.borderColor==UIColor.lightGray.cgColor
            {
                   sender.layer.borderColor=UIColor.black.cgColor
            }
            else
            {
                    sender.layer.borderColor=UIColor.lightGray.cgColor
            }
        
           
        }
        else if  varyant_tur[sender.tag] == "radio" || varyant_tur[sender.tag] == "select"
        {
            varyantlar2[sender.tag]=varyantlar[sender.tag]+"="+sender.accessibilityHint!
            if  varyant_tur[sender.tag] == "radio"
            {
                maxStok = sender.accessibilityLabel!
                adetSayi.text = "1"
            }
         
            dizi[sender.tag] = sender.accessibilityHint!
        
            for i in radiobutton[sender.tag]
            {
                i.setTitleColor(UIColor.darkGray, for: .normal)
                i.backgroundColor = UIColor.white
            }
            if  sender.backgroundColor == UIColor.white{
                
                sender.setTitleColor(UIColor.white, for: .normal)
                sender.backgroundColor=UIColor.black
                
            } else{
                
                sender.setTitleColor(UIColor.darkGray, for: .normal)
                sender.backgroundColor = UIColor.white
            }
        }
      print(varyantlar2)

    }
    func sepeteEkle(urlString:String,adet:String,vid:String,anonimId:String,varyants:String)
    {
        let urlRequest = URL(string: urlString)
        var request = URLRequest(url: urlRequest! as URL)
        request.httpMethod = "POST"
        let parameters = "adet="+adet+"&vid="+vid+"&anonimid="+anonimId+"&"+varyants
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if error != nil
            {
                print(error!)
            }
            else
            {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    print(json!)
                }
                catch
                {
                    
                }
            }
           
        }
        task.resume()
    }
    
    func seceneklerCustomize()
    {
        for subview in self.scrollView.subviews{
            subview.removeFromSuperview()
        }
        indiSecenek.startAnimating()
        cons=0
        aralık=30
        scrollgenislik=0
        genislik=0
        adetSayi.text="0"
        maxStok=""
        radiobutton.removeAll()
    }
    
    
    
    
   


}
