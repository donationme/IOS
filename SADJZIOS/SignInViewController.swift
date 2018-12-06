//
//  SignInViewController.swift
//  SADJZIOS
//
//  Created by Afshawn Lotfi on 12/5/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//


import UIKit

class  SignInViewController: UIViewController {
    
    @IBAction func signInButton(_ sender: UIButton) {
    
        let rest = RestInterfacer<TokenModel,LoginModel>()
        if let userName = userNameText.text, let password = passwordText.text{

            let loginModel = LoginModel(userName: userName, password: password)
            rest.postRequest(endpoint: RestEndpoints.Token, model: loginModel, args: nil, token: nil){ response, error in
                if let token = response {
                    TokenInterfacer.setToken(token: token)
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "TabbedViewController")
                        self.present(vc, animated: true)
                    }
                    
                } else {
                    print(error ?? "")
                }
            }
        }
    
    }
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        
        
    }
    
    
}

