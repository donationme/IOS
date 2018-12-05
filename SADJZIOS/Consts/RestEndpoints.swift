//
//  RestEndpoints.swift
//  SADJZIOS
//
//  Created by Afshawn Lotfi on 12/4/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation

/**
 * The enum Rest endpoints.
 */
public enum RestEndpoints: String {
    /**
     * Account rest endpoints.
     */
    case Account = "api/account"
    /**
     * Token rest endpoints.
     */
    case Token = "api/token"
    /**
     * Region rest endpoints.
     */
    case Region = "api/region"
    /**
     * Add donation item rest endpoints.
     */
    case AddDonationItem = "api/donationItem/add"
    /**
     * Edit donation item rest endpoints.
     */
    case EditDonationItem = "api/donationItem/edit"
    /**
     * Remove donation item rest endpoints.
     */
    case RemoveDonationItem = "api/donationItem/remove"
    /**
     * Search all name rest endpoints.
     */
    case SearchAllName = "api/search/all/name"
    /**
     * Search all category rest endpoints.
     */
    case SearchAllCategory = "api/search/all/category"
    /**
     * Search specific name rest endpoints.
     */
    case SearchSpecificName = "api/search/specific/name"
    /**
     * Search specific category rest endpoints.
     */
    case SearchSpecificCategory = "api/search/specific/category"
    
    
}



