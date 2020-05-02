//
//  ResultsViewController.swift
//  PixabayCollections
//
//  Created by Russell Archer on 02/05/2020.
//  Copyright © 2020 Russell Archer. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    var searchText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Results"
        print("Searching for \(searchText!)...")
    }
}
