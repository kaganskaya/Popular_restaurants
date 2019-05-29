//
//  LocationUtil.swift
//  ABProject
//
//  Created by Eddson on 06.02.2019.
//  Copyright © 2019 Eddson. All rights reserved.
//

import Foundation
import MapKit
import RxSwift

class LocationUtil{
    
   
    
    
    func getLocationByCityName(city: String) -> Observable<CLLocationCoordinate2D>{
     
        return Observable<CLLocationCoordinate2D>.create { observer -> Disposable in
            
            let serachRequest = MKLocalSearch.Request()
                serachRequest.naturalLanguageQuery = city
            
            
            let request = MKLocalSearch(request: serachRequest)
                request.start { (response,error) in
                
                
                if response == nil {
                    let error : NSError = NSError(
                        domain: "LocationUtil",
                        code: -2,
                        userInfo: [NSLocalizedDescriptionKey:"can't get city location "])
                    
                        observer.onError(error)
                }else{
                        observer.onNext((response?.boundingRegion.center)!)
                        observer.onCompleted()
                }
            }

            
            
            return Disposables.create(with: {
                request.cancel()
            })
        
        }
    }
    
}
