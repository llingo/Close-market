//
//  ImageCache.swift
//  Close-market
//
//  Created by Lingo on 2022/05/25.
//

import UIKit

final class ImageCache {
  static let cache = NSCache<NSString, UIImage>()
  private init() {}
}
