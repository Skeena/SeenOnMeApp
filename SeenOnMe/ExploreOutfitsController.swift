//
//  ExploreOutfitsController.swift
//  SeenOnMe
//
//  Created by George Schena on 26/09/2017.
//  Copyright © 2017 GS International. All rights reserved.
//

import UIKit
import Firebase

class ExploreOutfitsController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationItem.title = "Explore"
        // navigationController?.navigationBar.prefersLargeTitles = true  (May use this title sizing)
        self.navigationController?.navigationBar.tintColor = UIColor(r: 74, g: 189, b: 172)
        view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor(r: 74, g: 189, b: 172),
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 20)
        ]
        
    }


}
