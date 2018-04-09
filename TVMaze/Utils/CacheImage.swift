//
//  CacheImage.swift
//  TVMaze
//
//  Created by Vitor Silveira on 08/04/2018.
//  Copyright © 2018 Vitor Silveira. All rights reserved.
//

import Foundation

class CacheImage: NSObject {
    static let cache = CacheImage()
    let imageCache = NSCache<AnyObject, AnyObject>()
}
