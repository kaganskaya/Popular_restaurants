//
//  LoginCreator.swift
//  View
//
//  Created by liza_kaganskaya on 2/22/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation
import UIKit

/*
 detail
 */
class LoginCreatorImpl: BaseCreator {
    
    
    
    
    static func getControllerIndifier() -> String {
        return "LoginController"
    }
    
    static func getStoryBoardName() -> String {
        return "LoginView"
    }
    
    
    
    static func assembleModule() -> UIViewController {
        
        let view = getSelfUIViewController() as! LoginConroller
        
        let lcu = LocationUtil()
        
        let glp = GlobalProvider()
        
        let rep  = Repository(util:lcu,glob:glp)
        
        let presenter = LoginPresenterImpl()
        
        let interactor = LoginInteractorImpl(myRepository: rep)
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        
        
        
        return view
    }
}
