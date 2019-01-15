//
//  UIImageViewExtension.swift
//  GameOfChats
//
//  Created by robert on 12/6/18.
//  Copyright © 2018 Mejia. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView{
	func loadImageUsingCache(with urlString: String){
		
		self.image = nil
		
		if let cachedImage = imageCache.object(forKey: urlString as NSString){
			self.image = cachedImage
			return
		}
		
		let url = URL(string: urlString)
		URLSession.shared.dataTask(with: url!) { (data, response, error) in
			if error != nil{
				print("error")
				return
			}
			
			DispatchQueue.main.async {
				if let image = UIImage(data: data!){
					imageCache.setObject(image, forKey: urlString as NSString)
				}
			}
			}.resume()
	}
}
