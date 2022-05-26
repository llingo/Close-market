//
//  UIImage+Extension.swift
//  Close-market
//
//  Created by Lingo on 2022/05/27.
//

import UIKit

extension UIImage {
  func resize(with height: CGFloat) -> UIImage {
    let scale = height / self.size.height
    let width = self.size.width * scale
    let size = CGSize(width: width, height: height)
    
    let render = UIGraphicsImageRenderer(size: size)
    let renderedImage = render.image { _ in
      self.draw(in: CGRect(origin: .zero, size: size))
    }
    return renderedImage
  }
}
