//
//  DetailViewController.swift
//  View
//
//  Created by liza_kaganskaya on 2/10/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var reviewsView: UITableView!
    
    @IBOutlet weak var descriptionText: UITextView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBAction func revBut(_ sender: UIButton) {
        
        descriptionButton = false
        
        reviewButton = true
        
        self.reviewsView.reloadData()
        
    }
    
    @IBAction func descBut(_ sender: UIButton) {
        
        reviewButton = false
        
        descriptionButton = true
        
        self.reviewsView.reloadData()
        
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    var descriptionButton:Bool = true
    
    var reviewButton:Bool = true
    
    var id:Places?
    
    var presenter: DetailPresenter!
    
    var reviews:[Review] = []
    
    var desc:String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillImageView(url: (id?.image_url)!)
        //print(id?.name)
        nameLabel.text = id?.name
        
        presenter.getDataById(id: id!)
        
        self.presenter.getDescription(link: (id?.url)!)
        self.descriptionButton=true
        self.reviewButton = false
        reviewsView.delegate = self
        reviewsView.dataSource = self
        
    }
   
    

    func fillImageView(url:String){
        
//         let myUrl = URL(string: url)
//
//        DispatchQueue.global().async {
//            let data = try? Data(contentsOf: myUrl!)
//
//            DispatchQueue.main.async {
        
                self.imageView.downloadImageFrom(urlString: url)
//
//            }
//        }
    }}

extension DetailViewController:  DetailView , UITableViewDataSource , UITableViewDelegate {
    
    func showReviews(review: [Review]) {
        self.reviews = review
        self.reviewsView.reloadData()
        print(reviews.count)
    }
    
    func getDescription(string:String) {
        self.desc = string
        self.reviewsView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        var result:Int
        
        if reviewButton {
            result = reviews.count
        }else{
            result = 1
        }
        return result
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "revCell",for: indexPath) as? ReviewCell
        
        if reviewButton {
            
            cell?.fillReviewCell(text: reviews[indexPath.row].text!)
            
        }else{
            
            cell?.fillReviewCell(text: desc!)
        }
        
        
        
        return cell!
    }
    
    
    
    
}
