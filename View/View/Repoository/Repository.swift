//
//  Repository.swift
//  View
//
//  Created by liza_kaganskaya on 2/14/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import MapKit

class Repository {
    
    var util = LocationUtil()
    
    var globalpr = GlobalProvider()
    
    var localProvider = LocalProvider()
    
    init (util: LocationUtil, glob:GlobalProvider){
        self.util = util
        self.globalpr = glob        
    }
    
    func findPlaces(city:String) -> Observable<[Business]>{
        
      
            return  util.getLocationByCityName(city: city)
            .flatMap({ location in
               
                    self.globalpr.getPlaces(coord: location)
                
            })
        
            
       
    }
    
    func getReviewsFromBd(isLoaded:Bool,id:Places) -> Observable<[Review]>{
        return self.localProvider.getReviewsFromBd(isLoaded:isLoaded,id:id)
        
        
    }
    
    func getReviews(id:String) -> Observable<[Reviews]>{
        return self.globalpr.getReviews(id:id)
        
        
    }
    
    func saveReviews(reviews:[Reviews],id:Places) -> Observable<Bool>{
        return self.localProvider.saveReviewsToBd(reviews:reviews, id:id)
        
    }
    
    func getPlacesFromBd(isLoaded:Bool) -> Observable<[Places]>{
        
        return self.localProvider.getPlacesFromBd(isLoaded:isLoaded)
        
    }
    
    func savePlaces(business:[Business]) -> Observable<Bool> {
        
           return self.localProvider.savePlacesToBd(business: business)
//            .flatMap {
//                isSaved -> Observable<Bool> in
//
//                if isSaved {
//                    return Observable.just(true)
//                }
//
//                return Observable.just(false)
//
//            }
//
    }
    
    func getDescription(link:String) -> Observable<String>{
        return self.globalpr.getDescription(link: link)
        
    }
    
    func isLogedIn() -> Observable<Bool>{
        return self.localProvider.logedIn()
    }
    
    func getLoginData() -> Observable<MyUser> {
        return self.localProvider.getLoginData()
    }
    
    func setLogIn() -> Observable<Bool>{
        return self.localProvider.setLogIn()
    }
}
