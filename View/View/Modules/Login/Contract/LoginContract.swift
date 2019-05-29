//
//  LoginContract.swift
//  View
//
//  Created by liza_kaganskaya on 2/22/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation
import UIKit

import RxSwift
import MapKit

protocol LoginPresenter: class {
    var view: LoginView? { get set }
    var interactor: LoginInteractor! { get set }
    func getLoginData()
    func logIn(username:String,password:String)
    func onViewDidLoad()
}

protocol LoginInteractor: class {
    
    var  myRepository: Repository! {get set}
    func getLoginData() -> Observable<MyUser>
    func logIn(username:String,password:String) -> Observable<Bool>
}

protocol LoginView: class {
    var presenter: LoginPresenter! { get set }
    func loginData(user:MyUser)
    func presentMainScreen() 
}

