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

public struct PropertyFileHelper {
    
    public var hasLoadedProperties: Bool { return _propertyFile != nil ? true : false }
    private var _propertyFile: [String : AnyObject]?

    init(file: String) {
        _propertyFile = readPropertyFile(filename: file)
    }
   
    /// Read a property from a dictionary of values that was read from a plist
    public func readProperty(key: String) -> String? {
        guard _propertyFile != nil else { return nil }
        guard let value = _propertyFile![key] as? String else { return nil }
       
        return value
    }
   
    /// Read a plist property file and return a dictionary of values
    public func readPropertyFile(filename: String) -> [String : AnyObject]? {
        guard let path = Bundle.main.path(forResource: filename, ofType: "plist") else { return nil }
        guard let contents = NSDictionary(contentsOfFile: path) as? [String : AnyObject] else { return nil }
        
        return contents
    }
}
