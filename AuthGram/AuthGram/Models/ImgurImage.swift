//
//  ImgurImage.swift
//  AuthGram
//
//  Created by Alec Dilanchian on 6/3/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import Foundation

class ImgurImage {
    //-- Properties --//
    private var account_id: String?
    private var account_url: String?
    private var ad_type: Int
    private var ad_url: String
    private var animated: Int
    private var bandwidth: Int
    private var datetime: Int
    private var description: String?
    private var favorite: Int
    private var has_sound: Int
    private var height: Int
    private var id: String
    private var in_gallery: Int
    private var in_most_viral: Int
    private var is_ad: Int
    private var link: String
    private var nsfw: String?
    private var section: String?
    private var size: Int
    private var tags: [String]
    private var title: String?
    private var type: String
    private var views: Int
    private var vote: String?
    private var width: Int
    
    init(imageObj: [String: Any]) {
        self.account_id = imageObj["account_id"] as? String
        self.account_url = imageObj["account_url"] as? String
        self.ad_type = imageObj["ad_type"] as! Int
        self.ad_url = imageObj["ad_url"] as! String
        self.animated = imageObj["animated"] as! Int
        self.bandwidth = imageObj["bandwidth"] as! Int
        self.datetime = imageObj["datetime"] as! Int
        self.description = imageObj["description"] as? String
        self.favorite = imageObj["favorite"] as! Int
        self.has_sound = imageObj["has_sound"] as! Int
        self.height = imageObj["height"] as! Int
        self.id = imageObj["id"] as! String
        self.in_gallery = imageObj["in_gallery"] as! Int
        self.in_most_viral = imageObj["in_most_viral"] as! Int
        self.is_ad = imageObj["is_ad"] as! Int
        self.link = imageObj["link"] as! String
        self.nsfw = imageObj["nsfw"] as? String
        self.section = imageObj["section"] as? String
        self.size = imageObj["size"] as! Int
        self.tags = imageObj["tags"] as! [String]
        self.title = imageObj["title"] as? String
        self.type = imageObj["type"] as! String
        self.views = imageObj["views"] as! Int
        self.vote = imageObj["vote"] as? String
        self.width = imageObj["width"] as! Int
    }
}
