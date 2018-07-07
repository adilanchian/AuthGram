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
    
    func initCell(image: ImgurImage) {
        // Set image //
        if let imageData = image.image_data {
            self.image.image = UIImage(data: imageData)
        }
        
        // Set username (We will be the title of the image for username) //
        if image.title != nil {
            self.username.text = image.title!
        }

        // Convert date time //
        let date = Date(timeIntervalSince1970: TimeInterval(image.datetime))
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .medium
        self.date.text = formatter.string(from: date)
        
        // Set text to fit after setting //
        self.username.sizeToFit()
        self.date.sizeToFit()
    }
}
