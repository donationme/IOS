//
//  LocationModel.swift
//  SADJZIOS
//
//  Created by Afshawn Lotfi on 12/4/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation

public class Coords : Codable{
    let latitude : Double;
    let longitude : Double;

}


public class LocationModel:Codable {


    let key : Int;
    
    let name : String;
    
    let coords : Coords;
    
    let street : String;
    
    let city : String;
    
    let state : String;
    
    let zip: String;
    
    let address: String;
    
    let locationType: String;

    let phone : String;
    
    let website : String ;
    
    let id : String;
    
    let donationItems: [DonationItemModel];
    
    
    
    init(
        key : Int,
        name : String,
        coords : Coords,
        street : String,
        city : String,
        state : String,
        zip: String,
        address: String,
        locationType: String,
        phone : String,
        website : String ,
        id : String,
        donationItems: [DonationItemModel]){
        
        
        self.key = key;
        self.name = name;
        self.coords = coords;
        self.street = street;
        self.city = city;
        self.state = state;
        self.zip = zip;
        self.address = address;
        self.locationType = locationType;
        self.phone = phone;
        self.website = website;
        self.id = id;
        self.donationItems = donationItems;
        
    }
    
    
    
    
}

