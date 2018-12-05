//
//  LoginViewController.swift
//  GameOfChats
//
//  Created by robert on 12/4/18.
//  Copyright © 2018 Mejia. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
	
	let inputsContainerView : UIView = {
		let view = UIView()
		view.backgroundColor = .white
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 5
		view.layer.masksToBounds = true // needed for corners to rounded.
		return view
	}()
	
	lazy var loginRegisterButton : UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
		button.setTitleColor(.white, for: .normal)
		button.setTitle("Register", for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
		return button
	}()
	
	@objc func handleRegister(){
		guard let name = nameTextField.text,
			let email = emailTextField.text,
			let password = passwordTextField.text else {
				print("Form is not valid")
				return
		}
		
		Auth.auth().createUser(withEmail: email, password: password){
			(dataResult, error) in
			if error != nil{
				print(error ?? "Any")
				return
			}
			
			guard let userId = dataResult?.user.uid else{
				return
			}
			
			//successfully authenticated user
			let ref = Database.database().reference(fromURL: "https://gameofchats-7b40c.firebaseio.com/")
			let values = ["name" : name, "email":email]
			let userReference = ref.child("users")
			userReference.child(userId).updateChildValues(values, withCompletionBlock: { (error, ref) in
				if error != nil{
					print(error!)
					return
				}
				
				print("Saved user successfully into database")
			})
		}
		
		print("123")
	}
	
	let nameTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Name"
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	
	let lineSeparatorView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.init(r: 220, g: 220, b: 220)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let emailTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Email"
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	
	let emailLineSeparatorView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.init(r: 220, g: 220, b: 220)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let passwordTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Password"
		textField.isSecureTextEntry = true
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	
	let profileImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "profile_splash")
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()
	
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
		
		// add to view
		[inputsContainerView, loginRegisterButton, profileImageView].forEach{ view.addSubview($0)}
		setupInputsContainerView()
		setupButtonRegisterButton()
		setupProfileImageView()

  }
	
	func setupProfileImageView(){
		// need x,y, width, height constraints
		profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		profileImageView.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
		
		profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
		profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
		
	}
	func setupInputsContainerView(){
		// need x,y, width, height constraints
		inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
		inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
		
		[nameTextField, lineSeparatorView, emailTextField, emailLineSeparatorView, passwordTextField].forEach{
			inputsContainerView.addSubview($0)
		}
			// need x,y, width, height constraints
		nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
		nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
		nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3 ).isActive = true
//		nameTextField.heightAnchor.constraint(equalToConstant: nameTextField.frame.height - 2)
		
		// need x,y, width, height constraints
		lineSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
		lineSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
		lineSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		lineSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
		
		// need x,y, width, height constraints
		emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
		emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
		emailTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor).isActive = true
		emailTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor).isActive = true
		//		nameTextField.heightAnchor.constraint(equalToConstant: nameTextField.frame.height - 2)
		
		// need x,y, width, height constraints
		emailLineSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
		emailLineSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
		emailLineSeparatorView.widthAnchor.constraint(equalTo: emailTextField.widthAnchor).isActive = true
		emailLineSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
		
		// need x,y, width, height constraints
		passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
		passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
		passwordTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor).isActive = true
		passwordTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor).isActive = true

	}
	
	func setupButtonRegisterButton(){
		// need x,y, width, height constraints
		loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
		loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

		
	}
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
}

extension UIColor{
	convenience init(r: CGFloat, g: CGFloat, b: CGFloat){
		self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
	}
}
