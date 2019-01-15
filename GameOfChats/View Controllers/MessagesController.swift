//
//  ViewController.swift
//  GameOfChats
//
//  Created by robert on 12/4/18.
//  Copyright © 2018 Mejia. All rights reserved.
//

import UIKit
import Firebase

class MessagesController: UITableViewController {
	
	let userController = UserController()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItemsBarButtonItemsCustomization()
		
		checkIfUserIsLoggedIn()
	}
	
	func navigationItemsBarButtonItemsCustomization(){
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
		let image = UIImage(named: "add_message")
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewMessage))
	}
	
	@objc func handleNewMessage(){
		let newMessageController = NewMessageTableViewController()
		let navigationController = UINavigationController(rootViewController: newMessageController)
		present(navigationController, animated: true, completion: nil)
	}
	
	func checkIfUserIsLoggedIn(){
		if !userController.isActive {
			self.presentLoginController()
		}else{
			// this shouldn't be here but okay.
			setNavigationBarTitle()
		}
	}

	func setNavigationBarTitle(to name: String? = nil){
		if name == nil{
			userController.findProperty(titled: "name") { name, error in
				if error != nil {
					print("Error getting user title")
				}
				if let name = name as? String{
					self.navigationItem.title = name
				}
			}
		}else{
			self.navigationItem.title = name
		}
	}
	
	func presentLoginController(){
		DispatchQueue.main.async {
			let loginController = LoginViewController()
			loginController.messageController = self
			self.present(loginController, animated: true, completion: nil)
		}
	}
	
	@objc func handleLogout(){
		do {
			try Auth.auth().signOut()
			presentLoginController()
		} catch let logoutError {
			print(logoutError)
		}
	}
}

