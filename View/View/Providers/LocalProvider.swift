//
//  LocalProvider.swift
//  View
//
//  Created by liza_kaganskaya on 2/22/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import CoreData

class LocalProvider {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    lazy var managedContext = appDelegate!.persistentContainer.viewContext
    
    
    
    func savePlacesToBd(business: [Business]) -> Observable<Bool>{
        deleteData()
        var result :Observable<Bool> = Observable.just(false)
        for item in business {
            
            result =  saveitem(business: item)
            
        }
        
        return result
        
    }
    
    
    
    func saveReviewsToBd(reviews: [Reviews], id:Places) -> Observable<Bool>{
        
        return self.reviewsExict(id: id.id!)
            .flatMap {
                exict -> Observable<Bool> in
                
                if !exict {
                    for item in reviews {
                        return self.saveReview(review: item, id:id)
                    }
                }
                
                return Observable.just(false)
        }

    }
    
    func getReviewsFromBd(isLoaded:Bool,id:Places) -> Observable<[Review]>{
        print(isLoaded)
        
        return Observable<[Review]>.create { observer -> Disposable in
            
            let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: "Review")
            
            fetchRequest.predicate = NSPredicate(format: "placeId == %@", id.id!)
            
            do {
                
                let business  = try self.managedContext.fetch(fetchRequest) as! [Review]
                
                observer.onNext(business  )
                observer.onCompleted()
                
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                observer.onError(error)
            }
            
            return Disposables.create(with: {
            })
        }
        
        
        
    }
    
    func getPlacesFromBd(isLoaded:Bool) -> Observable<[Places]>{
        print(isLoaded)
        
        return Observable<[Places]>.create { observer -> Disposable in
    
            let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        
        do {
            
            let business  = try self.managedContext.fetch(fetchRequest) as! [Places]
           
            observer.onNext(business  )
            observer.onCompleted()
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            observer.onError(error)
        }
        
            return Disposables.create(with: {
            })
        }
        
       
        
    }
    
    private func deleteData(){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all my data in error : \(error) \(error.userInfo)")
        }
        
    }
//    private func deleteRevData(){
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Review")
//        fetchRequest.returnsObjectsAsFaults = false
//
//        do
//        {
//            let results = try managedContext.fetch(fetchRequest)
//            for managedObject in results
//            {
//                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
//                managedContext.delete(managedObjectData)
//            }
//        } catch let error as NSError {
//            print("Detele all my data in error : \(error) \(error.userInfo)")
//        }
//
//    }
    
    private func saveitem(business: Business) -> Observable<Bool>{
        
    
        do {
            
                let entity =  NSEntityDescription.entity(forEntityName: "Places",in: managedContext)!
                
                let busines = NSManagedObject(entity: entity,insertInto: managedContext) as! Places
        
                    busines.id = business.id
            
                    busines.image_url = business.image_url!
            
                    busines.name = business.name
            
                    busines.url = business.url

                
                do {
                    try managedContext.save()
                    return Observable.just(true)
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                    return Observable.just(false)
                }
                
            
            
        
        return Observable.just(false)
        
        }}


    
    private func saveReview(review: Reviews, id:Places) -> Observable<Bool>{
        
        
        do {
     
            
            let entity =  NSEntityDescription.entity(forEntityName: "Review",in: managedContext)!
            
            let busines = NSManagedObject(entity: entity,insertInto: managedContext) as! Review
            
            busines.text = review.text
            
            busines.placeId = id.id
            
            do {
                try managedContext.save()
                return Observable.just(true)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                return Observable.just(false)
            }
            
            
                
        
            
            
            return Observable.just(false)
            
            }}
    
    
    func setUserData(username:String, password:String){
        
        let admin = MyUser(username: " ",password: " ")
        
        admin.password = password
        admin.username = username
        
        let archivedAdmin:Data = NSKeyedArchiver.archivedData(withRootObject: admin)
        UserDefaults.standard.set(archivedAdmin, forKey: "savedUserSession")
        UserDefaults.standard.synchronize()
        
    }
    
    
    func getLoginData() -> Observable<MyUser>{
        
        //while no server part implemented
        setUserData(username: "admin", password: "admin")
        
        return Observable<MyUser>.create { observer -> Disposable in
            do{
                let decoded  =  try UserDefaults.standard.object(forKey: "savedUserSession") as! Data
                let decodedUser =  try NSKeyedUnarchiver.unarchiveObject(with: decoded) as! MyUser
            
                    observer.onNext(decodedUser)
                    observer.onCompleted()
            
            } catch let error as NSError{
                print(error)
                observer.onError(error as Error)
            } catch {
                print("error")
            }
            
            
            return Disposables.create(with: {
            })
        }

    }
    
    func logedIn() ->Observable<Bool>{
        return Observable.just(UserDefaults.standard.isLoggedIn() ? true : false)
    }
    
    func setLogIn() -> Observable<Bool>{
        return Observable.just(UserDefaults.standard.setIsLoggedIn(value: true))
    }
    
    func reviewsExict(id:String) -> Observable<Bool> {
        
        let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: "Review")
        
        fetchRequest.predicate = NSPredicate(format: "placeId == %@", id)
        
        var result :Observable<Bool> = Observable.just(false)
        
        do {
            
            let fetchRes  = try self.managedContext.fetch(fetchRequest) as! [Review]
            
            if fetchRes.count == 0{
                result = Observable.just(false)
            }else{
                result = Observable.just(true)
            }
            
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return result
    }
    
}
