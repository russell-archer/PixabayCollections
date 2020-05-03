//
//  CustomGoButton.swift
//  PixabayCollections
//
//  Created by Russell Archer on 02/05/2020.
//  Copyright © 2020 Russell Archer. All rights reserved.
//

import UIKit

class CustomGoButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, backgroundColor: UIColor = UIColor.systemGreen) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
    }
    
    private func config() {
        layer.cornerRadius = 10
        setTitleColor(.black, for: .normal)  // We want our button to have white text independent of light/dark mode
        translatesAutoresizingMaskIntoConstraints = false  // Turn constraints OFF as we'll be using auto layout
        
        // Support for dynamic type
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel?.minimumScaleFactor = 0.5
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.adjustsFontForContentSizeCategory = true
    }
}
