//
//  SettingViewController.swift
//  AlbumList
//
//  Created by Bowie Tso on 29/3/2023.
//

import UIKit
import SwiftyUserDefaults

enum SettingOptions: CaseIterable {
    case language
    
    func optionsString() -> String {
        switch self {
        case .language:
            return localized.setting_language.string()
        }
    }
}

class SettingViewController: BaseViewController {

    @IBOutlet weak var settingTableView: UITableView!
    
    let settingOptionsList: [SettingOptions] = [.language]
    
    private var changeLanguageAlertController: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(.titleWithoutBarButtonItems(title: localized.bottom_tab_bar_setting.string()))
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.register(UINib(resource: R.nib.settingTableViewCell),
                                  forCellReuseIdentifier: R.reuseIdentifier.settingTableViewCell.identifier)
        setupChangeLanguageAlertController()
        // Do any additional setup after loading the view.
    }

    private func setupChangeLanguageAlertController() {
        let alertController = UIAlertController(title: localized.setting_choose_language.string(),
                                                message: nil,
                                                preferredStyle: .actionSheet)
        alertController.overrideUserInterfaceStyle = .light
        
        let changeChineseAction = UIAlertAction(title: "中文",
                                                style: .default,
                                         handler: { action in
                                            Defaults[\.LANGUAGE] = "tc"
            self.view.window?.switchRootViewController(to: R.storyboard.main().instantiateInitialViewController()!,
                                                     animated: false,
                                                     duration: 0,
                                                     options: []) {
                if let tabbarVC: AlbumListTabBarController = self.navigationController?.viewControllers.first as? AlbumListTabBarController {
                    tabbarVC.selectedIndex = 0
                }
            }
        })
        
        let changeEnglishAction = UIAlertAction(title: "English",
                                                style: .default,
                                                handler: { action in
                                                    Defaults[\.LANGUAGE] = "en"
            self.view.window?.switchRootViewController(to: R.storyboard.main().instantiateInitialViewController()!,
                                                     animated: false,
                                                     duration: 0,
                                                     options: []) {
                if let tabbarVC: AlbumListTabBarController = self.navigationController?.viewControllers.first as? AlbumListTabBarController {
                    tabbarVC.selectedIndex = 0
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: localized.cancel.string(),
                                         style: .cancel)
        
        alertController.addAction(changeChineseAction)
        alertController.addAction(changeEnglishAction)
        alertController.addAction(cancelAction)
        changeLanguageAlertController = alertController
    }
    
    
}


extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingOptionsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch  settingOptionsList[indexPath.row] {
            case .language:
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.settingTableViewCell, for: indexPath)!
                cell.setOptions(optionText: SettingOptions.language.optionsString())
                return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch  settingOptionsList[indexPath.row] {
        case .language:
            present(changeLanguageAlertController!,
                    animated: true,
                    completion: nil)
        }
    }
    
    
}
