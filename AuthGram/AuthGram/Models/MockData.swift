//
//  MockData.swift
//  AuthGram
//
//  Created by Alec Dilanchian on 5/7/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import Foundation
import UIKit

struct User {
    let firstName: String
    let lastName: String
    let username: String
}

struct ImageCell {
    let user: User
    let date: String
    let image: UIImage
}

func initMockImageCells() -> Array<ImageCell> {
    var mockImageCells = Array<ImageCell>()
    
    for var i in 0...9 {
        let newUser = User(firstName: "Alec", lastName: "Dilanchian", username: "adilanchian\(i)")
        let newImageCell = ImageCell(user: newUser, date: "May 8th, 2018", image: #imageLiteral(resourceName: "dog"))
        mockImageCells.append(newImageCell)
    }
    
    return mockImageCells
}
