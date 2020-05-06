//
//  PixabayImageCell.swift
//  PixabayCollections
//
//  Created by Russell Archer on 04/05/2020.
//  Copyright © 2020 Russell Archer. All rights reserved.
//

import UIKit

public class PixabayImageCell: UICollectionViewCell {
    
    public static let reuseId = "PixabayImageCell"
    public var previewImageUrl: String = "" {
        didSet {
            guard !previewImageUrl.isEmpty else { return }
            let url = URL(string: previewImageUrl)
            guard let imageData = try? Data(contentsOf: url!) else {
                imageView.image = UIImage(named: "owl")  // Placeholder for missing preview image
                return
            }
            
            imageView.image = UIImage(data: imageData)
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
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true  // Ensures the image is rounded
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIConstants.cellPadding),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.cellPadding),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.cellPadding),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
