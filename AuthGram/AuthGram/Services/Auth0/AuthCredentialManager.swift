//
//  CredentialManager.swift
//  AuthGram
//
//  Created by Alec Dilanchian on 7/6/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import Foundation
import Auth0

class AuthCredentialManager {
    //-- Properties -- //
    var manager: CredentialsManager!
    
    init() {
        self.manager = CredentialsManager(authentication: Auth0.authentication())
    }
    
    private func getUserCreds(callback: @escaping (_ creds: Credentials) -> ()) {
        self.manager.credentials { error, credentials in
            guard error == nil, let credentials = credentials else {
                // Handle error
                print("Error: \(error)")
                return
            }
            // You now have a valid credentials object, you might want to store this locally for easy access.
            // You will use this later to retrieve the user's profile
            callback(credentials)
        }
    }
    
    func getUserProfile() {
        self.getUserCreds { (creds) in
            Auth0
                .authentication()
                .userInfo(withAccessToken: creds.accessToken!)
                .start { result in
                    switch(result) {
                    case .success(let profile):
                        // You've got the user's profile, good time to store it locally.
                    // e.g. self.profile = profile
                        print(profile.name)
                    case .failure(let error):
                        // Handle the error
                        print("Error: \(error)")
                    }
            }
        }
    }
}
