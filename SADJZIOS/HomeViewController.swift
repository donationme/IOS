//
//  HomeViewController.swift
//  SADJZIOS
//
//  Created by Afshawn Lotfi on 12/5/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit




class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    private var userData : [String:String] = [String:String]()

    
    private let reusable = "aCell";
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return userData.count;
    }


    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: self.reusable)
        let keys =  Array(self.userData.keys)
        let title = keys[indexPath.row]
        cell.detailTextLabel?.text = self.userData[title]
        cell.textLabel?.text = title
        

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.reusable)
        tableView.delegate = self
        tableView.dataSource = self
        

        let rest = RestInterfacer<UserModel,String>()
        TokenInterfacer.setToken(token: TokenModel(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBZnNoYXduIiwiVXNlcm5hbWUiOiJhZnNoYXduMjNAZy5jb20iLCJUeXBlIjoiQWRtaW4iLCJlbWFpbCI6ImFmc2hhd24yM0BnLmNvbSIsImp0aSI6IjUzNTY5OTNhLTU5MmEtNDI3ZS04NDQzLTU3M2Y5YzQ4ZWY3ZCIsImV4cCI6MTU0NDIxMDYwMCwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo2MzkzOS8iLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjYzOTM5LyJ9.5rIljyhoe8-DmP9Cn7Fo8cyzTw3je5d9pjyeZ8eLq04"))
        if let tokenModel = TokenInterfacer.getToken(){
            
            rest.getRequest(endpoint: RestEndpoints.Account, args: nil, token: tokenModel.token){ response, error in
                if let user = response {
                    SessionInterfacer.setUser(userModel: user)
                    DispatchQueue.main.async {
                        self.userData["Name"] = user.name
                        self.userData["Email"] = user.email
                        self.userData["Type"] = user.userType.rawValue
                        self.tableView.reloadData()
                    }
                } else {
                    print(error ?? "")
                }
            }
        }

        

    }
    
    
}

