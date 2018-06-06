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
    
    public func initCell(image: Dictionary<String, Any>) {
        // Set image //
        self.image.image = image["image"] as? UIImage
        
        // Convert date time //
        let date = Date(timeIntervalSince1970: Double(image["dateTime"] as! Int))
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy/MM/dd" //Specify your format that you want
        self.date.text = formatter.string(from: date)
        
//        self.username.text = username
        // Set text to fit after setting //
//        self.username.sizeToFit()
        self.date.sizeToFit()
    }
}
