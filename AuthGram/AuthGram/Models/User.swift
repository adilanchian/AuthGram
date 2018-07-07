//
//  User.swift
//  AuthGram
//
//  Created by Alec Dilanchian on 7/6/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import Foundation
import Auth0

class User {
    var nickname: String!
    
    init(user: UserInfo) {
        self.nickname = user.nickname
    }
}
