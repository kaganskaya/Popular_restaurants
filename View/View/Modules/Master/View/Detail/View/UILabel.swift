//
//  UILabel.swift
//  View
//
//  Created by liza_kaganskaya on 2/20/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import UIKit

extension UILabel {
    
    var optimalHeigt:CGFloat {
        
        get {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude))
            
                label.numberOfLines = 0
            
                label.lineBreakMode = .byWordWrapping
            
                label.font = self.font
            
                label.text = self.text
            
                label.sizeToFit()
            
            return label.frame.height
            
        }
    }
    
}
