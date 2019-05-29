//
//  Reviews.swift
//  View
//
//  Created by liza_kaganskaya on 2/18/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation


struct Reviews: Codable {
    let id: String
    let url: String
    let text: String
    let rating: Int
    let time_created: String
    let user: User
}

struct User: Codable {
    let id: String
    let profile_url: String
    let image_url: String
    let name: String
    

}
