//
//  Product.swift
//  Close-market
//
//  Created by Lingo on 2022/05/24.
//

import Foundation

struct Product: Encodable {
  private enum CodingKeys: String, CodingKey {
    case name
    case descriptions
    case price
    case currency
    case discountedPrice = "discounted_price"
    case stock
    case secret
  }
  
  enum Currency: String, Encodable {
    case KRW, USD
  }
  
  let name: String
  let descriptions: String
  let price: Int
  let currency: Currency
  let discountedPrice: Int?
  let stock: Int?
  let secret: String
}
