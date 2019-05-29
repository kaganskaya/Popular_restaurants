//
//  Router.swift
//  View
//
//  Created by liza_kaganskaya on 2/12/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation
import UIKit


/*
 class that will route to entity
 */
class Router {
    
    
    
    // show master
    static func presentRootScreen(in window: UIWindow!){
        
        window.makeKeyAndVisible()
         window.rootViewController = MasterCreatorImpl.assembleModule()

    }
    
    //navigate to master
    static func presentMainScreen(current: UIViewController?) {
        let masterController = MasterCreatorImpl.assembleModule()
        current?.present(masterController, animated: true)
    }
    
    
    //navigate to master
    static func presentLoginScreen(current: UIViewController?) {
        let masterController = LoginCreatorImpl.assembleModule()
        current?.present(masterController, animated: true)
    }
    
    
    //navigate to master
    static func presentDetailScreen(current: UIViewController?, id: Places) {
        let detailController : DetailViewController = DetailCreatorImpl.assembleModule() as! DetailViewController
            detailController.id = id
        current?.navigationController?.pushViewController(detailController, animated: true)
    }

    
}
