//
//  ViewController.swift
//  Eticaret
//
//  Created by MacMini on 26.10.2017.
//  Copyright © 2017 MacMini. All rights reserved.
//

import UIKit
import SDWebImage
struct globals {
   static var dil = "tr"
   static var odeme_secenek = ""
   static var taksitId="0"
}
class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var sideMenu: UIBarButtonItem!
    var indirimImage=[String]()
    var urunResim=[String]()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewUrun: UICollectionView!
    var vids=[String]()
    var uBaslik=[String]()
    var vBaslik=[String]()
    var iFiyat=[String]()
    var fiyat=[String]()
    var stokKodu=[String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        sideMenus()
        Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
        if UserDefaults.standard.object(forKey: "odemeTip")  == nil
        {
            
            globalVariable(urlString: "https://ortakfikir.com/eticaret/sistem/API/webservices/android_services/service_app_20102017_versionv4_php/odeme_turleri.php")
        }
        else
        {
            globals.odeme_secenek = UserDefaults.standard.object(forKey: "odemeTip") as! String
            globals.taksitId = UserDefaults.standard.object(forKey: "taksitId") as! String
            
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func scrollAutomatically(_ timer1: Timer) {
        
        if let coll  = collectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)!  < indirimImage.count - 1){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                                    }
                
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
        sliderResim(urlString: "https://ortakfikir.com/eticaret/sistem/API/webservices/android_services/service_app_20102017_versionv4_php/anasayfa_slider.php")
        onerilenUrunler(urlString:"https://ortakfikir.com/eticaret/sistem/API/webservices/android_services/service_app_20102017_versionv4_php/anasayfa_onerilen_urunler.php")
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView
        {
            return indirimImage.count
        }
        else
        {
            return urunResim.count
        }
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ResimCollectionViewCell
        if collectionView == self.collectionView
        {
             cell.imageView.sd_setImage(with: URL(string: indirimImage[indexPath.row]))
             cell.pageControl.numberOfPages=indirimImage.count
           /*  let page = collectionView.contentOffset.x / collectionView.frame.size.width
             cell.pageControl.currentPage=Int(page)*/
        }
        else
        {
            cell.layer.cornerRadius = 5
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 0).cgColor
            let bottomborder = UIView(frame: CGRect(x: 0, y:cell.urunIndirim.frame.size.height-(cell.urunIndirim.frame.size.height/2) , width: cell.urunIndirim.frame.size.width, height: 1))
            bottomborder.backgroundColor=UIColor.red
            cell.urunIndirim.addSubview(bottomborder)
            cell.urunIndirim.sizeToFit()
            cell.urunFiyat.sizeToFit()
            cell.urunResim.sd_setImage(with: URL(string: urunResim[indexPath.row]))
            cell.urunAd.text = uBaslik[indexPath.row]
            cell.urunIndirim.text = fiyat[indexPath.row]
            cell.urunFiyat.text = iFiyat[indexPath.row]
            cell.vbaslik.text = vBaslik[indexPath.row]
            
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.collectionViewUrun
        {
            
            
            let nesne = self.storyboard?.instantiateViewController(withIdentifier: "UrunDetayViewController") as! UrunDetayViewController
            nesne.vid=vids[indexPath.row]
            self.navigationController?.pushViewController(nesne, animated: true)
        }
    }
    
    func sliderResim(urlString:String)
    {
        let urlRequest = URL(string: urlString)
        var request = URLRequest(url: urlRequest! as URL)
        request.httpMethod = "POST"
        let parameters = ""
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if error != nil
            {
                print(error!)
            }
            else
            {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
                    for i in 0..<json.count
                    {
                        let resim = json[i] as! String
                        self.indirimImage.append(resim)
                        
                        
                    }
                    
                    
                }
                catch
                {
                    print(error)
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        task.resume()
        
    }
    func onerilenUrunler(urlString:String)
    {
        let urlRequest = URL(string: urlString)
        var request = URLRequest(url: urlRequest! as URL)
        request.httpMethod = "POST"
        let parameters = "secilen_dil="+"tr"
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if error != nil
            {
                print(error!)
            }
            else
            {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
                    for i in 0..<json.count
                    {
                        if let jsonVeri = json[i] as? NSDictionary
                        {
                            if let vid = jsonVeri["vid"] as? String
                            {
                               self.vids.append(vid)
                                
                            }
                            if let ubaslik = jsonVeri["ubaslik"] as? String
                            {
                                self.uBaslik.append(ubaslik)
                                
                            }
                            if let vbaslik = jsonVeri["vbaslik"] as? String
                            {
                                self.vBaslik.append(vbaslik)
                                
                            }
                            if let ifiyat = jsonVeri["indirimlifiyat"] as? String
                            {
                                self.iFiyat.append(ifiyat)
                                
                            }
                            if let fiyat = jsonVeri["fiyat"] as? String
                            {
                                self.fiyat.append(fiyat)
                                
                            }
                            if let stokKod = jsonVeri["stokkodu"] as? String
                            {
                                self.stokKodu.append(stokKod)
                                
                            }
                            if let resims = jsonVeri["resim"] as? String
                            {
                                self.urunResim.append(resims)
                                
                            }
                            
                        }
                    }
                    
                }
                catch
                {
                    print(error)
                }
                DispatchQueue.main.async {
                    self.collectionViewUrun.reloadData()
                }
            }
        }
        task.resume()
        
        
    }
    func globalVariable(urlString:String)
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
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
                    for i in 0..<1
                    {
                        if let jsonVeri = json[i] as? NSDictionary
                        {
                             globals.odeme_secenek = (jsonVeri["kod"] as? String)!
                          
                            
                            UserDefaults.standard.set(globals.odeme_secenek,forKey:"odemeTip")
                             UserDefaults.standard.set(globals.taksitId,forKey:"taksitId")
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
   
    
  
    



}
