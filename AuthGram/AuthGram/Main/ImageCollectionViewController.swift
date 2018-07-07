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
    var imageList = Array<ImgurImage>()
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
        return self.imageList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        
        // Get current imageCell obj //
        let currentImageCell = self.imageList[indexPath.row]
        
        cell.initCell(image: currentImageCell)
        
        return cell
    }
    
    //-- Tab bar helpers --//
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Starting auth view..")
        
        if loggedIn {
            guard let uploadImgVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UploadImageController") as? UploadImageViewController else {
                print("UploadImageVC was nil. Returning.")
                return
            }
            
            uploadImgVC.imageTableRef = self
            present(uploadImgVC, animated: true) {
                print("uploadImgVC presented.")
            }
        } else {
            guard let authVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AuthController") as? AuthViewController else {
                print("AuthVC was nil. Returning.")
                return
            }
            
            self.navigationController?.pushViewController(authVC, animated: true)
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
        // Download images, async and set in array //
        images.forEach({ (image) in
            guard let imageUrl = URL(string: image.link) else {
                return
            }
            
            image.image_data = try? Data(contentsOf: imageUrl)
            self.imageList.insert(image, at: 0)
        })
        
        DispatchQueue.main.async {
            if let uploadImageVC = self.presentedViewController as? UploadImageViewController {
                // Update received, close the modal after upload //
                print("Upload finished. Closing VC.")
                uploadImageVC.dismiss(animated: true, completion: {
                    print("dismissed")
                })
            }
            
            self.collectionView?.reloadData()
        }
    }
}
