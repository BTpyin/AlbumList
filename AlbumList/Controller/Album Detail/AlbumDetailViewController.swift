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
    @IBOutlet weak var albumImageBackgroundView: UIView!
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
    
    weak var delegate: AlbumDetailViewControllerDeletgate?
    
    let disposeBag = DisposeBag()
    
    let showAlbumContainerViewGradientLayer = CAGradientLayer()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        isFavouriteImageView.dropShadow(color: .black, opacity: 0.1, offSet: .zero, radius: 2)
        showAlbumContainerViewGradientLayer.frame = showAlbumContainerView.bounds
        showAlbumContainerViewGradientLayer.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0.8).cgColor,
                                                        UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor,
                                                        UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor]
//        showAlbumContainerViewGradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
//        showAlbumContainerViewGradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        showAlbumContainerView.layer.sublayers?.removeAll(where: {$0 is CAGradientLayer})
        showAlbumContainerView.layer.insertSublayer(self.showAlbumContainerViewGradientLayer, at: 0)
        showAlbumContainerView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
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
    }
    @IBAction func didShowArtistTapped(_ sender: Any) {
        print("didShowArtistTapped")
    }
}
