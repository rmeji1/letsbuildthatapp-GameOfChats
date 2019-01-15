//
//  NewMessageTableViewController.swift
//  GameOfChats
//
//  Created by robert on 12/5/18.
//  Copyright © 2018 Mejia. All rights reserved.
//

import UIKit
import Firebase

class NewMessageTableViewController: UITableViewController {
	let cellId = "cellId"
	var users = [User]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.leftBarButtonItem = UIBarButtonItem(title:"Cancel", style: .plain, target: self,  action: #selector(handleCancel))
		
		//register cell since using programatic approach don't have access to .subtle cell style
		// this is a work around. see class at the bototm of this file for now
		tableView.register(UserTableViewCell.self, forCellReuseIdentifier: cellId)
		
		fetchUsers()
	}
	
	func fetchUsers(){
		UserController().forEach {
			let user = User()
			user.name = $0["name"] as? String
			user.email = $0["email"] as? String
			if let image = $0["image"] as? String{
				 user.profileImageUrl = image
			}
			self.users.append(user)
			
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
	
	@objc func handleCancel(){
		dismiss(animated: true, completion: nil)
	}
	// MARK: - Table view data source
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return users.count
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 56
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! 
		
		let user = users[indexPath.row]
		cell.textLabel?.text = user.name
		cell.detailTextLabel?.text = user.email
		if let profileImageUrl = user.profileImageUrl{
			cell.profileImageView.loadImageUsingCache(with: profileImageUrl)
		}
		return cell
	}
}
