//
//  SettingViewController.swift
//  AlbumList
//
//  Created by Bowie Tso on 29/3/2023.
//

import UIKit

enum SettingOptions: CaseIterable {
    case language
    
    func optionsString() -> String {
        switch self {
        case .language:
            return "Language"
        }
    }
}

class SettingViewController: BaseViewController {

    @IBOutlet weak var settingTableView: UITableView!
    
    let settingOptionsList: [SettingOptions] = [.language]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(.titleWithoutBarButtonItems(title: "Setting"))
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.register(UINib(resource: R.nib.settingTableViewCell),
                                  forCellReuseIdentifier: R.reuseIdentifier.settingTableViewCell.identifier)
        // Do any additional setup after loading the view.
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
    
    
}
