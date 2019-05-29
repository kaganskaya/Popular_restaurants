//
//  LoginConroller.swift
//  View
//
//  Created by liza_kaganskaya on 2/11/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import UIKit

class LoginConroller: UIViewController {
  

    
    @IBOutlet var loginView: MyLoginView!
    var presenter: LoginPresenter!
    
    private var user = MyUser(username: " ", password: " ")
    
 
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
      
        presenter.getLoginData()
        
        loginView.setUserData(userData: self.user)
        
        loginView.setup()

        loginView.completionHandler =
            { username,password in
                
                if  username == "admin" && password == "admin" {
                    self.presenter.logIn(username: username,password: password)
                }
            }
    }
    
    
   
    
    
    
}
extension LoginConroller: LoginView{
    
    func presentMainScreen() {
        Router.presentMainScreen(current: self)
    }
    
    func loginData(user: MyUser) {
        self.user = user
    }
    
}
