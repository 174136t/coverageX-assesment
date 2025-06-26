//
//  UIImageView+Extensions.swift
//  UserListApp-CoverageX
//
//  Created by Lahiru Neranjan on 2025-06-26.
//

import UIKit

extension UIImageView {
    private static var imageCache = NSCache<NSString, UIImage>()
    
    func loadImage(from urlString: String, placeholder: UIImage? = nil) {
        self.image = placeholder
        
        let cacheKey = NSString(string: urlString)
        
        //-- Check cache first
        if let cachedImage = UIImageView.imageCache.object(forKey: cacheKey) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data,
                  error == nil,
                  let image = UIImage(data: data) else { return }
            
            //-- Cache the image
            UIImageView.imageCache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }.resume()
    }
}
