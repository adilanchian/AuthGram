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
        // Check to see if request is nil //
        guard let url = self.urlComponents.url else {
            print("URL is nil. Returning.")
            return
        }
        
        // Set method //
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Make request //
        let task = self.session.dataTask(with: request) {
            (responseData, response, error) in
            
            // Check for errors //
            if let foundError = error {
                print("An error occured during the test case: \(foundError)")
                return
            }
            
            // Get response data //
            if let data = responseData {
                if let strResponse = String(data: data, encoding: String.Encoding.utf8) {
                    print("Request was successful: \(strResponse)")
                } else {
                    print("Request was successful, but could not parse out string response.")
                }
            }
        }
        
        // If task becomes suspended, resume //
        task.resume()
    }
}
