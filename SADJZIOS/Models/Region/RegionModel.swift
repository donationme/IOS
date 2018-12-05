//
//  RegionModel.swift
//  SADJZIOS
//
//  Created by Afshawn Lotfi on 12/4/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import Foundation


public class RegionModel:Codable {
    let locations : [LocationModel];
    let regionCoords : Coords;
    let name:String;
    let id:String;
    init(locations : [LocationModel],
         regionCoords : Coords,
         name : String,
         id : String){
        self.locations = locations;
        self.regionCoords = regionCoords;
        self.name = name;
        self.id = id;
    }
}
