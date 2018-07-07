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
    
    //-- Properties --//
    var manager: CredentialsManager!
    var delegate: AuthHandlerDelegate? = nil
    
    init() {
        self.manager = CredentialsManager(authentication: Auth0.authentication())
    }
    
    private func getUserCreds(callback: @escaping (_ creds: Credentials) -> ()) {
        self.manager.credentials { error, credentials in
            guard error == nil, let credentials = credentials else {
                // Handle error //
                print("Error: \(error?.localizedDescription)")
                return
            }
            callback(credentials)
        }
    }
    
    func getUserProfile() {
        self.getUserCreds { (creds) in
            // Check for access token //
            guard let accessToken = creds.accessToken else {
                print("Access token for user was nil. Returning.")
                return
            }
            
            Auth0
                .authentication()
                .userInfo(withAccessToken: accessToken)
                .start { result in
                    switch(result) {
                        case .success(let profile):
                            // Did get profile successfully //
                            let user = User(user: profile)
                            self.delegate?.didGetUserProfile(user: user)
                    case .failure(let error):
                        // Handle the error
                        print("Error: \(error)")
                    }
            }
        }
    }
}
