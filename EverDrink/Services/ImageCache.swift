//
//  ImageCache.swift
//  EverDrink
//
//  Created by Данил Прокопенко on 19.09.2022.
//

import Foundation
import UIKit

class ImageCache {

    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
