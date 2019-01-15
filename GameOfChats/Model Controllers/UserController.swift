//
//  UserController.swift
//  GameOfChats
//
//  Created by robert on 12/5/18.
//  Copyright © 2018 Mejia. All rights reserved.
//

import Foundation
import Firebase

enum UserControllerError: Error{
		case PropertyError
		case invalidUserId
}

class UserController{
	private let databaseReference: DatabaseReference = Database.database().reference()
	private let userId: String? = Auth.auth().currentUser?.uid
	public var isActive: Bool{
		get{
			guard let _ = Auth.auth().currentUser else{
				return false
			}
			return true
		}
	}
	
	func forEach(closure: @escaping ([String: AnyObject]) -> Void){
		databaseReference.child("users").observe(.childAdded, with: {
			if let dictionary = $0.value as? [String: AnyObject]{
				closure(dictionary)
			}
		}, withCancel: nil)
	}
	
	
	
	func findProperty(titled name: String, closure: @escaping (AnyObject?, Error?) -> Void) {
		guard let userId = userId else{
			closure(nil, UserControllerError.invalidUserId)
			return
		}
		
		databaseReference.child("users").child(userId).observe(.value, with: { snapshot in
			if let dictionary = snapshot.value as? [String: AnyObject],
				let property = dictionary[name]{
					closure(property, nil)
			}
			else{
				closure(nil, UserControllerError.PropertyError)
			}
		}, withCancel: nil)
	}
}
