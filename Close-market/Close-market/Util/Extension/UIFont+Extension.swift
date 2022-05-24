//
//  UIFont+Extension.swift
//  Close-market
//
//  Created by Lingo on 2022/05/24.
//

import UIKit

extension UIFont {
  enum FontStyle: String {
    case Black
    case Bold
    case DemiLight
    case Light
    case Medium
    case Regular
    case Thin
  }
  
  static func notoSans(size: CGFloat, style: FontStyle = .Regular) -> UIFont? {
    return UIFont(name: "NotoSansCJKkr-\(style)", size: size)
  }
  
  func toDynamical(textStyle: TextStyle = .body) -> UIFont {
    let font = UIFontMetrics(forTextStyle: textStyle)
    return font.scaledFont(for: self)
  }
}
