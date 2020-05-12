//
//  PixabayData.swift
//  PixabayCollections
//
//  Created by Russell Archer on 03/05/2020.
//  Copyright © 2020 Russell Archer. All rights reserved.
//

import Foundation

struct PixabayData: Codable {
    let totalHits: Int
    let hits: [PixabayImage]
    let total: Int
}

struct PixabayImage: Codable, Hashable {
    let largeImageURL: String
    let webformatHeight: Int
    let webformatWidth: Int
    let likes: Int
    let imageWidth: Int
    let id: Int
    let userId: Int
    let views: Int
    let comments: Int
    let pageURL: String
    let imageHeight: Int
    let webformatURL: String
    let type: String
    let previewHeight: Int
    let tags: String
    let downloads: Int
    let user: String
    let favorites: Int
    let imageSize: Int
    let previewWidth: Int
    let userImageURL: String
    let previewURL: String
}
