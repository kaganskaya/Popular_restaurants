//
//  TableViewCell.swift
//  View
//
//  Created by liza_kaganskaya on 2/10/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import UIKit



class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lName: UILabel!
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    func fillImageView(business:Places){
        self.backgroundImage.downloadImageFrom(urlString: business.image_url!)
        self.lName.text = business.name
    }
    
    func changeTextColor(){
        self.lName.textColor = .black
        
    }
    
   
}
