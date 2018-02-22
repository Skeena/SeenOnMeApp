//
//  PostOutfitController.swift
//  SeenOnMe
//
//  Created by George Schena on 25/07/2017.
//  Copyright © 2017 GS International. All rights reserved.
//

import UIKit
import Firebase


class PostOutfitsController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    var imageFileName = ""
    
    let previewImage: UIImageView = {
        let pImage = UIImageView()
        pImage.contentMode = .scaleAspectFill
        pImage.translatesAutoresizingMaskIntoConstraints = false
        pImage.layer.masksToBounds = true
        pImage.backgroundColor = UIColor(r: 66, g: 170, b: 154)
        pImage.layer.cornerRadius = 5
        pImage.alpha = 0.65
        return pImage
    }()
    
    let captionBox: UITextView = {
        let pText = UITextView()
        pText.translatesAutoresizingMaskIntoConstraints = false
        pText.backgroundColor = UIColor(r: 66, g: 170, b: 154)
        pText.layer.cornerRadius = 5
        pText.textColor = UIColor.white
        return pText
    }()
    
    let postButton: UIButton = {
        let pButton = UIButton(type: .system)
        pButton.translatesAutoresizingMaskIntoConstraints = false
        pButton.layer.masksToBounds = true
        pButton.backgroundColor = UIColor(r: 66, g: 170, b: 154)
        pButton.setTitle("Post", for: UIControlState())
        pButton.setTitleColor(UIColor.white, for: UIControlState())
        pButton.layer.cornerRadius = 5
        pButton.addTarget(self, action: #selector(postButtonPressed), for: .touchUpInside)
        return pButton
    }()
    
    var picker  = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captionBox.resignFirstResponder()
        
        view.addSubview(previewImage)
        view.addSubview(postButton)
        view.addSubview(captionBox)
        
        picker.delegate = self
        
        setupPreviewImage()
        setupPostButton()
        setUpCaptionField()
        
        self.navigationItem.title = "PostOutfit"
        self.navigationController?.navigationBar.tintColor = UIColor(r: 74, g: 189, b: 172)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Outfit", style: .plain, target: self, action: #selector(uploadOufitScreen))
        
        view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor(r: 74, g: 189, b: 172),
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 20)
        ]
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.previewImage.image = image
            uploadImage(image: image)
        }
        self.dismiss(animated: true, completion: nil)
        previewImage.alpha = 1
    }
    
    func setupPreviewImage(){
        //need x, y, width, height constraints
        previewImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        previewImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        previewImage.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        previewImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func setUpCaptionField(){
        //need x, y, width, height constraints
        captionBox.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        captionBox.centerYAnchor.constraint(equalTo: previewImage.bottomAnchor, constant: 50).isActive = true
        captionBox.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        captionBox.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
    func setupPostButton(){
        //need x, y, width, height constraints
        postButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        postButton.topAnchor.constraint(equalTo: captionBox.bottomAnchor, constant: 12).isActive = true
        postButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        postButton.heightAnchor.constraint(equalToConstant: 38).isActive = true
    }

    
    
    @objc func uploadOufitScreen(){
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func uploadImage(image: UIImage) {
        let randomName = randomStringWithLength(length: 10)
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        let upladRef = Storage.storage().reference().child("Images/\(randomName).jpg")
        
        let uploadTask = upladRef.putData(imageData!,metadata: nil) { metadata, error in
            if error == nil {
                //Success
                print("Image uploaded")
                self.imageFileName = "\(randomName as String).jpg"
            } else {
                //error
                print("Error uploading image: \(String(describing: error?.localizedDescription))")
            }
            
        }
    }

    @objc func postButtonPressed(){
        let uid = Auth.auth().currentUser?.uid
        let caption = captionBox.text
        
        let postObject = [
            "uid" : uid,
            "caption" : caption,
            "image" : imageFileName
        ]
        Database.database().reference().child("posts").childByAutoId().setValue(postObject)
        print("Posted to firebase")
        
        let postAlert = UIAlertController(title: "Posted!", message: "You have posted" , preferredStyle: .alert)
        postAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(postAlert, animated: true, completion: nil)
        
        previewImage.image = nil
        previewImage.alpha = 0.65
        captionBox.text = nil
    }
    
    func randomStringWithLength(length: Int) -> NSString{
        let characters: NSString = "abcdefghijlkmnopqrstuvwxyzABCDEFGHIJKLMNOPQURSTUVWXYZ0123456789"
        let randomString: NSMutableString = NSMutableString(capacity: length)
        for i in 0..<length {
            let len = UInt32(characters.length)
            let random = arc4random_uniform(len)
            randomString.appendFormat("%C", characters.character(at: Int(random)))
        }
        return randomString
    }
}
