//
//  AlbumCollectionViewCell.swift
//  AlbumList
//
//  Created by Bowie Tso on 29/3/2023.
//

import UIKit
import RxCocoa
import RxSwift
import SwiftyUserDefaults

protocol AlbumCollectionViewCellDelegate: AnyObject {
    func didFavouriteViewTapped(collectionId: Int)
}

class AlbumCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "albumCollectionViewCell"

    
    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var collectionLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var isFavouriteImageView: UIImageView!
    
    var viewModel: AlbumCollectionViewCellViewModel?
    
    weak var delegate: AlbumCollectionViewCellDelegate?
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isFavouriteImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didIsFavouriteTapped)))
        isFavouriteImageView.isUserInteractionEnabled = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        isFavouriteImageView.dropShadow(color: .black, opacity: 0.1, offSet: .zero, radius: 2)
    }

    func setup(viewModel: AlbumCollectionViewCellViewModel) {
        self.viewModel = viewModel
        viewModel.artistName.bind(to: artistLabel.rx.text).disposed(by: disposeBag)
        viewModel.collectionName.bind(to: collectionLabel.rx.text).disposed(by: disposeBag)

        viewModel.albumImageUrl.bind(to: albumImageView.rx.imageURL).disposed(by: disposeBag)
        
        viewModel.isFavourite.bind { [weak self] (isFavourite) in
            guard let self = self else {return}
            if isFavourite {
                self.isFavouriteImageView.tintColor = .red
                self.isFavouriteImageView.image = UIImage(systemName: "heart.fill")
            } else {
                self.isFavouriteImageView.tintColor = .white
                self.isFavouriteImageView.image = UIImage(systemName: "heart")
            }
        }.disposed(by: disposeBag)
    }
    
    @objc func didIsFavouriteTapped() {
        if let collectionId = viewModel?.collectionId.value {
            viewModel?.isFavourite.accept(!(viewModel?.isFavourite.value ?? true))
            delegate?.didFavouriteViewTapped(collectionId: collectionId)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
}
