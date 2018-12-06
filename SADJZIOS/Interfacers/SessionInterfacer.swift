//
//  TokenInterfacer.swift
//  SADJZIOS
//
//  Created by Afshawn Lotfi on 12/5/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation


public class TokenInterfacer{
    
    private static var token : TokenModel? = nil;
    
    static func setToken(token : TokenModel){
        if TokenInterfacer.token == nil{
            TokenInterfacer.token = token;
        }
    }
    
    static func getToken() -> TokenModel?{
        return TokenInterfacer.token;
    }
    
}


public class SessionInterfacer{
    
    private static var userModel : UserModel? = nil;
    
    static func setUser(userModel : UserModel){
        if SessionInterfacer.userModel == nil{
            SessionInterfacer.userModel = userModel;
        }
    }
    
    static func getUser() -> UserModel?{
        return SessionInterfacer.userModel;
    }
    
}

