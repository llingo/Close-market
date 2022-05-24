//
//  UIImageView+Extension.swift
//  Close-market
//
//  Created by Lingo on 2022/05/25.
//

import UIKit

extension UIImageView {
  func setImage(with urlString: String) -> Cancellable? {
    if let image = ImageCache.cache.object(forKey: urlString as NSString) {
      self.image = image
    }
    guard let url = URL(string: urlString) else { return nil }
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      guard error == nil, let data = data, let image = UIImage(data: data) else { return }
      guard let response = response as? HTTPURLResponse else { return }
      guard (200..<300).contains(response.statusCode) else { return }
      
      ImageCache.cache.setObject(image, forKey: urlString as NSString)
      DispatchQueue.main.async {
        self.image = image
      }
    }
    task.resume()
    return task
  }
}
