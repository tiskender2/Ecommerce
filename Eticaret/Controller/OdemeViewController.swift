//
//  OdemeViewController.swift
//  Eticaret
//
//  Created by MacMini on 5.12.2017.
//  Copyright © 2017 MacMini. All rights reserved.
//

import UIKit

class OdemeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BEMCheckBoxDelegate{
    @IBOutlet weak var sideMenu: UIBarButtonItem!
    @IBOutlet weak var iconButton: UIButton!
    
    @IBOutlet weak var clickView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var taksitCw: UICollectionView!
    @IBOutlet weak var odemeCw: UICollectionView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var sepetButto: UIButton!
    @IBOutlet weak var siparisButton: UIButton!
    @IBOutlet weak var adresButton: UIButton!
    @IBOutlet weak var odemeButton: UIButton!
    var radioGroup=[BEMCheckBox]()
    var cons:CGFloat=0
    var dizi=["kredi kartı","kapıda odeme","havale","asdasd"]
    var dizi2=["teek cekım","2 taksıt","3 tksıt","4 taksit"]
    var icongonder = true
    override func viewDidLoad() {
        super.viewDidLoad()
        barCustomize()
        sideMenus()
    }
    func didTap(_ checkBox: BEMCheckBox) {
        let currentTag = checkBox.tag
        for box in radioGroup where box.tag != currentTag {
            box.on = false
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == odemeCw
        {
            return dizi.count
        }
        else
        {
            return dizi2.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OdemeCollectionViewCell
        if collectionView == odemeCw
        {
            cell.checkBox.onAnimationType = BEMAnimationType.fade
            cell.checkBox.offAnimationType = BEMAnimationType.fade
            cell.odemeLabel.text = dizi[indexPath.row]
            cell.checkBox.delegate=self
            cell.checkBox.tag=indexPath.row
            radioGroup.append(cell.checkBox)
            cell.layer.cornerRadius = 3
        }
        else
        {
            cell.taksitLabel.text = dizi2[indexPath.row]
            cell.layer.cornerRadius = 5
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == odemeCw
        {
            
            let cell = collectionView.cellForItem(at: indexPath) as! OdemeCollectionViewCell
            cell.checkBox.setOn(true, animated: true)
            let first3 = stackView.arrangedSubviews[3]
            let first4 = stackView.arrangedSubviews[4]
            UIView.animate(withDuration: 0.5) {
                first3.isHidden=true
                first4.isHidden=true
            }
            cell.checkBox.setOn(true, animated: true)
            let currentTag = cell.checkBox.tag
            for box in radioGroup where box.tag != currentTag {
                box.on = false
            }
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
            let nString:NSString=dizi[indexPath.item] as NSString
            let size3 = (nString).size(withAttributes: nil)
            return CGSize(width: size3.width+width, height: odemeCw.frame.size.height)
        }
    }
    @IBAction func clickButton(_ sender: Any) {
       
      /*  let first = stackView.arrangedSubviews[1]
         let first2 = stackView.arrangedSubviews[2]
         let first3 = stackView.arrangedSubviews[3]
         let first4 = stackView.arrangedSubviews[4]
         let first5 = stackView.arrangedSubviews[5]
        UIView.animate(withDuration: 0.5) {
            first.isHidden=true
             first2.isHidden=true
             first3.isHidden=true
            first4.isHidden=true
            first5.isHidden=true
        }*/
    }
    @IBAction func iconButtonAction(_ sender: Any) {
        if !icongonder
        {
            let firstView = stackView.arrangedSubviews[1]
            let firstView2 = stackView.arrangedSubviews[2]
            let firstView3 = stackView.arrangedSubviews[3]
            UIView.animate(withDuration: 0.5){
                firstView.isHidden = true
                firstView2.isHidden = true
                firstView3.isHidden = true
                self.iconButton.setImage(UIImage(named: "uparrow"), for: .normal)
                
            }
            
            icongonder = true
        }
        else
        {
            let firstView = stackView.arrangedSubviews[1]
            let firstView2 = stackView.arrangedSubviews[2]
            let firstView3 = stackView.arrangedSubviews[3]
            UIView.animate(withDuration: 0.5){
                firstView.isHidden = false
                firstView2.isHidden = false
                firstView3.isHidden = false
                self.iconButton.setImage(UIImage(named: "arrow"), for: .normal)
            }
            
            icongonder=false
        }
    }
    func tutarYaz(i:Int,isim:Array<String>,tutar:Array<String>,uzunluk:Int)
    {
        if uzunluk >= 4
        {
            let frame = CGRect(x:10, y:i*20, width: Int(scrollView.frame.size.width)/2, height: 20 )
            let label = UILabel(frame: frame)
            let frame2 = CGRect(x:Int(label.frame.size.width), y:i*20, width: Int(scrollView.frame.size.width)/2, height: 20 )
            let label2 = UILabel(frame: frame2)
            label.text=isim[i]
            label.font = label.font.withSize(12)
            label2.text=tutar[i]+" TL"
            label2.font = label2.font.withSize(12)
            label2.textAlignment=NSTextAlignment.right
            scrollView.addSubview(label)
            scrollView.addSubview(label2)
            cons += label.frame.size.height
            
        }
        else
        {
            let frame = CGRect(x:10, y:i*25, width: Int(scrollView.frame.size.width)/2, height: 25 )
            let label = UILabel(frame: frame)
            let frame2 = CGRect(x:Int(label.frame.size.width), y:i*25, width: Int(scrollView.frame.size.width)/2, height: 25 )
            let label2 = UILabel(frame: frame2)
            label.text=isim[i]
            label.font = label.font.withSize(12)
            label2.text=tutar[i]+" TL"
            label2.font = label2.font.withSize(12)
            label2.textAlignment=NSTextAlignment.right
            scrollView.addSubview(label)
            scrollView.addSubview(label2)
            cons += label.frame.size.height
        }
        
        
        if i == uzunluk-1
        {
            scrollView.contentSize.height=CGFloat(cons)
            
        }
        
        
        
        
    }
    func barCustomize()
    {
        sepetButto.layer.cornerRadius=14
        odemeButton.layer.cornerRadius=14
        siparisButton.layer.cornerRadius=14
        adresButton.layer.cornerRadius=14
        taksitCw!.contentInset = UIEdgeInsets(top: 3, left: 0, bottom: 0, right: 0)
        scrollView.layer.borderWidth=0.5
        scrollView.layer.borderColor = UIColor.lightGray.cgColor
        for j in 0...3
        {
            tutarYaz(i: j, isim: dizi, tutar: dizi2, uzunluk: 4)
        }
        let firstView = stackView.arrangedSubviews[1]
        let firstView2 = stackView.arrangedSubviews[2]
        let firstView3 = stackView.arrangedSubviews[3]
        let firstView4 = stackView.arrangedSubviews[4]
            firstView.isHidden = true
            firstView2.isHidden = true
            firstView3.isHidden = true
            firstView4.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.clickviewFunction))
        clickView.addGestureRecognizer(tap)
    }
    @objc func clickviewFunction()
    {
        if !icongonder
        {
            let firstView = stackView.arrangedSubviews[1]
            let firstView2 = stackView.arrangedSubviews[2]
            let firstView3 = stackView.arrangedSubviews[3]
            UIView.animate(withDuration: 0.5){
                firstView.isHidden = true
                firstView2.isHidden = true
                firstView3.isHidden = true
                self.iconButton.setImage(UIImage(named: "uparrow"), for: .normal)
                
            }
            
            icongonder = true
        }
        else
        {
            let firstView = stackView.arrangedSubviews[1]
            let firstView2 = stackView.arrangedSubviews[2]
            let firstView3 = stackView.arrangedSubviews[3]
            UIView.animate(withDuration: 0.5){
                firstView.isHidden = false
                firstView2.isHidden = false
                firstView3.isHidden = false
                self.iconButton.setImage(UIImage(named: "arrow"), for: .normal)
            }
            
            icongonder=false
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
    
}
