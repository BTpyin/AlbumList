//
//  BaseViewController.swift
//  AlbumList
//
//  Created by Bowie Tso on 28/3/2023.
//

import UIKit
import SnapKit
import RxSwift

class BaseViewController: UIViewController {
    
    private lazy var networkRetryView = UIView(frame: .zero)
    
    func shouldPresentNetworkConnectionErrorView(isShowNetworkRetryView: Bool = false,
                                                 _ handler: (() -> Void)?) {
            if isShowNetworkRetryView {
//                networkRetryView.retryHandler = handler
                view.addSubview(networkRetryView)
                networkRetryView.snp.makeConstraints { (marker) in
                    marker.top.leading.bottom.trailing.equalToSuperview()
                }
            } else {
                networkRetryView.removeFromSuperview()
            }
        
    }
    
    func hideNetworkRetryView() {
        networkRetryView.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        networkRetryView.removeFromSuperview()
//        super.viewWillDisappear(animated)
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//    }
}

