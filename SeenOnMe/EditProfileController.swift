//
//  EditProfileController.swift
//  SeenOnMe
//
//  Created by George Schena on 02/08/2017.
//  Copyright © 2017 GS International. All rights reserved.
//

import UIKit
import Firebase

class EditProfileController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "Edit Profile"
        self.navigationController?.navigationBar.tintColor = UIColor(r: 74, g: 189, b: 172)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backToUserController))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector (saveProfileData))

        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor(r: 74, g: 189, b: 172),
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 20)
        ]
    }
    
    @objc func backToUserController(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveProfileData(){
        self.dismiss(animated: true, completion: nil)
    }
    
}
