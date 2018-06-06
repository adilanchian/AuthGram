//
//  ImageHandlerDelegate.swift
//  AuthGram
//
//  Created by Alec Dilanchian on 6/5/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import Foundation

protocol ImageHandlerDelegate {
    func didReceiveImages(images: Array<ImgurImage>)
}
