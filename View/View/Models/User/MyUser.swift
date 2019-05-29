//
//  User.swift
//  View
//
//  Created by liza_kaganskaya on 2/22/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation

class MyUser:NSObject, NSCoding {
    
    var username:String = ""
    var password:String = ""
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let password = aDecoder.decodeObject(forKey: "password") as! String
        let username = aDecoder.decodeObject(forKey: "username") as! String
        self.init(username: username, password: password)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(username, forKey: "username")
        aCoder.encode(password, forKey: "password")
    }
    
}
