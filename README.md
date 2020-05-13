# PixabayCollections

Programmatic UICollectionView with Diffable Data Source

## Overview

This demo app uses the Pixabay image API to return metadata related to a search item provided by the user.

1. The search term is entered on the app’s main screen
2. Results are shown in a collection view on a second screen where the user can filter the list by tag using a search bar
3. Tapping on an image will show it in detail on a third page
4. Tapping the detail image modally presents a view showing all the image's available metadata
5. Long-pressing the image on the detail screen will present a menu of options (save to photos lib, share and show metadata)

![](./readme-assets/img1.jpg)

* The UI will be created 100% programmatically (there will be no storyboard)
* The three main screens will be navigated using a UINavigationController
* Results will be displayed in UICollectionView with a UICollectionViewDiffableDataSource
* Images will be cached in an NSCache
* Results will be paged (20 items per page). When the user scrolls to the bottom of the collection view additional results will be requested

<p align="center">
  <img src="./readme-assets/pixabay-collections.gif">
</p>

___

## The Search View Controller

The search view controller is very simple: a UITextField and UIButton:

![](./readme-assets/img2.jpg)

When the button's tapped an instance of the ResultsViewController is created and pushed onto the navigation controller's stack.
