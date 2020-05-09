//
//  CustomSpinner.swift
//  PixabayCollections
//
//  Created by Russell Archer on 08/05/2020.
//  Copyright © 2020 Russell Archer. All rights reserved.
//

import UIKit

class CustomSpinner: UIActivityIndicatorView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    convenience init(text: String) {
        self.init(frame: .zero)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        translatesAutoresizingMaskIntoConstraints = false
        hidesWhenStopped = true
        style = .large
    }
}
