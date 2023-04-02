//
//  CustomNavigationBar.swift
//  AlbumList
//
//  Created by Bowie Tso on 29/3/2023.
//

import UIKit
import SwifterSwift

enum AlbumListNavigationBarStyle {
    case titleWithoutBarButtonItems(title: String)
    case backWithTitle(title: String)
    case none
}

class AlbumListBarButtonItem: UIBarButtonItem  {
    fileprivate var parameter: Any?
}

extension UIViewController {
    func setNavigationBar(_ style: AlbumListNavigationBarStyle = .none) {
        if let navigationController = navigationController {
            navigationController.navigationBar.isTranslucent = true
            navigationController.navigationBar.tintColor = .white

            navigationController.isNavigationBarHidden = false
            navigationController.navigationBar.barTintColor = .white
            navigationController.navigationBar.isTranslucent = false

            navigationController.navigationBar.shadowColor = .black
            navigationController.navigationBar.shadowOffset = CGSize(width: 0, height: 0.5)
            navigationController.navigationBar.shadowOpacity = 0.2
            navigationController.navigationBar.layer.masksToBounds = false
            navigationController.navigationBar.setColors(background: .white, text: UIColor(red: 0, green: 0, blue: 0, alpha: 0.85))
            
            if #available(iOS 13.0, *) {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = .white
                appearance.shadowColor = .white
                navigationController.navigationBar.standardAppearance = appearance
                navigationController.navigationBar.scrollEdgeAppearance = appearance
            }
            
            let backBarButton = AlbumListBarButtonItem(image: R.image.back()!,
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(backPressedHandling(_:)))
            backBarButton.tintColor = .black
            
            switch style {
            case .titleWithoutBarButtonItems(let title):
                navigationItem.leftBarButtonItems = []
                navigationItem.rightBarButtonItems = []
                setNavigationBar(title: title)
            case .backWithTitle(let title):
                navigationItem.leftBarButtonItems = [backBarButton]
                navigationItem.rightBarButtonItems = []
                setNavigationBar(title: title)
            default:
                self.hideNavigationBar()
                return
            }
            navigationController.interactivePopGestureRecognizer?.isEnabled = true
            navigationController.interactivePopGestureRecognizer?.delegate = nil
        }
    }
    
    func setNavigationBar(title: String) {
        navigationItem.title = title
    }
    
    func hideNavigationBar(animated: Bool = true) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func showNavigationBar(animated: Bool = false) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: - Actions
    @objc private func backPressedHandling(_ sender: AlbumListBarButtonItem) {
        if let action = sender.parameter as? (() -> Void) {
            action()
        } else {
            navigationController?.popViewController()
        }
    }
    
//    MARK: Navigation
    
    func popToRootViewControllerAndBackToHome() {
        navigationController?.popToRootViewController(animated: true) {
            let firstViewController = self.navigationController?.viewControllers.first
            if let tabbarVC: AlbumListTabBarController = firstViewController as? AlbumListTabBarController {
                tabbarVC.selectedIndex = 0
            }
        }
    }
}

extension UINavigationController {
    func popToRootViewController(animated: Bool, completion: @escaping () -> Void) {
        popToRootViewController(animated: animated)

        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
}
