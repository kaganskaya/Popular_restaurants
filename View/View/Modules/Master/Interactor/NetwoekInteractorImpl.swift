//
//  NetwoekInteractorImpl.swift
//  View
//
//  Created by liza_kaganskaya on 2/24/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class NetwoekInteractorImpl:NetworkInteractor {
   

    
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
    
    func findPlaces(city: String) -> Observable<[Business]> {
        return myRepository.findPlaces(city: city)
    }
    
}
