//
//  Place.swift
//  View
//
//  Created by liza_kaganskaya on 2/12/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//




import Foundation
import CoreData

struct Business: Codable {
    
    let id:String?
    let alias: String?
    let name: String?
    let image_url:String?
    let is_closed: Bool?
    let url: String?
    let review_count: Int?
    let categories: [Category]?
    let rating: Double?
    let coordinates: Center?
    let transactions: [String]?
    let price: Price?
    let location: Location?
    let phone: String?
    let displayPhone: String?
    let distance: Double?
    
    
}

struct Category: Codable {
    let alias, title: String
}

struct Center: Codable {
    let latitude, longitude: Double
}

struct Location: Codable {
    let address1: String?
    let address2: String?
    let address3: String?
    let city: String?
    let zipCode: String?
    let country: String?
    let state: String?
    let displayAddress: [String]?
    
   
}


enum Price: String, Codable {
    case empty = "$"
    case price = "$$"
    case purple = "$$$"
}

