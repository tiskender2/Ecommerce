//
//  SepetimViewController.swift
//  Eticaret
//
//  Created by MacMini on 23.11.2017.
//  Copyright © 2017 MacMini. All rights reserved.
//

import UIKit
import SDWebImage

struct Urunler {
    var urunid=[String]()
    var ubaslik=[String]()
    var vbaslik=[String]()
    var resim=[String]()
    var fiyat=[String]()
    var adet=[String]()
    var maksAdet=[String]()
    var vsecilenVeri=[String]()
    var varyantBaslik=[String]()
    var varyantCount=[Int]()
    var varyantlarUrunHepsi=[Array<String>]()
    var secilenVeriHepsi=[Array<String>]()
}
struct FiyatBilgileri {
    var fyt_baslik=[String]()
    var fyt_veri=[String]()
    var toplamTutar:String = ""
}
struct Taksit {
    var tSecenekler=[String]()
    var odemeTip=[String]()
    var taksitKod=[String]()
    var taksitId=[String]()
    var taksitBaslik:String="0"
    }
class SepetimViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BEMCheckBoxDelegate{
   
    var ozellikler:NSAttributedString = NSAttributedString()
    @IBOutlet weak var toplamLabel: UILabel!
    @IBOutlet weak var tSecenekCw: UICollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var clickView: UIView!
    @IBOutlet weak var icStackUzunluk: NSLayoutConstraint!
    @IBOutlet weak var taksitCw: UICollectionView!
    @IBOutlet weak var endısStack: UIStackView!
    @IBOutlet weak var sepetimTableview: UITableView!
    @IBOutlet weak var hesaplarHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var ıcStacView: UIStackView!
    @IBOutlet weak var hesaplarView: UIView!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var barSepetButton: UIButton!
    @IBOutlet weak var barViewUst: UIView!
    @IBOutlet weak var siparisBarButon: UIButton!
    @IBOutlet weak var odemeBarButton: UIButton!
    @IBOutlet weak var adresBarButton: UIButton!
    @IBOutlet weak var sideMenu: UIBarButtonItem!
    @IBOutlet weak var iconButton: UIButton!
    var icongonder=true
    var index = IndexPath()
    @IBOutlet weak var odemeTipHeight: NSLayoutConstraint!
    var stackHeight:CGFloat = 0.0
    var tableview = UITableView()
    var dizi=["","","",""]
    var cons:CGFloat=0
    var heigt:CGFloat = 0.0
    var cwHeight:CGFloat = 0.0
    var radioGroup=[BEMCheckBox]()
    var baslikCıktısı=[String]()
    var urunler = Urunler()
    var taksit = Taksit()
    var fiyatBilgileri=FiyatBilgileri()
    var taksitSayısı:Int=0
    var icstack:Float=0
    var icstack2:Float=0
    var labelUzunluk=[CGFloat]()
    var tut:CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        icstack=Float(icStackUzunluk.constant)
        odemeSecenekler(urlString: WebService.odeme_secenekler)
        JsonDatas(urlString: WebService.sepet_listele, anonimId: globals.anonim_id, secilen_dil: Dil.tr,odemeTuru: UserDefaults.standard.object(forKey: "odemeTip") as! String ,taksitId: UserDefaults.standard.object(forKey: "taksitId") as! String)
        barCustomize()
        sideMenus()
        stackHeight = hesaplarHeight.constant
        icstack2=Float(icStackUzunluk.constant)
        let firstView = endısStack.arrangedSubviews[0]
        firstView.isHidden = true
        
    }
    func didTap(_ checkBox: BEMCheckBox) {
        for subview in self.scrollview.subviews{
            subview.removeFromSuperview()
        }
        odemeTipiKontrol(urlString: WebService.sepet_listele, anonimId: globals.anonim_id, secilen_dil: Dil.tr,odemeTuru: taksit.taksitKod[checkBox.tag],taksitId: "0")
 
        
        if self.taksit.taksitKod[checkBox.tag] == "kredi_karti"
        {
            UserDefaults.standard.removeObject(forKey: "odemeTip")
            globals.odeme_secenek = self.taksit.taksitKod[checkBox.tag]
            UserDefaults.standard.set(globals.odeme_secenek,forKey:"odemeTip")
            let firstView = ıcStacView.arrangedSubviews[2]
           
                self.icStackUzunluk.constant=CGFloat(self.icstack)
                firstView.isHidden = false
            
        }
        else
        {
            UserDefaults.standard.removeObject(forKey: "odemeTip")
            globals.odeme_secenek = self.taksit.taksitKod[checkBox.tag]
            UserDefaults.standard.set(globals.odeme_secenek,forKey:"odemeTip")
            let firstView = ıcStacView.arrangedSubviews[2]
           
                firstView.isHidden = true
                if self.icStackUzunluk.constant != (self.icStackUzunluk.constant-self.taksitCw.frame.size.height)
                {
                    self.icStackUzunluk.constant=(self.icStackUzunluk.constant-self.taksitCw.frame.size.height)
                }
            
        }

        let currentTag = checkBox.tag
        for box in radioGroup where box.tag != currentTag {
            box.on = false
        }
        
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        if !icongonder
        {
        let firstView = endısStack.arrangedSubviews[0]
        UIView.animate(withDuration: 0.5){
            firstView.isHidden = true
            self.iconButton.setImage(UIImage(named: "uparrow"), for: .normal)
            
        }
            
            icongonder = true
        }
        else
        {
            let firstView = endısStack.arrangedSubviews[0]
            UIView.animate(withDuration: 0.5){
                firstView.isHidden = false
                  self.iconButton.setImage(UIImage(named: "arrow"), for: .normal)
            }
          
            icongonder=false
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return urunler.urunid.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SepetimTableViewCell
            cell.azaltBtn.layer.borderWidth = 1
            cell.azaltBtn.layer.borderColor = UIColor.lightGray.cgColor
            cell.arttırBtn.layer.borderWidth = 1
            cell.arttırBtn.layer.borderColor = UIColor.lightGray.cgColor
            cell.adet.layer.borderWidth = 1
            cell.adet.layer.borderColor = UIColor.lightGray.cgColor
            cell.adet.text = urunler.adet[indexPath.row]
            cell.azaltBtn.tag = indexPath.row
            cell.azaltBtn.addTarget(self, action: #selector(self.incrementBtnClicked), for: .touchUpInside)
            cell.arttırBtn.tag = indexPath.row
            cell.arttırBtn.addTarget(self, action: #selector(self.decrementBtnClicked), for: .touchUpInside)
            cell.sepetResim.sd_setImage(with: URL(string: urunler.resim[indexPath.row]))
            cell.sepetUrunFiyat.text=urunler.fiyat[indexPath.row]+" TL"
            cell.iptalButton.layer.cornerRadius=cell.iptalButton.bounds.size.width / 2.0
            cell.clipsToBounds = true
            cell.selectionStyle = .none
           /* cell.scrollViewSepet.delegate = self
            cell.scrollViewSepet.contentSize.width = CGFloat(6*(Int(cell.scrollViewSepet.frame.size.width)/3))*/
           setHTMLFromString(htmlText: baslikCıktısı[indexPath.row])
           cell.ozellikler.attributedText = ozellikler
            
            
           /* for i in 0..<urunler.varyantlarUrunHepsi[indexPath.row].count
            {
                let frame = CGRect(x:i*Int(cell.scrollViewSepet.frame.size.width)/3, y:0, width: Int(cell.scrollViewSepet.frame.size.width)/3, height: 10 )
                let label = UILabel(frame: frame)
                label.numberOfLines = 0
               
                let frame2 = CGRect(x:i*Int(cell.scrollViewSepet.frame.size.width)/3, y:15, width: Int(cell.scrollViewSepet.frame.size.width)/3, height: 15 )
                let label2 = UILabel(frame: frame2)
                label2.numberOfLines = 0
                
                label.text=urunler.varyantlarUrunHepsi[indexPath.row][i]
                label.textAlignment=NSTextAlignment.center
                label.font = UIFont.boldSystemFont(ofSize: 12)
                label2.text=urunler.secilenVeriHepsi[indexPath.row][i]
                label2.font = label2.font.withSize(12)
                label2.textAlignment=NSTextAlignment.center
                 label2.sizeToFit()
                 label.sizeToFit()
                cell.scrollViewSepet.addSubview(label)
                cell.scrollViewSepet.addSubview(label2)
                cell.scrollViewSepet.contentSize.width = CGFloat((i*Int(cell.scrollViewSepet.frame.size.width)/3)+Int(cell.scrollViewSepet.frame.size.width)/3)
                labelUzunluk.append(label2.frame.size.height)
                
                for i in 0..<labelUzunluk.count
                {
                    for j in 0..<labelUzunluk.count
                    {
                        if labelUzunluk[i] > labelUzunluk[j]
                        {
                            tut = labelUzunluk[i]
                            labelUzunluk[i] = labelUzunluk[j]
                            labelUzunluk[j]=tut
                        }
                    }
                }
                 cell.scrollViewSepet.contentSize.height = CGFloat(labelUzunluk[0]+label.frame.size.height)
                
            }*/
            return cell
        
       
        
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
            return 200
        
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == taksitCw
        {
            
            return taksit.tSecenekler.count
        }
        else
        {
            return taksit.odemeTip.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == taksitCw
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SepetimCollectionViewCell
            cell.taksitLabel.text=taksit.tSecenekler[indexPath.row]
            cell.layer.cornerRadius = 5
            if taksit.taksitId[indexPath.row] == UserDefaults.standard.object(forKey: "taksitId") as! String
            {
                cell.backgroundColor = UIColor.lightGray
            }
            else
            {
                  cell.backgroundColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 0.3)
            }
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SepetimCollectionViewCell
            cell.radio.delegate=self
            cell.radio.onAnimationType = BEMAnimationType.fade
            cell.radio.offAnimationType = BEMAnimationType.fade
            cell.layer.cornerRadius=3
            
            cell.radio.tag=indexPath.row
            radioGroup.append(cell.radio)
            if taksit.taksitKod[indexPath.row] == UserDefaults.standard.object(forKey: "odemeTip") as! String
            {
                cell.radio.on=true
            }
           
            cell.radio.reload()
            cell.label.text=taksit.odemeTip[indexPath.row]
            indicator.stopAnimating()
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == taksitCw
        {
            indicator.startAnimating()
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.lightGray
            for subview in self.scrollview.subviews{
                subview.removeFromSuperview()
            }
            UserDefaults.standard.removeObject(forKey: "taksitId")
             globals.taksitId = taksit.taksitId[indexPath.row]
            UserDefaults.standard.set(globals.taksitId,forKey:"taksitId")
            odemeTipiKontrol(urlString: WebService.sepet_listele, anonimId: globals.anonim_id, secilen_dil: Dil.tr,odemeTuru: UserDefaults.standard.object(forKey: "odemeTip") as! String,taksitId: taksit.taksitId[indexPath.row])
            
         
        }
        else
        {
            indicator.startAnimating()
            for subview in self.scrollview.subviews{
                subview.removeFromSuperview()
            }
             index = indexPath
                let cell = collectionView.cellForItem(at: indexPath) as! SepetimCollectionViewCell
             // cell.isUserInteractionEnabled = false
            UserDefaults.standard.removeObject(forKey: "odemeTip")
            globals.odeme_secenek = self.taksit.taksitKod[indexPath.row]
            UserDefaults.standard.set(globals.odeme_secenek,forKey:"odemeTip")
              odemeTipiKontrol(urlString: WebService.sepet_listele, anonimId: globals.anonim_id, secilen_dil: Dil.tr,odemeTuru: taksit.taksitKod[indexPath.row],taksitId: UserDefaults.standard.object(forKey: "taksitId") as! String)
            
            if self.taksit.taksitKod[indexPath.row] == "kredi_karti"
            {
              
                let firstView = ıcStacView.arrangedSubviews[2]
                    firstView.isHidden = false
                self.icStackUzunluk.constant=CGFloat(self.icstack)
            }
            else
            {
               
                let firstView = ıcStacView.arrangedSubviews[2]
                
                    if self.icStackUzunluk.constant != (self.icStackUzunluk.constant-self.taksitCw.frame.size.height)
                    {
                    self.icStackUzunluk.constant=(self.icStackUzunluk.constant-self.taksitCw.frame.size.height)
                    
                firstView.isHidden = true
                }
               
                
            }
            
       
            cell.radio.setOn(true, animated: true) 
            let currentTag = cell.radio.tag
            for box in radioGroup where box.tag != currentTag {
                box.on = false
            }
           
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == taksitCw
        {
            let cell = collectionView.cellForItem(at: indexPath)
              cell?.backgroundColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1)
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == taksitCw
        {
             return CGSize(width: taksitCw.frame.size.width, height: taksitCw.frame.size.height/5.4)
        }
        else
        {
            let size = UICollectionViewFlowLayout()
            let size2 = size.itemSize
            let width = size2.width
            let nString:NSString=taksit.odemeTip[indexPath.item] as NSString
            let size3 = (nString).size(withAttributes: nil)
            return CGSize(width: size3.width+width, height: tSecenekCw.frame.size.height)
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
    func barCustomize()
        {

        barViewUst.layoutIfNeeded()
        barViewUst.sizeToFit()
        barViewUst.frame.size.width = self.view.frame.width/4
        barSepetButton.layer.cornerRadius=14
        siparisBarButon.layer.cornerRadius=14
        odemeBarButton.layer.cornerRadius=14
        adresBarButton.layer.cornerRadius=14
        hesaplarView.layer.borderWidth=0.5
        hesaplarView.layer.borderColor=UIColor.lightGray.cgColor
        scrollview.delegate = self
        cwHeight=taksitCw.frame.size.height
        sepetimTableview.rowHeight = UITableViewAutomaticDimension
        sepetimTableview.estimatedRowHeight = 200
        taksitCw!.contentInset = UIEdgeInsets(top: 3, left: 0, bottom: 0, right: 0)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.clickviewFunction))
        clickView.addGestureRecognizer(tap)
            

        }
        @objc func clickviewFunction()
        {
            if !icongonder
            {
                let firstView = endısStack.arrangedSubviews[0]
                UIView.animate(withDuration: 0.5){
                    firstView.isHidden = true
                    self.iconButton.setImage(UIImage(named: "uparrow"), for: .normal)
                    
                }
                
                icongonder = true
            }
            else
            {
                let firstView = endısStack.arrangedSubviews[0]
                UIView.animate(withDuration: 0.5){
                    firstView.isHidden = false
                    self.iconButton.setImage(UIImage(named: "arrow"), for: .normal)
                }
                
                icongonder=false
            }
        }
    func JsonDatas(urlString:String,anonimId:String,secilen_dil:String,odemeTuru:String,taksitId:String)
    {
        if odemeTuru != "kredi_karti"
        {
            let firstView = ıcStacView.arrangedSubviews[2]
        
        firstView.isHidden = true
        if self.icStackUzunluk.constant != (self.icStackUzunluk.constant-self.taksitCw.frame.size.height)
        {
            self.icStackUzunluk.constant=(self.icStackUzunluk.constant-self.taksitCw.frame.size.height)
        }
        }
        let urlRequest = URL(string: urlString)
        var request = URLRequest(url: urlRequest! as URL)
        request.httpMethod = "POST"
        let parameters = "anonimid="+anonimId+"&secilen_dil="+secilen_dil+"&odemeturu="+odemeTuru+"&taksitid="+taksitId
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
                    print(json!)
                    if let tutar = json!["toplam_tutar"] as? String
                    {
                        self.fiyatBilgileri.toplamTutar=tutar
                        DispatchQueue.main.async {
                            self.toplamLabel.text=tutar+" TL"
                        }
                    }
                    if let urunlers = json!["urunler"] as?  NSArray
                    {
                       
                        
                        for i in 0..<urunlers.count
                        {
                            if let jsonVeri = urunlers[i] as? NSDictionary
                            {
                                if let sId = jsonVeri["sepetid"] as? String
                                {
                                    self.urunler.urunid.append(sId)
                                    
                                    
                                }
                                if let ubaslik = jsonVeri["ubaslik"] as? String
                                {
                                    self.urunler.ubaslik.append(ubaslik)
                                    
                                }
                                if let vbaslik = jsonVeri["vbaslik"] as? String
                                {
                                    self.urunler.vbaslik.append(vbaslik)
                                    
                                }
                                if let resim = jsonVeri["resim"] as? String
                                {
                                    self.urunler.resim.append(resim)
                                    
                                }
                                if let fiyat = jsonVeri["fiyat"] as? String
                                {
                                    self.urunler.fiyat.append(fiyat)
                                    
                                }
                                if let adet = jsonVeri["adet"] as? String
                                {
                                    self.urunler.adet.append(adet)
                                    
                                }
                                if let maksAdet = jsonVeri["maks_adet"] as? String
                                {
                                    self.urunler.maksAdet.append(maksAdet)
                                    
                                }
                                if let baslikCikti = jsonVeri["baslik_ciktisi"] as? String
                                {
                                    self.baslikCıktısı.append(baslikCikti)
                                    
                                }
                             
                                
                                if let varyants = jsonVeri["varyants"] as?  NSArray
                                {
                                    self.urunler.varyantCount.append(varyants.count)
                                    for k in 0..<varyants.count
                                    {
                                        if let jsonVeri = varyants[k] as? NSDictionary
                                        {
                                            if let baslik = jsonVeri["baslik"] as? String
                                            {
                                                self.urunler.varyantBaslik.append(baslik)
                                                
                                            }
                                            if let secilen_veri = jsonVeri["secilen_veri"] as? String
                                            {
                                                self.urunler.vsecilenVeri.append(secilen_veri)
                                                
                                            }
                                        }
                                    }
                                    self.urunler.varyantlarUrunHepsi.append(self.urunler.varyantBaslik)
                                    self.urunler.secilenVeriHepsi.append(self.urunler.vsecilenVeri)
                                    self.urunler.varyantBaslik.removeAll()
                                    self.urunler.vsecilenVeri.removeAll()
                                    
                                }
                           
                                
                            }
                        }
                    }
                   
                    if let t_secenekler = json!["taksit_secenekleri"] as?  NSArray
                    {
                        for t in 0..<t_secenekler.count
                        {
                            if let jsonVeri = t_secenekler[t] as? NSDictionary
                            {
                                if let tbaslik = jsonVeri["baslik"] as? String
                                {
                                    self.taksit.taksitBaslik=tbaslik
                                    
                                }
                                if let oPlan = jsonVeri["odeme_plani"] as? String
                                {
                                    self.taksit.taksitBaslik+=" - "+oPlan
                                    self.taksit.tSecenekler.append(self.taksit.taksitBaslik)
                                    
                                }
                                if let tId = jsonVeri["taksitid"] as? String
                                {
                                    self.taksit.taksitId.append(tId)
                                    
                                }
                            }
                        }
                    }
                    if let fiyat_bilgileri = json!["fiyat_bilgileri"] as?  NSArray
                    {
                        
                        for t in 0..<fiyat_bilgileri.count
                        {
                            if let jsonVeri = fiyat_bilgileri[t] as? NSDictionary
                            {
                                if let fty_baslik = jsonVeri["fty_baslik"] as? String
                                {
                                    self.fiyatBilgileri.fyt_baslik.append(fty_baslik)
                                    
                                }
                                if let fyt_veri = jsonVeri["fyt_veri"] as? String
                                {
                                    self.fiyatBilgileri.fyt_veri.append(fyt_veri)
                                    
                                }
                            }
                            DispatchQueue.main.sync {
                                self.tutarYaz(i: t, isim: self.fiyatBilgileri.fyt_baslik, tutar: self.fiyatBilgileri.fyt_veri,uzunluk:fiyat_bilgileri.count)
                                
                            }
                        }
                        self.cons=0
                       
                    }
                    
                   
                    DispatchQueue.main.async {
                        self.sepetimTableview.reloadData()
                        self.taksitCw.reloadData()
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
    
    func tutarYaz(i:Int,isim:Array<String>,tutar:Array<String>,uzunluk:Int)
    {
            if uzunluk >= 4
            {
                let frame = CGRect(x:10, y:i*20, width: Int(hesaplarView.frame.size.width)/2, height: 20 )
                let label = UILabel(frame: frame)
                let frame2 = CGRect(x:Int(label.frame.size.width), y:i*20, width: Int(hesaplarView.frame.size.width)/2, height: 20 )
                let label2 = UILabel(frame: frame2)
                label.text=isim[i]
                label.font = label.font.withSize(12)
                label2.text=tutar[i]+" TL"
                label2.font = label2.font.withSize(12)
                label2.textAlignment=NSTextAlignment.right
                scrollview.addSubview(label)
                scrollview.addSubview(label2)
                cons += label.frame.size.height
            }
            else
            {
                let frame = CGRect(x:10, y:i*25, width: Int(hesaplarView.frame.size.width)/2, height: 25 )
                let label = UILabel(frame: frame)
                let frame2 = CGRect(x:Int(label.frame.size.width), y:i*25, width: Int(hesaplarView.frame.size.width)/2, height: 25 )
                let label2 = UILabel(frame: frame2)
                label.text=isim[i]
                label.font = label.font.withSize(12)
                label2.text=tutar[i]+" TL"
                label2.font = label2.font.withSize(12)
                label2.textAlignment=NSTextAlignment.right
                scrollview.addSubview(label)
                scrollview.addSubview(label2)
                cons += label.frame.size.height
            }
        

        if i == uzunluk-1
        {
            scrollview.contentSize.height=CGFloat(cons)
        
        }
        
        
        
        
    }
    
    func odemeSecenekler(urlString:String)
    {
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
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
                    for i in 0..<json.count
                    {
                        if let jsonVeri = json[i] as? NSDictionary
                        {
                            if let baslik = jsonVeri["baslik"] as? String
                            {
                                self.taksit.odemeTip.append(baslik)
                                
                            }
                            if let kod = jsonVeri["kod"] as? String
                            {
                                self.taksit.taksitKod.append(kod)
                                
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.tSecenekCw.reloadData()
                    }
                }
                catch
                {
                    
                }
            }
        }
        task.resume()
    }
    func odemeTipiKontrol(urlString:String,anonimId:String,secilen_dil:String,odemeTuru:String,taksitId:String)
    {
        taksit.tSecenekler.removeAll()
        taksit.taksitId.removeAll()
        fiyatBilgileri.fyt_veri.removeAll()
        fiyatBilgileri.fyt_baslik.removeAll()
        let urlRequest = URL(string: urlString)
        var request = URLRequest(url: urlRequest! as URL)
        request.httpMethod = "POST"
        let parameters = "anonimid="+anonimId+"&secilen_dil="+secilen_dil+"&odemeturu="+odemeTuru+"&taksitid="+taksitId
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
                    if let tutar = json!["toplam_tutar"] as? String
                    {
                        self.fiyatBilgileri.toplamTutar=tutar
                        DispatchQueue.main.async {
                            self.toplamLabel.text=tutar+" TL"
                        }
                    }

                    if let t_secenekler = json!["taksit_secenekleri"] as?  NSArray
                    {
                        self.taksitSayısı = t_secenekler.count
                        for t in 0..<t_secenekler.count
                        {
                            if let jsonVeri = t_secenekler[t] as? NSDictionary
                            {
                                if let tbaslik = jsonVeri["baslik"] as? String
                                {
                                    self.taksit.taksitBaslik=tbaslik
                                    
                                }
                                if let oPlan = jsonVeri["odeme_plani"] as? String
                                {
                                    self.taksit.taksitBaslik+=" - "+oPlan
                                    self.taksit.tSecenekler.append(self.taksit.taksitBaslik)
                                    
                                }
                                if let tId = jsonVeri["taksitid"] as? String
                                {
                                    self.taksit.taksitId.append(tId)
                                    
                                    
                                }
                            }
                        }
                    }
                    if let fiyat_bilgileri = json!["fiyat_bilgileri"] as?  NSArray
                    {
                        
                        for t in 0..<fiyat_bilgileri.count
                        {
                            if let jsonVeri = fiyat_bilgileri[t] as? NSDictionary
                            {
                                if let fty_baslik = jsonVeri["fty_baslik"] as? String
                                {
                                    self.fiyatBilgileri.fyt_baslik.append(fty_baslik)
                                    
                                }
                                if let fyt_veri = jsonVeri["fyt_veri"] as? String
                                {
                                    self.fiyatBilgileri.fyt_veri.append(fyt_veri)
                                    
                                }
                            }
                            DispatchQueue.main.sync {
                                self.tutarYaz(i: t, isim: self.fiyatBilgileri.fyt_baslik, tutar: self.fiyatBilgileri.fyt_veri,uzunluk:fiyat_bilgileri.count)
                                
                            }
                        }
                        self.cons=0
                        
                    }
                    DispatchQueue.main.async {
                      self.taksitCw.reloadData()
                        self.indicator.stopAnimating()
                    }
                }
                catch
                {
                    
                }
            }
         
        }
        task.resume()
    }
    @objc func incrementBtnClicked(_ sender: UIButton)
    {
        
        if Int(urunler.adet[sender.tag])!-1 != 0
        {
            let  azalt = Int(urunler.adet[sender.tag])!-1
            self.urunler.adet[sender.tag] = String(azalt)
            self.sepetimTableview.reloadData()
        }
       
    }
    @objc func decrementBtnClicked(_ sender: UIButton)
    {
        if Int(urunler.adet[sender.tag])!+1 <= Int(urunler.maksAdet[sender.tag])!
        {
        let arttır = Int(urunler.adet[sender.tag])!+1
        self.urunler.adet[sender.tag] = String(arttır)
        self.sepetimTableview.reloadData()
        }
    }
    func setHTMLFromString(htmlText: String) {
        let modifiedFont = NSString(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(12)\">%@</span>" as NSString, htmlText) as String
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        self.ozellikler = attrStr
    }
    
    
    
    
    
}
