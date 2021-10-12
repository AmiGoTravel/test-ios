//
//  UIImageView+Extension.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 21/09/21.
//

import UIKit

extension UIImageView {
    
    var imageCache: NSCache<AnyObject, AnyObject> {
        
        return  NSCache<AnyObject, AnyObject>()
    }
    
    func imageFromURL(_ imageString: String) {
        
        guard let imageURL = URL(string: imageString) else { return }
        if let cachedImage = imageCache.object(forKey: imageURL.absoluteString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                if let data = data, let image = UIImage(data: data) {
                    self.imageCache.setObject(image, forKey: imageURL.absoluteString as AnyObject)
                    self.image = image
                }
            })
        }.resume()
    }
}
