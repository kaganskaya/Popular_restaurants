//
//  BaseContract.swift
//  View
//
//  Created by liza_kaganskaya on 2/12/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation
import UIKit

protocol BaseCreator {
    static func assembleModule() -> UIViewController
    static func getControllerIndifier() -> String
    static func getStoryBoardName() -> String
}

extension BaseCreator{
    static func getSelfUIViewController() -> UIViewController{
        let view = UIStoryboard(name: getStoryBoardName(), bundle: nil)
            .instantiateViewController(withIdentifier: getControllerIndifier())
        
        return view
    }
}
