//
//  UIImageView+Extension.swift
//  Close-market
//
//  Created by Lingo on 2022/05/25.
//

import UIKit

extension UIImageView {
  func setImage(with urlString: String) -> Cancellable? {
    guard let url = URL(string: urlString) else { return nil }
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      guard error == nil, let data = data else { return }
      guard let response = response as? HTTPURLResponse else { return }
      guard (200..<300).contains(response.statusCode) else { return }
      DispatchQueue.main.async {
        self.image = UIImage(data: data)
      }
    }
    task.resume()
    return task
  }
}
