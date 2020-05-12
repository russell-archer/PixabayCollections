//
//  MetaDataHelper.swift
//  PixabayCollections
//
//  Created by Russell Archer on 12/05/2020.
//  Copyright © 2020 Russell Archer. All rights reserved.
//

import Foundation

struct MetaDataHelper {
    /// Convert a PixabayImage struct into a key-value dictionary usable in a table view
    /// - Returns: Returns a key-value dictionary
    static func convertDataToDictionary(data: PixabayImage) -> [String : String] {
        var metaDict = [String : String]()
        
        metaDict["largeImageURL"]       = data.largeImageURL
        metaDict["webformatHeight"]     = String(data.webformatHeight)
        metaDict["webformatWidth"]      = String(data.webformatWidth)
        metaDict["likes"]               = String(data.likes)
        metaDict["imageWidth"]          = String(data.imageWidth)
        metaDict["id"]                  = String(data.id)
        metaDict["userId"]              = String(data.userId)
        metaDict["views"]               = String(data.views)
        metaDict["comments"]            = String(data.comments)
        metaDict["pageURL"]             = data.pageURL
        metaDict["imageHeight"]         = String(data.imageHeight)
        metaDict["webformatURL"]        = data.webformatURL
        metaDict["type"]                = data.type
        metaDict["previewHeight"]       = String(data.previewHeight)
        metaDict["tags"]                = data.tags
        metaDict["downloads"]           = String(data.downloads)
        metaDict["user"]                = data.user
        metaDict["favorites"]           = String(data.favorites)
        metaDict["imageSize"]           = String(data.imageSize)
        metaDict["previewWidth"]        = String(data.previewWidth)
        metaDict["userImageURL"]        = data.userImageURL
        metaDict["previewURL"]          = data.previewURL

        return metaDict
    }
    
    static func convertRowToDictKey(row: Int) -> String? {
        guard let metaDataKeys = MetaDataKeys(rawValue: row) else { return nil }
        return metaDataKeys.propertyName()
    }
}
