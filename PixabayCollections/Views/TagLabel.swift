//
//  TagLabel.swift
//  PixabayCollections
//
//  Created by Russell Archer on 08/05/2020.
//  Copyright © 2020 Russell Archer. All rights reserved.
//

import UIKit

class TagLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    convenience init(text: String) {
        self.init(frame: .zero)
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        translatesAutoresizingMaskIntoConstraints = false        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        minimumScaleFactor = 0.75
        
        // Support for dynamic type
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
    }
}
