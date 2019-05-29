//
//  NetworkReviewsInteractorImpl.swift
//  View
//
//  Created by liza_kaganskaya on 2/28/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class NetworkReviewsInteractorImpl: NetworkReviewsInteractor {
   
    
    var myRepository: Repository!
    
    init (repository:Repository){
        self.myRepository = repository
    }
    
    func checkInternet() -> Observable<Bool> {
        if NetworkReachabilityManager()!.isReachable{
            return Observable.just(true)
            
        }else{
            return Observable.just(false)
        }
        
    }
    
    func getReviews(id: String) -> Observable<[Reviews]> {
        return myRepository.getReviews(id: id)
    }
    
    func getDescription(link: String) -> Observable<String> {
        return myRepository.getDescription(link: link)
    }
    
}
