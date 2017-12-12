//
//  SepetimTableViewCell.swift
//  Eticaret
//
//  Created by MacMini on 24.11.2017.
//  Copyright © 2017 MacMini. All rights reserved.
//

import UIKit

class SepetimTableViewCell: UITableViewCell {
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var azaltBtn: UIButton!
    @IBOutlet weak var arttırBtn: UIButton!
    @IBOutlet weak var iptalButton: UIButton!
    @IBOutlet weak var taksitLabe: UILabel!
    @IBOutlet weak var scrollViewSepet: UIScrollView!
    @IBOutlet weak var sepetResim: UIImageView!
    @IBOutlet weak var sepetUrunAd: UILabel!
    @IBOutlet weak var adet: UILabel!
    @IBOutlet weak var sepetUrunFiyat: UILabel!
   
    
}
