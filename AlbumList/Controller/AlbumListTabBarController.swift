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
        setupTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        hideNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        hideNavigationBar()
    }
    
    func setupTabBar() {
        overrideUserInterfaceStyle = .light
        tabBar.backgroundColor = .white
        tabBar.shadowColor = .white
        tabBar.items?[0].title = localized.bottom_tab_bar_home.string()
        tabBar.items?[0].selectedImage?.withTintColor(.black)
        tabBar.items?[0].image?.withTintColor(.darkGray)
        tabBar.items?[1].title = localized.bottom_tab_bar_setting.string()
        tabBar.items?[1].image?.withTintColor(.darkGray)
        tabBar.items?[1].selectedImage?.withTintColor(.black)
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
