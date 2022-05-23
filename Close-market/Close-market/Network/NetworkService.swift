//
//  NetworkService.swift
//  Close-market
//
//  Created by Lingo on 2022/05/24.
//

import Foundation

protocol NetworkService {
  func get(endpoint: Requestable, completion: @escaping (Result<Data, HTTPError>) -> Cancelable)
  func post(endpoint: Requestable, completion: @escaping (Result<Data, HTTPError>) -> Cancelable)
  func patch(endpoint: Requestable, completion: @escaping (Result<Data, HTTPError>) -> Cancelable)
  func delete(endpoint: Requestable, completion: @escaping (Result<Data, HTTPError>) -> Cancelable)
}
