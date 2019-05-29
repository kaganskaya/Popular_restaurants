//
//  ViewController.swift
//  View
//
//  Created by liza_kaganskaya on 2/10/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SwiftSoup


class ViewController: UIViewController{

    
    @IBOutlet weak var tableViewData: UITableView!
    
    var presenter: MasterPresenter!
        
    var business:[Places] = []
    
    var i = 0

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewDidLoad()
        presenter.findBusiness(city:"San Francisco")
        presenter.logout()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(self.signOut))
        
        
        tableViewData.delegate = self
        tableViewData.dataSource = self

    }
    
    @objc func signOut() {
    
            UserDefaults.standard.setIsLoggedIn(value: false)
            Router.presentLoginScreen(current: self)
        }
    
}

extension ViewController: MasterView, UITableViewDataSource , UITableViewDelegate {
    func showLogin(status: Bool) {
        if status==false{
            Router.presentLoginScreen(current: self)}
    }
    
    
    
    func showBusiness(business: [Places]) {
        self.business = business
        self.tableViewData.reloadData()
    }
    
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return business.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell",for: indexPath) as? TableViewCell
        
            cell?.fillImageView(business: business[indexPath.row])
        
        return cell!
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        i = indexPath.row
        
        Router.presentDetailScreen(current: self, id: business[indexPath.row])
        
    }
    

}



