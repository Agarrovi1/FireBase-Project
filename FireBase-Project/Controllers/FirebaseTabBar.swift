//
//  FirebaseTabBar.swift
//  FireBase-Project
//
//  Created by Angela Garrovillas on 11/19/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class FirebaseTabBar: UITabBarController {

    lazy var feedVC = UINavigationController(rootViewController: FeedVC())
    
    lazy var uploadVC = UINavigationController(rootViewController: ImageUploadVC())
    
    lazy var profileVC: UINavigationController = {
        let userProfileVC = ProfileVC()
        //userProfileVC.user = AppUser(from: FirebaseAuthService.manager.currentUser!)
        //userProfileVC.isCurrentUser = true
        return UINavigationController(rootViewController: userProfileVC)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "list.dash"), tag: 0)
        uploadVC.tabBarItem = UITabBarItem(title: "Upload", image: UIImage(systemName: "person.3"), tag: 1)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.square"), tag: 2)
        self.viewControllers = [feedVC, uploadVC,profileVC]
    }

}
