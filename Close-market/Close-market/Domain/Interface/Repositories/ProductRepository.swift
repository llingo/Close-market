//
//  ProductRepository.swift
//  Close-market
//
//  Created by Lingo on 2022/05/24.
//

import Foundation

protocol ProductRepository {
  func fetchProductAll(
    pageNumber: Int,
    itemsPerPage: Int,
    completion: @escaping (Result<[Product], NetworkError>) -> Void
  )
  
  func fetchProductOne(
    productId: Int,
    completion: @escaping (Result<Product, NetworkError>) -> Void
  )
  
  func uploadProductOne(
    product: ProductRequestDTO,
    images: [ImageFile],
    completion: @escaping (Result<Product, NetworkError>) -> Void
  )
}
