//
//  NetworkService.swift
//  Close-market
//
//  Created by Lingo on 2022/05/24.
//

import Foundation

protocol NetworkService {
  func request(
    endpoint: Requestable,
    completion: @escaping (Result<Data, HTTPError>) -> Void
  ) -> Cancelable
}
