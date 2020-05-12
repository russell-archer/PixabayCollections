//
//  PropertyFileHelper.swift
//  PixabayCollections
//
//  Created by Russell Archer on 03/05/2020.
//  Copyright © 2020 Russell Archer. All rights reserved.
//

/*
 
 PropertyFileHelper reads the contents of a .plist file and allows you to read individual
 properties by their keys.
 
 Example usage:
 
 let plistHelper = PropertyFileHelper(file: "MyPlistFile")  // Note: No .plist file extn
 guard plistHelper.hasLoadedProperties else { return }
 guard var myValue = plistHelper.readProperty(key: "MyKey") else { return }
 
 */

import UIKit

struct PropertyFileHelper {
    
    var hasLoadedProperties: Bool { return propertyFile != nil ? true : false }
    private var propertyFile: [String : AnyObject]?

    init(file: String) {
        propertyFile = readPropertyFile(filename: file)
    }
   
    /// Read a property from a dictionary of values that was read from a plist
    func readProperty(key: String) -> String? {
        guard propertyFile != nil else { return nil }
        guard let value = propertyFile![key] as? String else { return nil }
       
        return value
    }
   
    /// Read a plist property file and return a dictionary of values
    func readPropertyFile(filename: String) -> [String : AnyObject]? {
        guard let path = Bundle.main.path(forResource: filename, ofType: "plist") else { return nil }
        guard let contents = NSDictionary(contentsOfFile: path) as? [String : AnyObject] else { return nil }
        
        return contents
    }
}
