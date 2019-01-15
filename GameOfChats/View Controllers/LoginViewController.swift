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
	// Mark:- Outlets
	unowned var loginRegistrationView: LoginRegisterView { return view as! LoginRegisterView }
	unowned var inputsContainerView: UIView { return loginRegistrationView.inputsContainerView }
	unowned var loginRegisterButton: UIButton { return loginRegistrationView.loginRegisterButton }
	unowned var nameTextField: UITextField { return loginRegistrationView.nameTextField }
	unowned var emailTextField: UITextField { return loginRegistrationView.emailTextField }
	unowned var passwordTextField: UITextField { return loginRegistrationView.passwordTextField }
	unowned var loginRegisterSegmentedControl: UISegmentedControl { return loginRegistrationView.loginRegisterSegmentedControl }
	unowned var profileImageView: UIImageView { return loginRegistrationView.profileImageView }
	
	var messageController : MessagesController?
	let userController = UserController()
	
	// MARK:- View Overrides
	override func loadView() {
		self.view = LoginRegisterView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		addHandlers()
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	// MARK:- Action handlers
	
	func addHandlers(){
		loginRegisterButton.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
		loginRegisterSegmentedControl.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
		profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageview)))
	}
	
	@objc func handleSelectProfileImageview(){
		let picker = UIImagePickerController()
		picker.delegate = self
		picker.allowsEditing = true
		present(picker, animated: true, completion: nil)
	}
	
	
	@objc func handleLoginRegisterChange(){
		let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
		loginRegisterButton.setTitle(title, for: .normal)
		loginRegistrationView.loginDisplay(isActive: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? true : false )
	}
	
	@objc func handleLoginRegister(){
		if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
			handleLogin()
		}else{
			handleRegister()
		}
	}
	
	func handleLogin(){
		guard
			let email = emailTextField.text,
			let password = passwordTextField.text else {
				print("Form is not valid")
				return
		}
		
		Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
			if error != nil{
				print(error ?? "error")
				return
			}
			self.messageController?.setNavigationBarTitle()
			self.dismiss(animated: true, completion: nil)
		}
	}
	
	func handleRegister(){
		guard let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text else {
				print("Form is not valid")
				return
		}
		
		Auth.auth().createUser(withEmail: email, password: password){ (dataResult, error) in
			guard let userId = dataResult?.user.uid else{
				return
			}
			//successfully authenticated user
			self.uploadProfileImage{ (downloadURL) -> Void in
				let values = ["name": name, "email": email, "image": downloadURL]
				self.messageController?.setNavigationBarTitle(to: values["name"])
				self.saveNewUser(with: userId, and: values)
			}
		}
	}
	
	func uploadProfileImage(completion: @escaping (String) -> Void){
		let imageName = UUID().uuidString
		let storageReference = Storage.storage().reference().child("profile_images").child("\(imageName).jpeg")
		
		// compression used
		if let profileImage = profileImageView.image, let uploadData = profileImage.jpegData(compressionQuality: 0.1){
			storageReference.putData(uploadData, metadata: nil, completion: { (metadata, error) in
				guard let _ = metadata else{
					return
				}
				storageReference.downloadURL{ (url, error) in
					guard let downloadUrl = url else{
						return
					}
					completion(downloadUrl.absoluteString)
				}
			})
		}
	}
	
	func saveNewUser(with userId: String, and values: [String:Any]){
		let ref = Database.database().reference(fromURL: "https://gameofchats-7b40c.firebaseio.com/")
		let userReference = ref.child("users")
		userReference.child(userId).updateChildValues(values) { (error, ref) in
			if error != nil{
				print(error!)
				return
			}
			self.dismiss(animated: true, completion: nil)
		}
	}
}

extension LoginViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		
		var selectedImage: UIImage?
		
		if let editedImage = info[.editedImage] as? UIImage{
			selectedImage = editedImage
		} else if let originalImage = info[.originalImage] as? UIImage{
			selectedImage = originalImage
		}
		
		if let selectedImage = selectedImage {
			profileImageView.image = selectedImage
		}
		dismiss(animated: true, completion: nil)
	}
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true, completion: nil)
	}
}
