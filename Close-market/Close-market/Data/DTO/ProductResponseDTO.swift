//
//  ProductResponseDTO.swift
//  Close-market
//
//  Created by Lingo on 2022/05/24.
//

import Foundation

struct ProductResponseDTO: Decodable {
  private enum CodingKeys: String, CodingKey {
    case offset, limit
    case pageNumber = "page_no"
    case itemsPerPage = "items_per_page"
    case totalCount = "total_count"
    case lastPage = "last_page"
    case hasNext = "has_next"
    case hasPrev = "has_prev"
    case products = "pages"
  }
  
  let pageNumber: Int
  let itemsPerPage: Int
  let totalCount: Int
  let offset: Int
  let limit: Int
  let lastPage: Int
  let hasNext: Bool
  let hasPrev: Bool
  let products: [ProductDTO]
}

struct ProductDTO: Decodable {
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
