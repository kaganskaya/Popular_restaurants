//
//  Interactor.swift
//  View
//
//  Created by liza_kaganskaya on 2/24/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation
import RxSwift

protocol NetworkInteractor: class {
    
    var  myRepository: Repository! {get set}
    func checkInternet() -> Observable<Bool>
    func findPlaces(city:String) -> Observable<[Business]>
}

protocol StorageInteractor: class {
    
    var  myRepository: Repository! {get set}
    func saveInStorage(business:[Business]) -> Observable<Bool>
    func getFromStorage(isSucLoaded:Bool) -> Observable<[Places]>
    func isLogedIn() -> Observable<Bool>
}

protocol NetworkReviewsInteractor: class {
    
    var  myRepository: Repository! {get set}
    func checkInternet() -> Observable<Bool>
    func getReviews(id:String) -> Observable<[Reviews]>
    func getDescription(link:String) -> Observable<String>
}

protocol StorageReviewsInteractor: class {
    
    var  myRepository: Repository! {get set}
    func saveInStorage(reviews:[Reviews], id:Places) -> Observable<Bool>
    func getFromStorage(isSucLoaded:Bool,id:Places) -> Observable<[Review]>
}
