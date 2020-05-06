//
//  ResultsViewController.swift
//  PixabayCollections
//
//  Created by Russell Archer on 02/05/2020.
//  Copyright © 2020 Russell Archer. All rights reserved.
//

import UIKit

enum CollectionViewSection { case main }

class ResultsViewController: UIViewController {

    var searchText: String?
    var imageData: [PixabayImage] = []
    var imageDataFiltered: [PixabayImage] = []
    var imageDataIsFiltered = false
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<CollectionViewSection, PixabayImage>!
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViewController()
        configCollectionView()
        configSearchBar()
        getResults()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = searchText ?? "Results"
    }
    
    func configCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: CollectionViewHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView!)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PixabayImageCell.self, forCellWithReuseIdentifier: PixabayImageCell.reuseId)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<CollectionViewSection, PixabayImage>(collectionView: collectionView) {
            collectionView, indexPath, data -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PixabayImageCell.reuseId, for: indexPath) as! PixabayImageCell
                cell.previewImageUrl = data.previewURL
                return cell
        }
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, PixabayImage>()
        snapshot.appendSections([.main])
        snapshot.appendItems(imageData)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    private func configSearchBar() {
        navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Filter by tag"
        searchController.obscuresBackgroundDuringPresentation = false
        
        // Ensures that the search bar does not remain on the screen if the user navigates to another
        // view controller while the UISearchController is active.
        definesPresentationContext = true
    }
    
    private func getResults() {
        guard searchText != nil, searchText!.count > 2 else { return }
        
        NetworkHelper.shared.loadImages(searchFor: searchText!) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                print(error.description())
                return
                
            case .success(let data):
                self.imageData = data!
                DispatchQueue.main.async { self.updateData() }
                return
            }
        }
    }
}

// MARK:- UICollectionViewDelegate

extension ResultsViewController: UICollectionViewDelegate {

}

// MARK:- UISearchResultsUpdating delegate

extension ResultsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
//        guard let filterText = searchController.searchBar.text else { return }
    }
}
