//
//  NetworkHelper.swift
//  PixabayCollections
//
//  Created by Russell Archer on 03/05/2020.
//  Copyright © 2020 Russell Archer. All rights reserved.
//

import Foundation

public enum NetworkHelperError: Error {
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

public struct NetworkHelper {
    
    public static let shared = NetworkHelper()
    private let _plistHelper = PropertyFileHelper(file: "Pixabay")
    
    private init() {}  // Singelton access via
    
    public func loadImages(searchFor: String, completion: @escaping (Result<[PixabayImage]?, NetworkHelperError>) -> Void) {
        print("Loading data from Pixabay...")
        
        guard searchFor.count > 2 else {
            completion(.failure(.searchTermTooShort))
            return
        }
        
        // Example query: https://pixabay.com/api/?key=your-api-key&image_type=photo&q=coffee
        guard _plistHelper.hasLoadedProperties else {
            completion(.failure(.endPointPropertiesMissing))
            return
        }
        
        guard
            let scheme      = _plistHelper.readProperty(key: "scheme"),
            let host        = _plistHelper.readProperty(key: "host"),
            let path        = _plistHelper.readProperty(key: "path"),
            let key         = _plistHelper.readProperty(key: "key"),
            let imageType   = _plistHelper.readProperty(key: "image_type") else {
                
                completion(.failure(.endPointPropertiesMissing))
                return
        }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: key),
            URLQueryItem(name: "image_type", value: imageType),
            URLQueryItem(name: "q", value: searchFor)
        ]

        guard let url = urlComponents.url else {
            completion(.failure(.badUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { json, response, error in
            
            guard json != nil else {
                completion(.failure(.noData))
                return
            }
            
            let httpResponse = response as! HTTPURLResponse
            print("HTTP response status code: \(httpResponse.statusCode)")  // 200 == OK
            
            guard httpResponse.statusCode == 200 else {
                completion(.failure(.badResponse))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let pixabayData = try? decoder.decode(PixabayData.self, from: json!)
            
            guard pixabayData != nil else {
                completion(.failure(.notDecodable))
                return
            }
            
            DispatchQueue.main.async { completion(.success(pixabayData!.hits)) }
        }
        
        task.resume()
    }
}
