//
//  AlbumDetailViewController.swift
//  AlbumList
//
//  Created by Bowie Tso on 31/3/2023.
//

import UIKit
import RxSwift
import RxCocoa

protocol AlbumDetailViewControllerDeletgate: AnyObject {
    func didDetailPageIsFavouriteTapped(collectionId: Int)
}

class AlbumDetailViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var albumDetailCardView: UIView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    
    @IBOutlet weak var isFavouriteImageView: UIImageView!
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var albumImageBackgroundView: GradientView!
    @IBOutlet weak var albumImageView: UIImageView!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var noOfTrackLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var showAlbumContainerView: GradientView!
    @IBOutlet weak var showAlbumTextLabel: UILabel!
    @IBOutlet weak var showArtistContainerView: GradientView!
    
    @IBOutlet weak var showArtistTextLabel: UILabel!
    
    let viewModel = AlbumDetailViewControllerViewModel()
    
    weak var delegate: AlbumDetailViewControllerDeletgate?
    
    let disposeBag = DisposeBag()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        isFavouriteImageView.dropShadow(color: .black, opacity: 0.1, offSet: .zero, radius: 2)
        albumDetailCardView.dropShadow(color: .black, opacity: 0.2, offSet: .zero, radius: 3)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
        
        albumImageBackgroundView.applyGradient(colors: [UIColor(red: 0, green: 0, blue: 0, alpha: 0.8).cgColor,
                                                        UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor,
                                                        UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor])
        
        showAlbumContainerView.applyGradient(colors: [UIColor(red: 240/255, green: 163/255, blue: 224/255, alpha: 1).cgColor,
                                                      UIColor(red: 246/255, green: 197/255, blue: 232/255, alpha: 1).cgColor,
                                                      UIColor(red: 246/255, green: 220/255, blue: 238/255, alpha: 1).cgColor])
        showArtistContainerView.applyGradient(colors: [UIColor(red: 68/255, green: 124/255, blue: 195/255, alpha: 1).cgColor,
                                                       UIColor(red: 155/255, green: 187/255, blue: 235/255, alpha: 1).cgColor,
                                                       UIColor(red: 182/255, green: 207/255, blue: 255/255, alpha: 1).cgColor])
        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        isFavouriteImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didIsFavouriteTapped)))
        isFavouriteImageView.isUserInteractionEnabled = true
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
        
        viewModel.isFavourite.bind { [weak self] (isFavourite) in
            guard let self = self else {return}
            if isFavourite {
                self.isFavouriteImageView.tintColor = .red
                self.isFavouriteImageView.image = UIImage(systemName: "heart.fill")
            } else {
                self.isFavouriteImageView.tintColor = .gray
                self.isFavouriteImageView.image = UIImage(systemName: "heart")
            }
        }.disposed(by: disposeBag)
        
    }
    
    @objc func didIsFavouriteTapped() {
        viewModel.isFavourite.accept(!(viewModel.isFavourite.value))
        delegate?.didDetailPageIsFavouriteTapped(collectionId: viewModel.collectionId.value)
    }
    
    @IBAction func didShowAlbumTapped(_ sender: Any) {
        print("didShowAlbumTapped")
        if let albumUrl = URL(string: viewModel.albumUrl.value) {
            if UIApplication.shared.canOpenURL(albumUrl)
            {
                UIApplication.shared.open(albumUrl)
            } else {
                UIApplication.shared.open(albumUrl)
            }
        }
    }
    
    @IBAction func didShowArtistTapped(_ sender: Any) {
        print("didShowArtistTapped")
        if let artistUrl = URL(string: viewModel.artistUrl.value) {
            if UIApplication.shared.canOpenURL(artistUrl)
            {
                UIApplication.shared.open(artistUrl)
            } else {
                UIApplication.shared.open(artistUrl)
            }
        }
    }
}
