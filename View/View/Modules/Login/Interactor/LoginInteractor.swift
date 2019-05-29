//
//  LoginInteractor.swift
//  View
//
//  Created by liza_kaganskaya on 2/22/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation
import RxSwift
import MapKit

class LoginInteractorImpl: LoginInteractor {
    
    
    
    var myRepository: Repository!
    
    init(myRepository: Repository!){
        self.myRepository = myRepository
    }
    
    
    func getLoginData() -> Observable<MyUser> {
        return myRepository!.getLoginData()
    }
    
    
    func logIn(username: String, password: String) -> Observable<Bool> {
        return myRepository.setLogIn()
    }
    
    
}
