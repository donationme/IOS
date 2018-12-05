//
//  AccountModel.swift
//  SADJZIOS
//
//  Created by Afshawn Lotfi on 12/4/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation


public class AccountModel:Codable {
    let auth : LoginModel;
    let user : UserModel;

    init(auth : LoginModel , user : UserModel){
        self.auth = auth;
        self.user = user;
    }
}
