//
//  MetaDataKeys.swift
//  PixabayCollections
//
//  Created by Russell Archer on 11/05/2020.
//  Copyright © 2020 Russell Archer. All rights reserved.
//

import Foundation

enum MetaDataKeys: Int {
    case largeImageURL
    case webformatHeight
    case webformatWidth
    case likes
    case imageWidth
    case id
    case userId
    case views
    case comments
    case pageURL
    case imageHeight
    case webformatURL
    case type
    case previewHeight
    case tags
    case downloads
    case user
    case favorites
    case imageSize
    case previewWidth
    case userImageURL
    case previewURL
    
    func propertyName() -> String {
        switch self {
        case .largeImageURL:    return "largeImageURL"
        case .webformatHeight:  return "webformatHeight"
        case .webformatWidth:   return "webformatWidth"
        case .likes:            return "likes"
        case .imageWidth:       return "imageWidth"
        case .id:               return "id"
        case .userId:           return "userId"
        case .views:            return "views"
        case .comments:         return "comments"
        case .pageURL:          return "pageURL"
        case .imageHeight:      return "imageHeight"
        case .webformatURL:     return "webformatURL"
        case .type:             return "type"
        case .previewHeight:    return "previewHeight"
        case .tags:             return "tags"
        case .downloads:        return "downloads"
        case .user:             return "user"
        case .favorites:        return "favorites"
        case .imageSize:        return "imageSize"
        case .previewWidth:     return "previewWidth"
        case .userImageURL:     return "userImageURL"
        case .previewURL:       return "previewURL"
        }
    }
}
