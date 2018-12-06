//
//  RegisterViewController.swift
//  SADJZIOS
//
//  Created by Afshawn Lotfi on 12/5/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit

class  RegisterViewController: UIViewController {
    
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var nameText: UITextField!

    @IBOutlet weak var userTypeSeg: UISegmentedControl!
    
    @IBAction func registerBtn(_ sender: Any) {
        let loginModel = LoginModel(userName: self.userNameText.text ?? "", password: self.passwordText.text ?? "")
        let userModel = UserModel(name: self.nameText.text ?? "", email: self.userNameText.text ?? "", uType: UserType.allCases[self.userTypeSeg.selectedSegmentIndex ])
        let accountModel = AccountModel(auth: loginModel, user: userModel)
        let restCreate = RestInterfacer<Dictionary<String, Array<String>>,AccountModel>()


        
        restCreate.postRequest(endpoint: RestEndpoints.Account, model: accountModel, args: nil, token: nil){ response, error in
            if let _ = response {
                
                    let restLogin = RestInterfacer<TokenModel,LoginModel>()
                    
                    
                    restLogin.postRequest(endpoint: RestEndpoints.Token, model: loginModel, args: nil, token: nil){ response, error in
                        if let token = response {
                            DispatchQueue.main.async {

                                TokenInterfacer.setToken(token: token)

                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "TabbedViewController")
                                self.present(vc, animated: true)
                            }
                            
                        } else {
                            print(error ?? "")
                        }
                    }
                    
                
                
            } else {
                print(error ?? "")
            }
        }
    
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
}

