//
//  DonationItemModel.swift
//  SADJZIOS
//
//  Created by Afshawn Lotfi on 12/4/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation

public enum ItemCategory:Int, CaseIterable, Codable{
    /**
     * Food item category.
     */
    case Food
    /**
     * Clothing item category.
     */
    case Clothing
    /**
     * Furniture item category.
     */
    case Furniture
    /**
     * Drink item category.
     */
    case Drink
    /**
     * Accessory item category.
     */
    case Accessory
    /**
     * Electronics item category.
     */
    case Electronics
    /**
     * Other item category.
     */
    case Other


}



public class DonationItemModel: Codable {

    
    let name:String;
    
    let description: String;
    
    let quantity: Int;
    
    let category:ItemCategory;
    
    let id:String;
    
    let time:String;
    
    let locationId: String;

    init(name:String,
         description: String,
         quantity: Int,
         category:ItemCategory,
         id:String,
         time:String,
         locationId: String){
        self.name = name;
        self.description = description;
        self.quantity = quantity;
        self.category = category;
        self.id = id;
        self.time = time
        self.locationId = locationId;
    }
    

    
}
