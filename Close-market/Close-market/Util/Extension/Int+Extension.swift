//
//  Int+Extension.swift
//  Close-market
//
//  Created by Lingo on 2022/05/24.
//

import Foundation

extension Int {
  var toDecimal: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter.string(for: self) ?? ""
  }
}
