//
//  Data+Extension.swift
//  Close-market
//
//  Created by Lingo on 2022/05/29.
//

import Foundation

extension Data {
  mutating func appendString(_ text: String) {
    guard let data = text.data(using: .utf8) else { return }
    self.append(data)
  }
}
