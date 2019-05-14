//
//  ProfileCollectionViewCell.swift
//  fakestagram
//
//  Created by Antonyo Chavez Saucedo on 5/17/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {

    static let identifier = "postThumbailCell"
    
    @IBOutlet weak var imageTumbs: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI(){
        self.layer.cornerRadius = 10
    }
}
