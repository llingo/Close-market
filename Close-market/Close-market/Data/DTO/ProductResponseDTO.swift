//
//  ProductResponseDTO.swift
//  Close-market
//
//  Created by Lingo on 2022/05/24.
//

import Foundation

struct ProductResponseDTO: Decodable {
  private enum CodingKeys: String, CodingKey {
    case id, name, thumbnail, currency, price, stock
    case vendorId = "vendor_id"
    case bargainPrice = "bargain_price"
    case discountedPrice = "discounted_price"
    case createdAt = "created_at"
    case issuedAt = "issued_at"
  }
  
  enum Currency: String, Decodable {
    case KRW, USD
  }

  let id: Int
  let vendorId: Int
  let name: String
  let thumbnail: String
  let currency: Currency
  let price: Int
  let bargainPrice: Int
  let discountedPrice: Int
  let stock: Int
  let createdAt: String
  let issuedAt: String
}
