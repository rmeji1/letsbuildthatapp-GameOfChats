//
//  ViewController.swift
//  GameOfChats
//
//  Created by robert on 12/4/18.
//  Copyright © 2018 Mejia. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {

	
  override func viewDidLoad() {
    super.viewDidLoad()
//		let ref = Database.database().reference(fromURL: "https://gameofchats-7b40c.firebaseio.com/")
//		ref.updateChildValues(["somevalue": 123456])
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
  }
  
  @objc func handleLogout(){
    let loginController = LoginViewController()
    self.present(loginController, animated: true, completion: nil)
  }

}

