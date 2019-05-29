//
//  StorageReviewsInteractorInpl.swift
//  View
//
//  Created by liza_kaganskaya on 2/28/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class StorageReviewsInteractorInpl: StorageReviewsInteractor{
  
    
    var myRepository: Repository!
    
    init (repository:Repository){
        self.myRepository = repository
    }
    
    func saveInStorage(reviews: [Reviews], id:Places) -> Observable<Bool> {
        
        return myRepository.saveReviews(reviews: reviews, id:id)
    }
    
    func getFromStorage(isSucLoaded: Bool,id:Places) -> Observable<[Review]> {
        return myRepository.getReviewsFromBd(isLoaded:isSucLoaded,id:id)
    }
    
    
    
}
