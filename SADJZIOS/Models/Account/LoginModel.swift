//
//  LoginModel.swift
//  SADJZIOS
//
//  Created by Afshawn Lotfi on 12/4/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation


public class LoginModel:Codable {
    let username : String;
    let password : String;

    init(userName : String, password : String){
        self.username = userName
        self.password = password
    }
}
