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
    var availableTags: [String] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<CollectionViewSection, PixabayImage>!
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViewController()
        configNavBar()
        configCollectionView()
        configureDataSource()
        configSearchBar()
        getSearchResults()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = searchText ?? "Results"
    }
    
    private func configNavBar() {
        let showTagsButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showTagsTapped))
        navigationItem.rightBarButtonItem = showTagsButton
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
        snapshot.appendItems(imageDataIsFiltered ? imageDataFiltered : imageData)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    @objc func showTagsTapped() {
        let tagsViewController = TagsViewController()
        tagsViewController.delegate = self
        tagsViewController.allTags = availableTags
        present(tagsViewController, animated: true)
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
    
    private func getSearchResults() {
        guard searchText != nil, searchText!.count > 2 else { return }
        
        NetworkHelper.shared.loadImages(searchFor: searchText!) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                print(error.description())
                return
                
            case .success(let data):
                self.imageDataIsFiltered = false
                self.imageData = data!
                self.getAvailableTags()
                DispatchQueue.main.async { self.updateData() }
                return
            }
        }
    }
    
    private func getAvailableTags() {
        availableTags.removeAll()
        let arrayOfTagArrays = imageData.map { $0.tags.split(separator: ",") }  // Array of string arrays of comma-delimited tags associated with each image
        arrayOfTagArrays.forEach {
            $0.forEach { tagArray in
                let tag = String(tagArray.trimmingCharacters(in: .whitespaces))
                if !availableTags.contains(tag) { availableTags.append(tag) }
            }
        }
    }
}

// MARK:- UICollectionViewDelegate

extension ResultsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = imageDataIsFiltered ? imageDataFiltered[indexPath.row] : imageData[indexPath.row]
        print("Item selected tags: \(selectedItem.tags)")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // Detect when at bottom of list
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//        let height = scrollView.frame.size.height
//
//        if offsetY > contentHeight - height {
//            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
//            page += 1
//            getFollowers(username: username, page: page)
//        }
    }
}

// MARK:- UISearchResultsUpdating delegate

extension ResultsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filterText = searchController.searchBar.text, !filterText.isEmpty else {
            imageDataFiltered.removeAll()
            imageDataIsFiltered = false
            updateData()
            return
        }
        
        imageDataIsFiltered = true
        imageDataFiltered = imageData.filter { pixabayImage in
            pixabayImage.tags.lowercased().contains(filterText.lowercased())
        }
        
        updateData()
    }
}

// MARK:- TagSelectionDelegate
extension ResultsViewController: TagSelectionDelegate {
    
    func tagSelected(was tag: String) {
        searchController.searchBar.text = tag
        updateSearchResults(for: searchController)
    }
}
