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
  
  func uploadProductOne(
    product: ProductRequestDTO,
    images: [ImageFile],
    completion: @escaping (Result<Product, NetworkError>) -> Void
  ) {
    guard let jsonData = try? JSONEncoder().encode(product) else { return }
    
    let boundary = UUID().uuidString
    let headers = [
      "Content-Type": "multipart/form-data; boundary=\(boundary)",
      "identifier": "f81d1b5f-d1b7-11ec-9676-094e9d1692c2"
    ]
    
    let boundaryPrefix = "--\(boundary)\r\n"
    
    var data = Data()
    data.appendString(boundaryPrefix)
    data.appendString("Content-Disposition: form-data; name=\"params\"\r\n")
    data.appendString("Content-Type: application/json\r\n\r\n")
    data.append(jsonData)
    data.appendString("\r\n")
    
    for image in images {
      data.appendString(boundaryPrefix)
      data.appendString("Content-Disposition: form-data; name=\"images\"; filename=\"\(image.name)\"\r\n")
      data.appendString("Content-Type: image/jpg\r\n\r\n")
      data.append(image.data)
      data.appendString("\r\n")
    }
    data.appendString("--\(boundary)--\r\n")
    
    let endpoint = APIEndpoints.createProduct(payload: data, headers: headers)
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
