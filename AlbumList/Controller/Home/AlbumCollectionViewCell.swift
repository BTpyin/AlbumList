//
//  AlbumCollectionViewCell.swift
//  AlbumList
//
//  Created by Bowie Tso on 29/3/2023.
//

import UIKit
import RxCocoa
import RxSwift

class AlbumCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "albumCollectionViewCell"

    
    @IBOutlet weak var cellContentView: UIView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var collectionLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    var viewModel: AlbumCollectionViewCellViewModel?
    
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.dropShadow(color: .black, opacity: 0.1, offSet: .zero, radius: 2)
    }

    func setup(viewModel: AlbumCollectionViewCellViewModel) {
        self.viewModel = viewModel
        viewModel.artistName.bind(to: artistLabel.rx.text).disposed(by: disposeBag)
        viewModel.collectionName.bind(to: collectionLabel.rx.text).disposed(by: disposeBag)
        viewModel.copyrightText.bind { [weak self] (text) in
            guard let self = self else {return}
            self.copyrightLabel.text = text
        }.disposed(by: disposeBag)
        viewModel.albumImageUrl.bind(to: albumImageView.rx.imageURL).disposed(by: disposeBag)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
}
