//
//  ReviewCell.swift
//  View
//
//  Created by liza_kaganskaya on 2/18/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var reviewLabel: UILabel!
   
    @IBOutlet weak var action: UIActivityIndicatorView!
    
    func fillReviewCell(text:String){
        let reviewLabelHeight = reviewLabel.optimalHeigt
        
            reviewLabel.frame = CGRect(x: reviewLabel.frame.origin.x, y:reviewLabel.frame.origin.y, width: reviewLabel.frame.width, height: reviewLabelHeight)
        
            reviewLabel.numberOfLines = 0
        
            reviewLabel.text = text
        
    }
    
    
}
