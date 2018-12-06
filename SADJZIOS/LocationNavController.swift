//
//  LocationViewController.swift
//  SADJZIOS
//
//  Created by Afshawn Lotfi on 12/5/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit


class LocationNavController: UINavigationController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func displayLocation(locationModel : LocationModel){
        
        if let locationViewController = self.viewControllers.first as? LocationViewController{
            locationViewController.setLocation(locationModel: locationModel)
        }

    }
    
}

