//
//  UIImageView.swift
//  View
//
//  Created by liza_kaganskaya on 3/11/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    

    func downloadImageFrom(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        downloadImageFrom(url: url)
    }
    
    func downloadImageFrom(url: URL) {
        
        
//        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
//            self.image = cachedImage
//        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data)
                   // imageCache.setObject(imageToCache!, forKey: url.absoluteString as NSString)
                    self.image = imageToCache
                }
                }.resume()
        //}
    }
    
}
