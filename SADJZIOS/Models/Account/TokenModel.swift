//
//  TokenModel.swift
//  SADJZIOS
//
//  Created by Afshawn Lotfi on 12/4/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation



public class TokenModel:Codable {
    let token : String;
    init(token : String){
        self.token = token
    }
}
