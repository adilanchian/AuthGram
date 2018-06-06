//
//  ImageCollectionViewController.swift
//  AuthGram
//
//  Created by Alec Dilanchian on 5/7/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ImageCell"

class ImageCollectionViewController: UICollectionViewController, UITabBarDelegate, ImageHandlerDelegate {
    //-- Properties --//
    var images = Dictionary<String, Any>()
    let tabBar = UITabBar()
    // TODO: REMOVE TEST PROP //
    var loggedIn = true
    let serviceHandler = ServiceHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get images //
        serviceHandler.delegate = self
        serviceHandler.getImages()
        
        // Setup tab bar //
        self.initTabBar()
        self.view.addSubview(self.tabBar)
    }

    //-- UICollectionViewDataSource --//
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // Will always return one section, as we want a long scrolling list //
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // This will be the number of images we receive from the database //
        return self.images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        
        // Get current imageCell obj //
        let currentImageCell = Array(self.images.values)[indexPath.row] as! Dictionary<String, Any>
        
        cell.initCell(image: currentImageCell)
        
        return cell
    }
    
    //-- Tab bar helpers --//
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Starting auth view..")
        var controller: UIViewController?
        
        if loggedIn {
            controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UploadImageController") as? UploadImageViewController
        } else {
            controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AuthController") as? AuthViewController
        }
  
        
        if controller != nil {
            self.present(controller!, animated: true) {
                print("VC presented")
            }
        } else {
            print("Something went wrong and VC is nil.")
        }
    }
    
    private func initTabBar() {
        // Init tab bar delegate //
        self.tabBar.delegate = self
        
        // Setup background color, size and position //
        self.tabBar.backgroundColor = UIColor(red:0.65, green:0.65, blue:0.65, alpha:0.1)
        self.tabBar.frame = CGRect.init(x: 0, y: self.view.frame.height - 45, width: self.view.frame.width, height: 90)
        
        // Add camera image to tab bar //
        let barItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "camera"), tag: 1)
        self.tabBar.setItems([barItem], animated: true)
        
    }
    
    //-- Delegate --//
    func didReceiveImages(images: Array<ImgurImage>) {
        print("In delegate call")
        // Download images, async and set in array //
        DispatchQueue.global(qos: .userInitiated).async {
            images.forEach({ (image) in
                if let imageUrl = URL(string: image.link) {
                    let imageData = try? Data(contentsOf: imageUrl)
                    
                    DispatchQueue.main.async {
                        if imageData != nil {
                            self.images[image.id] = ["dateTime": image.datetime, "image": UIImage(data: imageData!)!]
                            self.collectionView?.reloadData()
                        }
                    }
                }
            })
        }
    }
}
