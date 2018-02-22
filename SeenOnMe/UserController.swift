//
//  UserController.swift
//  SeenOnMe
//
//  Created by George Schena on 16/07/2017.
//  Copyright © 2017 GS International. All rights reserved.
//

import UIKit
import Firebase

class UserController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let profileInfoContainerView: UIView = { // This creates the white box
        let profileView = UIView()
        profileView.backgroundColor = UIColor(r: 74, g: 189, b: 172)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.layer.cornerRadius = 5
        profileView.layer.masksToBounds = true
        return profileView
    }()
    
    let profileNameLabel: UILabel = {
        let nameLbl = UILabel()
        nameLbl.textColor = UIColor.white
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.textAlignment = .right
        nameLbl.font = UIFont.boldSystemFont(ofSize: 20)
        return nameLbl
    }()
    
    let profileImgView: UIImageView = { // Creates the objects inside the inputsViewContainer
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    lazy var editProfilePicButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editProfileImage), for: .touchUpInside)
        self.profileInfoContainerView.addSubview(button)
        return button
    }()
    
    @objc func editProfileImage(){
            picker.allowsEditing = true
            picker.sourceType = .photoLibrary
            
            self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.profileImgView.image = image
        }
        self.dismiss(animated: true, completion: nil)
        profileImgView.alpha = 1
    }
    
    // Faveourite shops
    // Favuorite Brands
    // Number of outfits posted

    var picker  = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self

        self.navigationItem.title = "Profile"
        view.backgroundColor = UIColor.white
        
        view.addSubview(profileInfoContainerView) // Adding the profileInfoContainerView to the userscreen

        setupProfileInfoContainerView()
        
        self.navigationController?.navigationBar.tintColor = UIColor(r: 74, g: 189, b: 172)
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor(r: 74, g: 189, b: 172),
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 20)
        ]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))

        
        // Means user is not logged in currently
        if Auth.auth().currentUser?.uid == nil {
            handleLogout()
        }
    }
    
    func setupProfileInfoContainerView() {
        //need x, y, width, height constraints
        //Position of the inputsContainerView in the view
        profileInfoContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileInfoContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -175).isActive = true
        profileInfoContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        profileInfoContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        profileInfoContainerView.addSubview(profileNameLabel)
        profileInfoContainerView.addSubview(profileImgView)
        
        //need x, y, width, height constraints
        profileNameLabel.centerXAnchor.constraint(equalTo: profileInfoContainerView.centerXAnchor).isActive = true
        profileNameLabel.centerYAnchor.constraint(equalTo: profileInfoContainerView.centerYAnchor).isActive = true
        profileNameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        profileNameLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        //need x, y, width, height constraints
        profileImgView.centerXAnchor.constraint(equalTo: profileInfoContainerView.leftAnchor, constant: 60).isActive = true
        profileImgView.centerYAnchor.constraint(equalTo: profileInfoContainerView.topAnchor, constant: 75).isActive = true
        profileImgView.widthAnchor.constraint(equalToConstant: 125).isActive = true
        profileImgView.heightAnchor.constraint(equalTo: profileInfoContainerView.heightAnchor).isActive = true
        
        //need x, y, width, height constraints
        editProfilePicButton.centerXAnchor.constraint(equalTo: profileInfoContainerView.leftAnchor, constant: 60).isActive = true
        editProfilePicButton.centerYAnchor.constraint(equalTo: profileInfoContainerView.topAnchor, constant: 75).isActive = true
        editProfilePicButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        editProfilePicButton.heightAnchor.constraint(equalTo: profileInfoContainerView.heightAnchor).isActive = true
    }

    func checkIfUserIsLoggedIn(){
        if Auth.auth().currentUser?.uid == nil {
            handleLogout()
        } else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject]{
                    self.profileNameLabel.text = dictionary["name"] as? String
                }
                
                
            }, withCancel: nil)
        }
    }
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        checkIfUserIsLoggedIn()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
}


