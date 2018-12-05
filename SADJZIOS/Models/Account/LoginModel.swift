//
//  LoginModel.swift
//  SADJZIOS
//
//  Created by Afshawn Lotfi on 12/4/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation


public class LoginModel:Codable {
    let userName : String;
    let password : String;

    init(userName : String, password : String){
        self.userName = userName
        self.password = password
    }
}
