//
//  AlbumDetailViewController.swift
//  AlbumList
//
//  Created by Bowie Tso on 31/3/2023.
//

import UIKit
import RxSwift
import RxCocoa

class AlbumDetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var albumDetailCardView: UIView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var albumImageView: UIImageView!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var noOfTrackLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var showAlbumContainerView: UIView!
    @IBOutlet weak var showAlbumTextLabel: UILabel!
    @IBOutlet weak var showArtistContainerView: UIView!
    
    @IBOutlet weak var showArtistTextLabel: UILabel!
    
    let viewModel = AlbumDetailViewControllerViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        // Do any additional setup after loading the view.
    }
    
    func setupBinding() {
        viewModel.albumImageUrl.bind(to: albumImageView.rx.imageURL).disposed(by: disposeBag)
        viewModel.collectionName.bind{ [weak self] (albumName) in
            guard let self = self else {return}
            self.albumNameLabel.text = albumName
            self.setNavigationBar(.backWithTitle(title: albumName))
        }.disposed(by: disposeBag)
        viewModel.artistName.bind(to: artistNameLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.releaseDate.bind(to: releaseDateLabel.rx.text).disposed(by: disposeBag)
        viewModel.genre.bind(to: genreLabel.rx.text).disposed(by: disposeBag)
        viewModel.noOfTrack.bind(to: noOfTrackLabel.rx.text).disposed(by: disposeBag)
        viewModel.country.bind(to: countryLabel.rx.text).disposed(by: disposeBag)
        viewModel.copyrightText.bind(to: copyrightLabel.rx.text).disposed(by: disposeBag)
        viewModel.price.bind(to: priceLabel.rx.text).disposed(by: disposeBag)
        
        
    }
    
    @IBAction func didShowAlbumTapped(_ sender: Any) {
        print("didShowAlbumTapped")
    }
    @IBAction func didShowArtistTapped(_ sender: Any) {
        print("didShowArtistTapped")
    }
}
