//
//  ServiceHandler.swift
//  AuthGram
//
//  Created by Alec Dilanchian on 4/29/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import Foundation

/*
    Struct coming soon! We need to create a model for our data to deserialize to
*/

class ServiceHandler {
    // Properties //
    fileprivate var urlComponents: URLComponents
    fileprivate var session: URLSession
    fileprivate let endpointPath = "/api/v1"
    
    init() {
        self.urlComponents = URLComponents()
        self.urlComponents.scheme = "http"
        self.urlComponents.host = "127.0.0.1"
        self.urlComponents.port = 8000
        self.urlComponents.path = "/"
        self.session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    // Test request method //
    public func testRequest() {
        guard let task = createRequestTask(method: "GET", endpoint: "/") else {
            print("Request task could not be completed. Returning")
            return
        }
        
        // If task becomes suspended, resume //
        task.resume()
    }
    
    // GET api/v1/images //
    
    public func getImages() {
        guard let task = createRequestTask(method: "GET", endpoint: "\(self.endpointPath)/images") else {
            print("Request task could not be completed. Returning")
            return
        }
        
        // If task becomes suspended, resume //
        task.resume()
    }
    
    private func createRequestTask(method: String, endpoint: String) -> URLSessionTask? {
        // Set endpoint path //
        self.urlComponents.path = endpoint
        
        // Check to see if request is nil //
        guard let url = self.urlComponents.url else {
            print("URL is nil. Returning.")
            return nil
        }
        
        // Set method //
        var request = URLRequest(url: url)
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
                    
                    // Check for data key //
                    if let images = json!["data"] as? [String: Any] {
                        // Convert to Custom Image class and send to collection view //
                        let imgurImage = ImgurImage(imageObj: images)
                        print(imgurImage)
                    } else {
                        print(json)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
