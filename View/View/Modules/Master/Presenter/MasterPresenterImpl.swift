//
//  MasterPresenterImpl.swift
//  View
//
//  Created by liza_kaganskaya on 2/12/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation
import RxSwift
import MapKit

class MasterPresenterImpl: MasterPresenter {
    
    
    
    var networkInteractor: NetworkInteractor!
    
    var storageInteractor: StorageInteractor!
    
    weak var view: MasterView?
    
    private var disposeBag = DisposeBag()
    
    
    
    func loadData(city: String) -> Observable<[Places]> {
        return self.networkInteractor.checkInternet()
            .flatMap {
                isInternet -> Observable<Bool> in
                
                if isInternet {
                   return self.uploadFromInternet(city: city)
                }
                
                return Observable.just(false)
            }
            .flatMap { isDataUpdated in
                self.storageInteractor.getFromStorage(isSucLoaded: isDataUpdated)
        }
    }
    
    
    func uploadFromInternet(city: String) -> Observable<Bool> {
        
        return self.networkInteractor.findPlaces(city: city).flatMap { result in
            self.storageInteractor.saveInStorage(business: result)
        }
        
    }
    
    
    func findBusiness(city: String) {
        
        self.loadData(city: city)
            .subscribe(
                    onNext: { (n) in
                      
                            self.view?.showBusiness(business: n)
                    }, onError: { (error) in
                       
                    }, onCompleted: {
                        //print(" onCompleted")
                    }, onDisposed: {
                        //print("onDisposed")
                    }).disposed(by: disposeBag)
    
    }
    func logout(){
        
        storageInteractor.isLogedIn()
            .subscribe(
            onNext: { (n) in
                
                self.view?.showLogin(status: n)
        }, onError: { (error) in
            
        }, onCompleted: {
            //print(" onCompleted")
        }, onDisposed: {
            //print("onDisposed")
        }).disposed(by: disposeBag)
        
        
    }
    
    func onViewDidLoad() {
        
       
        
    }
    
   
    
    
}
