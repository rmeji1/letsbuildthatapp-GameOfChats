//
//  UserCellTableViewCell.swift
//  GameOfChats
//
//  Created by robert on 12/5/18.
//  Copyright © 2018 Mejia. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
	
	let profileImageView:UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "profile_splash")
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.layer.masksToBounds = true
		imageView.layer.cornerRadius = 24
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		textLabel?.frame = CGRect(x: 56, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
		detailTextLabel?.frame = CGRect(x: 56, y: detailTextLabel!.frame.origin.y - 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)

	}
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
		
		addSubview(profileImageView)
		// x, y, width, height
		profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
		profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		profileImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
		profileImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
