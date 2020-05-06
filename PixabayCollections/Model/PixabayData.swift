//
//  PixabayData.swift
//  PixabayCollections
//
//  Created by Russell Archer on 03/05/2020.
//  Copyright © 2020 Russell Archer. All rights reserved.
//

import Foundation

public struct PixabayData: Codable {
    var totalHits: Int
    var hits: [PixabayImage]
    var total: Int
}

public struct PixabayImage: Codable, Hashable {
    var largeImageURL: String
    var webformatHeight: Int
    var webformatWidth: Int
    var likes: Int
    var imageWidth: Int
    var id: Int
    var userId: Int
    var views: Int
    var comments: Int
    var pageURL: String
    var imageHeight: Int
    var webformatURL: String
    var type: String
    var previewHeight: Int
    var tags: String
    var downloads: Int
    var user: String
    var favorites: Int
    var imageSize: Int
    var previewWidth: Int
    var userImageURL: String
    var previewURL: String
}
