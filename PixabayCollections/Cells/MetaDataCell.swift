//
//  MetaDataCell.swift
//  PixabayCollections
//
//  Created by Russell Archer on 11/05/2020.
//  Copyright © 2020 Russell Archer. All rights reserved.
//

import UIKit

class MetaDataCell: UITableViewCell {

    static let reuseId = "MetaDataCell"
    
    var keyLabel = CustomLabel(text: "", style: .title2)
    var valLabel = CustomLabel(text: "", style: .title3)

     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         configureCell()
     }
    
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    private func configureCell() {
        // You must add subviews to the *contentView*
        contentView.addSubview(keyLabel)
        contentView.addSubview(valLabel)
        
        keyLabel.textColor = .systemBlue
        valLabel.textColor = .systemOrange

        translatesAutoresizingMaskIntoConstraints = false
       
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            keyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            keyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            keyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            keyLabel.heightAnchor.constraint(equalToConstant: 30),
           
            valLabel.topAnchor.constraint(equalTo: keyLabel.bottomAnchor, constant: padding),
            valLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            valLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            valLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
