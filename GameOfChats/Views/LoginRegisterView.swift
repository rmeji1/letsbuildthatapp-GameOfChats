//
//  LoginRegisterView.swift
//  GameOfChats
//
//  Created by robert on 12/5/18.
//  Copyright © 2018 Mejia. All rights reserved.
//

import UIKit

class LoginRegisterView: UIView {
	
	private var inputsContainerHeightAnchor: NSLayoutConstraint?
	private var nameTextFieldHeightAnchor: NSLayoutConstraint?
	private var emailTextFieldHeightAnchor: NSLayoutConstraint?
	private var passwordTextFieldHeightAnchor: NSLayoutConstraint?
	
	// MARK:- UIElements
	let inputsContainerView : UIView = {
		let view = UIView()
		view.backgroundColor = .white
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 5
		view.layer.masksToBounds = true // needed for corners to rounded.
		return view
	}()
	
	var loginRegisterButton : UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = UIColor(r: 137, g: 137, b: 137)

		button.setTitleColor(.white, for: .normal)
		button.setTitle("Register", for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
		button.layer.cornerRadius = 5
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
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
		imageView.clipsToBounds = true
		imageView.isUserInteractionEnabled = true
		return imageView
	}()
	
	var loginRegisterSegmentedControl: UISegmentedControl = {
		let segmentedControl = UISegmentedControl(items: ["Login", "Register"])
		segmentedControl.translatesAutoresizingMaskIntoConstraints = false
		segmentedControl.tintColor = .white
		segmentedControl.selectedSegmentIndex = 1
		//segmentedControl.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
		return segmentedControl
	}()
	
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = UIColor(r: 51, g: 51, b: 51)
		// add subviews to self
		[inputsContainerView, loginRegisterButton, profileImageView, loginRegisterSegmentedControl].forEach{
			self.addSubview($0)
		}
		
		
		setupInputsContainerView()
		setupButtonRegisterButton()
		setupProfileImageView()
		setupSegmentedControl()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK:- Setup code
	func setupProfileImageView(){
		// need x,y, width, height constraints
		profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		profileImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -12).isActive = true
		
		profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
		profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
	}
	
	func loginDisplay(isActive: Bool){
		inputsContainerHeightAnchor?.constant = isActive ? 100 : 150
		
		nameTextFieldHeightAnchor?.isActive = false
		nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: isActive ? 0 : 1/3)
		nameTextFieldHeightAnchor?.isActive = true
		
		emailTextFieldHeightAnchor?.isActive = false
		emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: isActive ? 1/2 : 1/3)
		emailTextFieldHeightAnchor?.isActive = true
		
		passwordTextFieldHeightAnchor?.isActive = false
		passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: isActive ? 1/2 : 1/3)
		passwordTextFieldHeightAnchor?.isActive = true
	}
	
	func setupInputsContainerView(){
		// need x,y, width, height constraints
		inputsContainerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		inputsContainerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		inputsContainerView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -24).isActive = true
		inputsContainerHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
		inputsContainerHeightAnchor?.isActive = true
		
		[nameTextField, lineSeparatorView, emailTextField, emailLineSeparatorView, passwordTextField].forEach{
			inputsContainerView.addSubview($0)
		}
		// need x,y, width, height constraints
		nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
		nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
		nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3 )
		nameTextFieldHeightAnchor?.isActive = true
		
		// need x,y, width, height constraints
		lineSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
		lineSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
		lineSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		lineSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
		
		// need x,y, width, height constraints
		emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
		emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
		emailTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor).isActive = true
		emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
		emailTextFieldHeightAnchor?.isActive = true
		
		// need x,y, width, height constraints
		emailLineSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
		emailLineSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
		emailLineSeparatorView.widthAnchor.constraint(equalTo: emailTextField.widthAnchor).isActive = true
		emailLineSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
		
		// need x,y, width, height constraints
		passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
		passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
		passwordTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor).isActive = true
		passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor)
		passwordTextFieldHeightAnchor?.isActive = true
	}
	
	func setupButtonRegisterButton(){
		// need x,y, width, height constraints
		loginRegisterButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
		loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
	}
	
	func setupSegmentedControl(){
		// need x,y, width, height constraints
		loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
		loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
	}
}
