//
//  NavHelper.swift
//  PixabayCollections
//
//  Created by Russell Archer on 11/05/2020.
//  Copyright © 2020 Russell Archer. All rights reserved.
//

import UIKit

class NavHelper {
    
    @available(iOS 13.0, *)
    class func currentViewController() -> UIViewController? {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let sceneDelegate = scene.delegate as? SceneDelegate,
              let window = sceneDelegate.window,
              let rootVC = window.rootViewController else { return nil }
        
        return rootVC is UINavigationController ? (rootVC as! UINavigationController).visibleViewController : rootVC
    }
    
    @available(iOS 13.0, *)
    class func navigationController() -> UINavigationController? {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let sceneDelegate = scene.delegate as? SceneDelegate,
              let window = sceneDelegate.window,
              let rootVC = window.rootViewController,
              rootVC is UINavigationController else { return nil }
        
        return rootVC as? UINavigationController
    }
}
