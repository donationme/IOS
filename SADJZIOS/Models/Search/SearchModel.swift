//
//  SearchModel.swift
//  SADJZIOS
//
//  Created by Afshawn Lotfi on 12/4/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation



public class SearchModel : Codable {
    let results : [DonationItemModel];
    
    init(results : [DonationItemModel]){
        self.results = results
    }
}
