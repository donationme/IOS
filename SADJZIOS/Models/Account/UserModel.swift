//
//  UserModel.swift
//  SADJZIOS
//
//  Created by Afshawn Lotfi on 12/4/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation



/**
 * The enum User type.
 */
public enum UserType :String, CaseIterable, Codable{
    /**
     * Admin user type.
     */
    case Admin
    /**
     * User user type.
     */
    case User
    /**
     * Location employee user type.
     */
    case LocationEmployee
    /**
     * Manager user type.
     */
    case Manager
}




public class UserModel:Codable{

    let name : String
    let email : String
    let userType : UserType
    
    init(name : String, email : String, uType : UserType) {
        self.name = name;
        self.email = email;
        self.userType = uType;
    }

    
}
