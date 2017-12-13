//
//  AdreslerViewController.swift
//  Eticaret
//
//  Created by MacMini on 12.12.2017.
//  Copyright © 2017 MacMini. All rights reserved.
//

import UIKit

class AdreslerViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    @IBOutlet weak var sideMenu: UIBarButtonItem!
    @IBOutlet weak var countButton: UIButton!
    @IBOutlet weak var baslikLabel: UILabel!
    var uyeid=0
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        customize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AdreslerCollectionViewCell
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
        countButton.layer.cornerRadius=10
    }
}
