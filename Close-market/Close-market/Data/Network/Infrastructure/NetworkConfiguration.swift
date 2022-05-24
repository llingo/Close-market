//
//  NetworkConfiguration.swift
//  Close-market
//
//  Created by Lingo on 2022/05/24.
//

import Foundation

protocol NetworkConfiguration {
  var baseURL: URL { get }
  var headers: [String: String] { get }
  var queries: [String: String] { get }
}

struct DefaultNetworkConfiguration: NetworkConfiguration {
  let baseURL: URL
  let headers: [String : String]
  let queries: [String : String]
  
  init(
    baseURL: URL,
    headers: [String: String] = [:],
    queries: [String: String] = [:]
  ) {
    self.baseURL = baseURL
    self.headers = headers
    self.queries = queries
  }
}
