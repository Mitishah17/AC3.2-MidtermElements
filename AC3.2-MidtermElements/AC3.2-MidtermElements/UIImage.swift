//
//  UIImage.swift
//  AC3.2-MidtermElements
//
//  Created by Miti Shah on 12/8/16.
//  Copyright © 2016 Miti Shah. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImage (from imageURLString: String, with cache: NSCache<NSString, UIImage>) {
        
        
        // Check cache for existing image
        if let image = cache.object(forKey: imageURLString as NSString) {
            self.image = image
        }
        
        // Validate URL
        guard let validURL = URL(string: imageURLString) else {return}
        
        // Convert url contents to Data
        var imageData: Data?
        
        DispatchQueue.global(qos: .background).async {
            do {
                imageData = try Data(contentsOf: validURL)
            }
            catch {
                print(error.localizedDescription)
            }
            
            // Unwrap data, covert data into image
            guard let data = imageData, let image = UIImage(data: data) else
            {return}
            
            //Add object to cache
            
            cache.setObject(image, forKey: imageURLString as NSString)
            
            // Hop on the main thread
            DispatchQueue.main.async {
                
                // Set self.image equal to the image we created from the data
                self.image = image
            }
        }
    }
}




