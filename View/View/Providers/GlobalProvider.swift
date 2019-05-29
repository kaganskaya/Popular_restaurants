//
//  GlobalProvider.swift
//  View
//
//  Created by liza_kaganskaya on 2/12/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import MapKit
import SwiftSoup

class GlobalProvider {
    
    
    static let imageCache:NSCache = NSCache<NSString , AnyObject>()
    
    let headers: HTTPHeaders = ["Authorization": "Bearer D1OLBwqLhC5_27J_oSLIjXhAqJs17p6urXveZCxdAyuIQaba9toeFnc1kCWBL8DG9cAsDKsIUX-qki8Ey5fL_eK-XtUQfngg6HSrdWtQmXW4Q4hBOBJ76Z1L-eplXHYx"]
    
    func getPlaces(coord: CLLocationCoordinate2D) -> Observable<[Business]> {
       
        
        let url = "https://api.yelp.com/v3/businesses/search?latitude=\(coord.latitude)&longitude=\(coord.longitude)"
        
        return Observable<[Business]>.create { observer -> Disposable in
            
            let keyList = "businesses"
        
            let request = Alamofire
                
                .request(url, method: .get, headers: self.headers )
                
                .validate()
                
                .responseJSON { response in
                                      
                    let value:  NSDictionary?  = response.result.value as? NSDictionary
                    
                    if let listValues =  value?[keyList] {
                        
                
                        
                        let decoder = JSONDecoder()
                        
                        if let data = try? JSONSerialization.data(withJSONObject: listValues as! NSArray , options:[]){
                            do{
                            
                                let content:[Business] = try decoder.decode([Business].self, from: data)

                                observer.onNext(content)
                                observer.onCompleted()
                                
                            }catch let er as NSError{
                                
                                observer.onError(er)
                            }
                        }else{
                            let error : NSError = NSError(
                                domain: "GlobalProvider",
                                code: -1,
                                userInfo: [NSLocalizedDescriptionKey:"error while serialization"])
                            
                            observer.onError(error)
                        }
                    } else{
                        let error : NSError = NSError(
                            domain: "GlobalProvider",
                            code: -1,
                            userInfo: [NSLocalizedDescriptionKey:"Под данному запросу нету информации"])
                        
                        observer.onError(error)
                    }
                    
            }
            
            
            return Disposables.create(with: {
                request.cancel()
            })
        }
    }
    
    func getReviews(id:String) -> Observable<[Reviews]> {
        

        let url = "https://api.yelp.com/v3/businesses/\(id)/reviews"
        
        return Observable<[Reviews]>.create { observer -> Disposable in
            
            let keyList = "reviews"
            
            let request = Alamofire
                
                .request(url, method: .get, headers: self.headers )
                
                .validate()
                
                .responseJSON { response in
                    
                    let value:  NSDictionary?  = response.result.value as? NSDictionary
                    
                    if let listValues =  value?[keyList] {
                        
                        
                        
                        let decoder = JSONDecoder()
                        
                        if let data = try? JSONSerialization.data(withJSONObject: listValues as! NSArray , options:[]){
                            do{
                                
                                let content:[Reviews] = try decoder.decode([Reviews].self, from: data)
                                print(content)
                                observer.onNext(content)
                                observer.onCompleted()
                            }catch let er as NSError{
                                
                                observer.onError(er)
                            }
                        }else{
                            let error : NSError = NSError(
                                domain: "GlobalProvider",
                                code: -1,
                                userInfo: [NSLocalizedDescriptionKey:"error while serialization"])
                            
                            observer.onError(error)
                        }
                    } else{
                        let error : NSError = NSError(
                            domain: "GlobalProvider",
                            code: -1,
                            userInfo: [NSLocalizedDescriptionKey:"Под данному запросу нету информации"])
                        
                        observer.onError(error)
                    }
                    
            }
            
            
            return Disposables.create(with: {
                request.cancel()
            })
        }
    }
    
    
    func getDescription(link:String) -> Observable<String> {
      
        let url = URL(string:link)


        
         return Observable<String>.create { observer -> Disposable in
          
            do{
                
       
                if let cachedImage = GlobalProvider.imageCache.object(forKey:link as NSString) {
                    observer.onNext(try cachedImage as! String)
                    observer.onCompleted()
                } else {
                    let  html = try String.init(contentsOf: url!)
                    let doc: Document = try SwiftSoup.parse(html)
                    let links: Elements = try doc.select("div.from-biz-owner-content > p")
                    let linkHref = links.first()
                    
                    
                    GlobalProvider.imageCache.setObject( try linkHref?.text() as AnyObject, forKey: link as NSString)
                      //тут есть кеш
                    let test = GlobalProvider.imageCache.object(forKey:link as NSString)
                    print(test)
                    observer.onNext((try linkHref?.text()) ?? "No description yet =((")
                    observer.onCompleted()
                    
               }
                
                
                
            } catch Exception.Error( _, let message){
            print(message)
            observer.onError(message as! Error)
            } catch {
            print("error")
            }
        
    
            
        return Disposables.create(with: {
        })
    }
    
}

    
   
}
