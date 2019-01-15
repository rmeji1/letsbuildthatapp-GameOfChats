//
//  UIColorExtension.swift
//  GameOfChats
//
//  Created by robert on 12/5/18.
//  Copyright © 2018 Mejia. All rights reserved.
//

import UIKit

extension UIColor{
	convenience init(r: CGFloat, g: CGFloat, b: CGFloat){
		self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
	}
}
