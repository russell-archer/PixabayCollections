//
//  CustomImageView.swift
//  PixabayCollections
//
//  Created by Russell Archer on 08/05/2020.
//  Copyright © 2020 Russell Archer. All rights reserved.
//

import UIKit

protocol CustomImageViewDelegate: class {
    func imageLoadComplete(success: Bool)
}

class CustomImageView: UIImageView {
    
    public weak var delegate: CustomImageViewDelegate?
    public var imageUrl: String? {
        didSet {
            guard let iu = imageUrl else { return }
            NetworkHelper.shared.loadImage(from: iu) { [weak self] img in
                guard let self = self else { return }
                guard let img = img else {
                    DispatchQueue.main.async { self.delegate?.imageLoadComplete(success: false) }
                    return
                }
                
                self.image = img
                DispatchQueue.main.async { self.delegate?.imageLoadComplete(success: true) }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentMode = .scaleAspectFill
        layer.cornerRadius = 10
        clipsToBounds = true  // Ensures the image is rounded
        translatesAutoresizingMaskIntoConstraints = false
    }
}
