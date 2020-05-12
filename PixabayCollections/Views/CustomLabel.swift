//
//  CustomLabel.swift
//  PixabayCollections
//
//  Created by Russell Archer on 11/05/2020.
//  Copyright © 2020 Russell Archer. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {

    var textStyle: UIFont.TextStyle!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.text = "-"
        self.textStyle = .body
        
        config()
    }
    
    convenience init(text: String, style: UIFont.TextStyle) {
        self.init(frame: .zero)
        self.text = text
        self.textStyle = style
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .label
        tintColor = .label
        textAlignment = .left
        minimumScaleFactor = 0.75
        
        // Support for dynamic type
        font = UIFont.preferredFont(forTextStyle: textStyle)
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
    }
}
