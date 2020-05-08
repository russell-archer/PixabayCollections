//
//  TagCell.swift
//  PixabayCollections
//
//  Created by Russell Archer on 08/05/2020.
//  Copyright © 2020 Russell Archer. All rights reserved.
//

import UIKit

class TagCell: UICollectionViewCell {
    
    public static let reuseId = "TagCell"
    public var text = "" { didSet { tagLabel.text = text }}
    private var tagLabel = TagLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        contentView.addSubview(tagLabel)
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tagLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIConstants.cellPadding),
            tagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.cellPadding),
            tagLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.cellPadding),
            tagLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
