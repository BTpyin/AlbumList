//
//  FavouriteListTableViewCell.swift
//  AlbumList
//
//  Created by Bowie Tso on 2/4/2023.
//

import UIKit
import RxCocoa
import RxSwift

class FavouriteListTableViewCell: UITableViewCell {
    
    static let cellId = "FavouriteListTableViewCell"

    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    let viewModel = FavouriteListTableViewCellViewModel()
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupBinding()
        moreButton.setTitle("", for: .normal)
        // Initialization code
    }

    func setupBinding() {
        viewModel.albumImageUrl.bind(to: albumImageView.rx.imageURL).disposed(by: disposeBag)
        
        viewModel.collectionName.bind(to: collectionNameLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.artistName.bind(to: artistNameLabel.rx.text).disposed(by: disposeBag)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
}
