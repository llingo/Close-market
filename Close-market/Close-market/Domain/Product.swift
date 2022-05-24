//
//  Product.swift
//  Close-market
//
//  Created by Lingo on 2022/05/24.
//

import Foundation

struct Product {
  let name: String
  let thumbnail: String
  let currency: Currency
  let price: Int
  let bargainPrice: Int
  let discountedPrice: Int
  let stock: Int
  let createdAt: Date
  let issuedAt: Date
}
