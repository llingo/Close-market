//
//  String+Extension.swift
//  Close-market
//
//  Created by Lingo on 2022/05/24.
//

import Foundation

extension String {
  func toDate() -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.date(from: self)
  }
}
