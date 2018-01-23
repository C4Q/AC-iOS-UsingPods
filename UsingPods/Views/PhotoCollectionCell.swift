//
//  PhotoCollectionCell.swift
//  UsingPods
//
//  Created by Alex Paul on 1/22/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class PhotoCollectionCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK:- Setup Views
extension PhotoCollectionCell {
    private func setupViews() {
        backgroundColor = .white
        setupImageView()
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}

// MARK:- Helper Methods
extension PhotoCollectionCell {
    public func configureCell(photo: Photo) {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: photo.url_m, placeholder: UIImage.init(named: "placeholder-image"), options: nil, progressBlock: nil) { (image, error, cacheType, url) in}
    }
}
