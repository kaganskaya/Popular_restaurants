//
//  StorageInteractorImpl.swift
//  View
//
//  Created by liza_kaganskaya on 2/24/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation
import RxSwift

class StorageInteractorImpl:StorageInteractor {
    
    
    var myRepository: Repository!
    
    
    
    init (repository:Repository){
        self.myRepository = repository
    }
    
    func saveInStorage(business: [Business]) -> Observable<Bool> {
        return myRepository.savePlaces(business:business)
    }
    
    func getFromStorage(isSucLoaded: Bool) -> Observable<[Places]> {
        return myRepository.getPlacesFromBd(isLoaded:isSucLoaded)
    }
    
    func isLogedIn() ->Observable<Bool> {
        return myRepository.isLogedIn()
        
    }
    
    
}
