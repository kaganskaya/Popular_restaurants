//
//  LoginPresenterImpl.swift
//  View
//
//  Created by liza_kaganskaya on 2/22/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation
import RxSwift
import MapKit

class LoginPresenterImpl: LoginPresenter{
    
    var view: LoginView?
    
    var interactor: LoginInteractor!
    
    private var disposeBag = DisposeBag()

    
    func getLoginData() {
        interactor.getLoginData()
            .subscribe(
                onNext: { (n) in
                    self.view?.loginData(user: n)
            }, onError: { (error) in
                print("-> \(error.localizedDescription)")
            }, onCompleted: {
                print(" onCompleted")
            }, onDisposed: {
                print("onDisposed")
            }).disposed(by: disposeBag)
    }
    
    func onViewDidLoad() {}
    
    
    
    
    func logIn(username: String, password: String) {
        
        interactor.logIn(username:username,password:password)
            .subscribe(onNext: { (n) in
                self.view?.presentMainScreen()
            }).disposed(by: disposeBag)
    }
    
    
    
    
}



