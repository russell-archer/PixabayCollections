//
//  NetworkHelper.swift
//  PixabayCollections
//
//  Created by Russell Archer on 03/05/2020.
//  Copyright © 2020 Russell Archer. All rights reserved.
//

import UIKit

struct NetworkHelper {
    
    static let shared = NetworkHelper()
    private let plistHelper = PropertyFileHelper(file: "Pixabay")
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}  // Singelton access via 'shared' property
    
    func loadImages(searchFor: String, page: Int = 1, completion: @escaping (Result<PixabayData?, NetworkHelperError>) -> Void) {
        guard searchFor.count > 2 else {
            completion(.failure(.searchTermTooShort))
            return
        }
        
        // Example query: https://pixabay.com/api/?key=your-api-key&image_type=photo&q=coffee
        guard plistHelper.hasLoadedProperties else {
            completion(.failure(.endPointPropertiesMissing))
            return
        }
        
        guard
            let scheme      = plistHelper.readProperty(key: "scheme"),
            let host        = plistHelper.readProperty(key: "host"),
            let path        = plistHelper.readProperty(key: "path"),
            let key         = plistHelper.readProperty(key: "key"),
            let imageType   = plistHelper.readProperty(key: "image_type") else {
                
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
            URLQueryItem(name: "page", value: String(page)),
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
            
            DispatchQueue.main.async { completion(.success(pixabayData!)) }
        }
        
        task.resume()
    }
    
    func loadImage(from imageUrl: String, completion: @escaping (UIImage?) -> Void) {
        if let image = loadImageFromCache(key: imageUrl) { completion(image) }
        
        guard let url = URL(string: imageUrl) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            let httpResponse = response as! HTTPURLResponse
            guard httpResponse.statusCode == 200 else {
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            if image != nil { self.cache.setObject(image!, forKey: NSString(string: imageUrl)) }
            
            DispatchQueue.main.async { completion(image) }
        }
        
        task.resume()
    }
    
    private func loadImageFromCache(key: String) -> UIImage? { cache.object(forKey: NSString(string: key)) }
}
