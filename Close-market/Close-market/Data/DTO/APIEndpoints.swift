//
//  APIEndpoints.swift
//  Close-market
//
//  Created by Lingo on 2022/05/24.
//

import Foundation

struct APIEndpoints {
  static func getHealthChecker() -> Endpoint {
    return Endpoint(path: "healthChecker", method: .Get)
  }
  
  static func getProductOne(
    productId: Int
  ) -> Endpoint {
    return Endpoint(
      path: "api/products/\(productId)",
      method: .Get
    )
  }
  
  static func getProductAll(
    queries: [String: Any]
  ) -> Endpoint {
    return Endpoint(
      path: "api/products",
      method: .Get,
      queries: queries
    )
  }
  
  static func createProduct(
    payload: Data?,
    headers: [String : String]
  ) -> Endpoint {
    return Endpoint(
      path: "api/products",
      method: .Post,
      headers: headers,
      payload: payload
    )
  }
  
  static func updateProduct(
    productId: Int,
    payload: Data?,
    headers: [String : String]
  ) -> Endpoint {
    return Endpoint(
      path: "api/products/\(productId)",
      method: .Patch,
      headers: headers,
      payload: payload
    )
  }
  
  static func searchProductSecretKey(
    productId: Int,
    payload: Data?,
    headers: [String : String]
  ) -> Endpoint {
    return Endpoint(
      path: "api/products/\(productId)/secret",
      method: .Post,
      headers: headers,
      payload: payload
    )
  }
  
  static func deleteProduct(
    productId: Int,
    secretKey: String,
    headers: [String : String]
  ) -> Endpoint {
    return Endpoint(
      path: "api/products/\(productId)/\(secretKey)",
      method: .Delete,
      headers: headers
    )
  }
}
