//
//  OufitsController.swift
//  SeenOnMe
//
//  Created by George Schena on 25/07/2017.
//  Copyright © 2017 GS International. All rights reserved.
//

import UIKit

class OutfitsController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "MyOutfits"
        self.navigationController?.navigationBar.tintColor = UIColor(r: 74, g: 189, b: 172)
        view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor(r: 74, g: 189, b: 172),
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 20)
        ]

    }
}
