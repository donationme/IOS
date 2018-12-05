//
//  ViewController.swift
//  SADJZIOS
//
//  Created by Afshawn Lotfi on 12/4/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let rest = RestInterfacer<UserModel>();
        rest.getRequest(endpoint: RestEndpoints.Account, args: nil, token: String("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBZnNoYXduIiwiVXNlcm5hbWUiOiJhZnNoYXduQGcuY29tIiwiVHlwZSI6IlVzZXIiLCJlbWFpbCI6ImFmc2hhd25AZy5jb20iLCJqdGkiOiIzNDhlNjE1My1lOWJhLTQyOWYtOTA0Ny0yZDE3ZTBkMWQ0YWYiLCJleHAiOjE1NDM5NzY3NTUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NjM5MzkvIiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo2MzkzOS8ifQ.tZb0WEQHEqWFkK_3Ka33cLOoryqUG6YIpP8FMz_14uo") ){ response, error in
            if let response:UserModel = response {
                print(response.email)
                    // use totalTime here
                } else {
                    // handle error
                }
            }
            
            
        }


}

