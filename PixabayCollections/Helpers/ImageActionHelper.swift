//
//  ImageActionHelper.swift
//  PixabayCollections
//
//  Created by Russell Archer on 11/05/2020.
//  Copyright © 2020 Russell Archer. All rights reserved.
//

import UIKit

struct ImageActionHelper {
    
    static func saveToPhotosLibrary(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    static func share(image: UIImage) {
        guard let vc = NavHelper.currentViewController() else { return }
        let shareVc = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        vc.present(shareVc, animated: true, completion: nil)
    }
    
    static func showMetaData(data: PixabayImage) {
        guard let nc = NavHelper.navigationController() else { return }
        let mdvc = MetaDataViewController()
        mdvc.pixabayImage = data
        nc.present(mdvc, animated: true)
    }
}
