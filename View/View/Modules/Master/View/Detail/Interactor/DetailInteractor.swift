//
//  DetailInteractor.swift
//  ABProject
//
//  Created by Eddson on 30.01.2019.
//  Copyright © 2019 Eddson. All rights reserved.
//

import Foundation
import RxSwift
import MapKit

class DetailInteractorImpl: DetailInteractor {
    
    
    var globalProvider: GlobalProvider!
    
    
    init(provider: GlobalProvider!){
        self.globalProvider = provider
    }
    
    func getDataById(id: String) -> Observable<[Reviews]> {
       return globalProvider.getReviews(id: id)
    }
    
    func getDescription(link:String) -> Observable<String> {
        
        return globalProvider.getDescription(link:link)
    }
    
}
