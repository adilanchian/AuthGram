//
//  ServiceHandler.swift
//  AuthGram
//
//  Created by Alec Dilanchian on 4/29/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import Foundation
import UIKit

/*
    Struct coming soon! We need to create a model for our data to deserialize to
*/

class ServiceHandler {
    // Properties //
    fileprivate var urlComponents: URLComponents
    fileprivate var session: URLSession
    fileprivate let endpointPath = "/api/v1"
    var delegate: ImageHandlerDelegate? = nil
    
    init() {
        self.urlComponents = URLComponents()
        self.urlComponents.scheme = "http"
        self.urlComponents.host = "127.0.0.1"
        self.urlComponents.port = 8000
        self.urlComponents.path = "/"
        self.session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    // Test request method //
    func testRequest() {
        guard let task = createRequestTask(method: "GET", endpoint: "/", dataString: nil, username: nil) else {
            print("Request task could not be completed. Returning")
            return
        }
        
        // If task becomes suspended, resume //
        task.resume()
    }
    
    // GET api/v1/images //
    
    func getImages() {
        guard let task = createRequestTask(method: "GET", endpoint: "\(self.endpointPath)/images", dataString: nil, username: nil) else {
            print("Request task could not be completed. Returning")
            return
        }
        
        // If task becomes suspended, resume //
        task.resume()
    }
    
    func postImage(base64Img: String, username: String) {
        print("Starting post image request...")
        
        guard let task = createRequestTask(method: "POST", endpoint: "\(self.endpointPath)/image", dataString: base64Img, username: username) else {
            print("Request task could not be completed. Returning")
            return
        }
        
        task.resume()
    }
    
    private func createRequestTask(method: String, endpoint: String, dataString: String?, username: String?) -> URLSessionTask? {
        // Set endpoint path //
        self.urlComponents.path = endpoint
        
        // Check to see if request is nil //
        guard let url = self.urlComponents.url else {
            print("URL is nil. Returning.")
            return nil
        }
        
        var request = URLRequest(url: url)
        
        // Check for data //
        if let bodyData = dataString {
            print("Data passed in.")
            
            do {
                let imgBody = ["image":["username": username, "content_type": "image/jpeg","file_data": bodyData]]
                
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = try JSONSerialization.data(withJSONObject: imgBody, options: .prettyPrinted)
                
                print("Request body generated.")
            } catch {
                 print(error.localizedDescription)
            }
        }
        
        // Set method //
        request.httpMethod = method
        
        // Make request //
        return self.session.dataTask(with: request) {
            (responseData, response, error) in
            
            // Check for errors //
            if let foundError = error {
                print("An error occured during the test case: \(foundError)")
                return
            }
            
            // Get response data //
            if let data = responseData {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    
                    // Get Images From Album Response //
                    if let images = json!["data"] as? Array<AnyObject> {
                        var finalImages = Array<ImgurImage>()
                        
                        // Get length of images array //
                        images.forEach({ (image) in
                            // Convert to Custom Image class and send to collection view //
                            let imgurImage = ImgurImage(imageObj: image as! [String: Any])
                            finalImages.append(imgurImage)
                        })
                        
                        self.delegate?.didReceiveImages(images: finalImages)
                    } else {
                        // Errors || Upload Image Response //
                        if let data = json!["data"] {
                            let dataObj = data as AnyObject
                            
                            if let error = dataObj.error as? String {
                                print("StatusCode \(json!["status"] as! Int): \(error)")
                            } else {
                                print("StatusCode \(json!["status"] as! Int): \(dataObj)")
                                
                                // Convert Image //
                                let newImage = ImgurImage(imageObj: dataObj as! [String : Any])
                                self.delegate?.didReceiveImages(images: [newImage])
                            }
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
