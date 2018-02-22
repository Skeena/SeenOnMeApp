//
//  TabBarController.swift
//  SeenOnMe
//
//  Created by George Schena on 25/07/2017.
//  Copyright © 2017 GS International. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationController  = UINavigationController(rootViewController: UserController())
        navigationController.title = "Profile"
        navigationController.tabBarItem.image = UIImage(named: "profile")
        
        let myOutfitController = OutfitsController()
        let outfitNavigationController = UINavigationController(rootViewController: myOutfitController)
        outfitNavigationController.title = "MyOufits"
        outfitNavigationController.tabBarItem.image = UIImage(named: "SOM_Fits")
    
        let postOutiftController = PostOutfitsController()
        let postOutfitsNavigationController = UINavigationController(rootViewController: postOutiftController)
        postOutfitsNavigationController.title = "PostOufit"
        postOutfitsNavigationController.tabBarItem.image = UIImage(named: "postOufit")
        
        let exploreController = ExploreOutfitsController()
        let exploreNavigationController = UINavigationController(rootViewController: exploreController)
        exploreNavigationController.title = "Explore"
        exploreNavigationController.tabBarItem.image = UIImage(named: "explore")
        
        viewControllers = [navigationController, postOutfitsNavigationController ,exploreNavigationController, outfitNavigationController ] //The array of viewcontrollers from the UITabBarController
    }
}

