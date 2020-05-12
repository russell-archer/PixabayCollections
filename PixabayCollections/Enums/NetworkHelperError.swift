//
//  NetworkHelperError.swift
//  PixabayCollections
//
//  Created by Russell Archer on 12/05/2020.
//  Copyright © 2020 Russell Archer. All rights reserved.
//

import Foundation

enum NetworkHelperError: Error {
    case noError
    case searchTermTooShort
    case endPointPropertiesMissing
    case internalError
    case badUrl
    case badResponse
    case noData
    case notDecodable
    
    func description() -> String {
        switch self {
            case .noError:                      return "No Error"
            case .searchTermTooShort:           return "Search Term too short"
            case .endPointPropertiesMissing:    return "End Point Properties Missing"
            case .internalError:                return "Internal Error"
            case .badUrl:                       return "Bad URL"
            case .badResponse:                  return "Bad Response"
            case .noData:                       return "No Data"
            case .notDecodable:                 return "Not Decodable (JSON couldn't be parsed)"
        }
    }
}
