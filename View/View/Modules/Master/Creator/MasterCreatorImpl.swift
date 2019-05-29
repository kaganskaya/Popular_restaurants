//
//  MasterCreatorImpl.swift
//  View
//
//  Created by liza_kaganskaya on 2/12/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation

import UIKit

class MasterCreatorImpl:   BaseCreator {
    
    

    static func getControllerIndifier() -> String {
        return "ViewController"
    }
    
    static func getStoryBoardName() -> String {
        return "Main"
    }
    
    
    static func assembleModule() -> UIViewController {
       
        
        let view = getSelfUIViewController() as! ViewController
        
        let lcu = LocationUtil()
        
        let glp = GlobalProvider()
        
        let rep  = Repository(util:lcu,glob:glp)
        
        let storageInteractor = StorageInteractorImpl(repository: rep)
        
        let networkInteractor = NetwoekInteractorImpl(repository: rep)

        let presenter = MasterPresenterImpl()
        
        let navigation = UINavigationController(rootViewController: view)
        
            navigation.navigationBar.barTintColor = .black
        
            presenter.view = view
        
            presenter.networkInteractor = networkInteractor
        
            presenter.storageInteractor = storageInteractor
        
            view.presenter = presenter
        
        
        return navigation
    }
    
    

}
