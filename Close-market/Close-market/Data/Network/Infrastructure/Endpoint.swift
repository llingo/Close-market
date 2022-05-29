//
//  Endpoint.swift
//  Close-market
//
//  Created by Lingo on 2022/05/24.
//

import Foundation

protocol Requestable {
  var path: String { get }
  var method: HTTPMethod { get }
  var headers: [String: String] { get }
  var queries: [String: Any] { get }
  var payload: Data? { get }
  
  func create(with configuration: NetworkConfiguration) throws -> URLRequest
}

final class Endpoint: Requestable {
  let path: String
  let method: HTTPMethod
  let headers: [String : String]
  let queries: [String : Any]
  let payload: Data?
  
  init(
    path: String,
    method: HTTPMethod,
    headers: [String : String] = [:],
    queries: [String : Any] = [:],
    payload: Data? = nil
  ) {
    self.path = path
    self.method = method
    self.headers = headers
    self.queries = queries
    self.payload = payload
  }
  
  func create(with configuration: NetworkConfiguration) throws -> URLRequest {
    let url = try createURL(with: configuration)
    var headers = configuration.headers
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    self.headers.forEach { headers.updateValue($0.value, forKey: $0.key) }
    request.allHTTPHeaderFields = headers
    if let httpBody = payload {
      request.httpBody = httpBody
    }
    return request
  }
  
  private func createURL(with configuration: NetworkConfiguration) throws -> URL {
    let baseURL = configuration.baseURL.absoluteString.last == "/"
      ? configuration.baseURL.absoluteString
      : configuration.baseURL.absoluteString.appending("/")
    let endpoint = baseURL.appending(path)
    
    var component = URLComponents(string: endpoint)
    var queryItems = [URLQueryItem]()
    self.queries.forEach {
      queryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
    }
    component?.queryItems = queryItems.isEmpty == false ? queryItems : nil
    guard let url = component?.url else { throw NetworkError.InvalidateURL }
    return url
  }
}
