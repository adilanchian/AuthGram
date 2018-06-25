//
//  UploadImageViewController.swift
//  AuthGram
//
//  Created by Alec Dilanchian on 5/19/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import UIKit
import Photos

class UploadImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //-- Properties --//
    let serviceHandler = ServiceHandler()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewImageView: UIImageView!
    
    @IBAction func close(_ sender: Any) {
        print("Closing upload image VC...")
        
        self.dismiss(animated: true) {
            print("VC closed.")
        }
    }
    
    @IBAction func uploadSelectedImage(_ sender: Any) {
        // Convert to base64 //
        let base64Image = self.toBase64()
        
        // Send body over to ServiceHandler for upload api //
        serviceHandler.postImage(base64Img: base64Image!)
        
        // On success, close view //
        
        // On error, display //
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask permission to use photo library //
        PHPhotoLibrary.requestAuthorization({status in
            if status == .authorized {
                // Open Camera Roll to select photo //
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = .photoLibrary;
                    imagePicker.allowsEditing = true
                    self.present(imagePicker, animated: true, completion: nil)
                }
            } else {
                // Display message saying please activate photo library usage
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //-- Helpers --//
    fileprivate func toBase64() -> String? {
        // Convert uiimage to Data //
        guard let image = self.previewImageView.image else {
            print("Image was nil.")
            return nil
            // Do something to display in UI //
        }
        
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        
        return imageData?.base64EncodedString()
    }
    
    
    //-- Delegate --//
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Image selected.")

        // Convert PHAsset to UIImage //
        if let imageSelected = info["UIImagePickerControllerEditedImage"] as? UIImage {
                self.previewImageView.image = imageSelected
        } else {
            print("ImageFile was nil.")
        }
        
        picker.dismiss(animated: true) {
            print("Image Selected")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            
        }
    }
}
