//
//  PixabayImageCell.swift
//  PixabayCollections
//
//  Created by Russell Archer on 04/05/2020.
//  Copyright © 2020 Russell Archer. All rights reserved.
//

import UIKit

class PixabayImageCell: UICollectionViewCell {
    
    static let reuseId = "PixabayImageCell"
    var previewImageUrl: String = "" {
        didSet {
            guard !previewImageUrl.isEmpty else { return }           
            NetworkHelper.shared.loadImage(from: previewImageUrl) { image in
                guard let image = image else { return }
                self.imageView.image = image
            }
        }
    }
    
    private var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius    = 10
        imageView.clipsToBounds         = true  // Ensures the image is rounded
        imageView.contentMode           = .scaleAspectFill
                
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIConstants.cellPadding),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.cellPadding),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.cellPadding),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
