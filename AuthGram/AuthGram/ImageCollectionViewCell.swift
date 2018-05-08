//
//  ImageCollectionViewCell.swift
//  AuthGram
//
//  Created by Alec Dilanchian on 5/7/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    //-- Properties --//
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var date: UILabel!
    
    public func initCell(username: String, image: UIImage, date: String) {
        self.image.image = image
        self.username.text = username
        self.date.text = date
        
        // Set text to fit after setting //
        self.username.sizeToFit()
        self.date.sizeToFit()
    }
}
