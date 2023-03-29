//
//  AlbumListTabBarController.swift
//  AlbumList
//
//  Created by Bowie Tso on 29/3/2023.
//

import UIKit
import SwifterSwift

class AlbumListTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        tabBar.backgroundColor = .white
        tabBar.shadowColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        hideNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        hideNavigationBar()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Selected Item :", item)
    }
    
    func tabBarController(_ tabBarController: UITabBarController,
                          shouldSelect viewController: UIViewController) -> Bool {
        print("tabBarController_vc :", viewController)
        return true
    }
    
}
