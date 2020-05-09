//
//  DetailViewController.swift
//  PixabayCollections
//
//  Created by Russell Archer on 02/05/2020.
//  Copyright © 2020 Russell Archer. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    public var pixabayImage: PixabayImage? {
        didSet {
            guard pixabayImage != nil else { return }
            spinner.startAnimating()
            imageView.imageUrl = pixabayImage!.largeImageURL
        }
    }
    
    private var imageView = CustomImageView(frame: .zero)
    private var spinner = CustomSpinner(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewController()
        configViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Details"
    }
    
    private func configViews() {
        imageView.delegate = self
        view.addSubview(imageView)
        view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 60),
            spinner.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

extension DetailViewController: CustomImageViewDelegate {
    
    func imageLoadComplete(success: Bool) {
        self.spinner.stopAnimating()
    }
}
