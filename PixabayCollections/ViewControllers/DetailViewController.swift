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
            loading = true
            imageView.imageUrl = pixabayImage!.largeImageURL  // imageLoadComplete(success:) called when image loaded
        }
    }
    
    private var loading = false
    private var imageView = CustomImageView(frame: .zero)
    private var spinner = CustomSpinner(frame: .zero)
    private var tapGesture: UITapGestureRecognizer!
    private var menuInteraction: UIContextMenuInteraction!
    private var imageHelper: ImageActionHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewController()
        configViews()
        configGestures()
        configContextMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func imageTapped() {
        guard pixabayImage != nil else { return }
        ImageActionHelper.showMetaData(data: pixabayImage!)
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
    
    private func configGestures() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func configContextMenu() {
        menuInteraction = UIContextMenuInteraction(delegate: self)

        view.isUserInteractionEnabled = true  // If you don't enable interactions the menu a long press doesn't work
        view.addInteraction(menuInteraction)  // You can now long press on the imageview
    }
}

extension DetailViewController: CustomImageViewDelegate {
    
    func imageLoadComplete(success: Bool) {
        self.spinner.stopAnimating()
        loading = false
    }
}

extension DetailViewController: UIContextMenuInteractionDelegate {
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        guard !loading, pixabayImage != nil, imageView.image != nil else { return nil }
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self] suggestedActions in
            guard let self = self else { return nil }
            return self.createMenu(image: self.imageView.image!)
        }
    }
    
    func createMenu(image: UIImage) -> UIMenu {
        typealias iah = ImageActionHelper
        
        let saveToPhotos    = UIAction(title: "Save to Photos", image: UIImage(systemName: "photo")) { action in iah.saveToPhotosLibrary(image: image) }
        let share           = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { action in iah.share(image: image) }
        let showMetaData    = UIAction(title: "Show Metatdata", image: UIImage(systemName: "book.circle")) { action in iah.showMetaData(data: self.pixabayImage!) }
        let cancel          = UIAction(title: "Cancel", image: UIImage(systemName: "xmark.circle")) { action in }
        
        return UIMenu(title: "Image Options", image: nil, identifier: nil, children: [saveToPhotos, showMetaData, share, cancel])
    }
}
