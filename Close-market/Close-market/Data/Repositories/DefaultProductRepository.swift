//
//  DefaultProductRepository.swift
//  Close-market
//
//  Created by Lingo on 2022/05/24.
//

import Foundation

final class DefaultProductRepository: ProductRepository {
  private let service: NetworkService
  
  init(service: NetworkService) {
    self.service = service
  }
  
  func fetchProductAll(
    pageNumber: Int,
    itemsPerPage: Int,
    completion: @escaping (Result<[Product], NetworkError>) -> Void
  ) {
    let queries = ["page_no": pageNumber, "items_per_page": itemsPerPage]
    let endpoint = APIEndpoints.getProductAll(queries: queries)
    let _ = service.request(endpoint: endpoint) { result in
      switch result {
      case let .success(data):
        if let productResponseDTO = try? JSONDecoder().decode(ProductResponseDTO.self, from: data) {
          let products = productResponseDTO.products.map { $0.toDomain() }
          completion(.success(products))
        }
      case let .failure(error):
        print(error)
      }
    }
  }
  
  func fetchProductOne(
    productId: Int,
    completion: @escaping (Result<Product, NetworkError>) -> Void
  ) {
    let endpoint = APIEndpoints.getProductOne(productId: productId)
    let _ = service.request(endpoint: endpoint) { result in
      switch result {
      case let .success(data):
        print(data)
      case let .failure(error):
        print(error)
      }
    }
  }
}
