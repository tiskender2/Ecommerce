//
//  FavorilerimViewController.swift
//  Eticaret
//
//  Created by MacMini on 12.12.2017.
//  Copyright © 2017 MacMini. All rights reserved.
//

import UIKit

class FavorilerimViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{

    @IBOutlet weak var favCw: UICollectionView!
    @IBOutlet weak var sideMenu: UIBarButtonItem!
    @IBOutlet weak var countBtn: UIButton!
    var uyeid=0
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        customize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FavorilerimCollectionViewCell
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth=0.2
        cell.layer.shadowOpacity = 0.1
        return cell
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
    func customize()
    {
        countBtn.layer.cornerRadius=10
        
    }
    

}
