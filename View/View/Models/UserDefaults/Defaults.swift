//
//  Defaults.swift
//  View
//
//  Created by liza_kaganskaya on 2/22/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation

struct Defaults {
    
    
    static let (nameKey, passKey) = ("username", "password")
    
    static let userSessionKey = "com.save.usersession"
    
    
    struct Model {
        var name: String?
        var password: String?
        
        init(_ json: [String: String]) {
            self.name = json[nameKey]
            self.password = json[passKey]
        }
    }

    
    static var saveNameAndPassword = { (name: String, password: String) in
          UserDefaults.standard.set([nameKey: name, passKey: password], forKey: userSessionKey)
    }
    
    static var getNameAndPassword  = { _ -> Model in
        return Model((UserDefaults.standard.value(forKey: userSessionKey) as? [String: String]) ?? [:])
    }(())
    
    static func clearUserData(){
        UserDefaults.standard.removeObject(forKey: userSessionKey)
    }
}
