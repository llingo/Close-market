//
//  DefaultNetworkService.swift
//  Close-market
//
//  Created by Lingo on 2022/05/24.
//

import Foundation

final class DefaultNetworkService: NetworkService {
  private let configuration: NetworkConfiguration
  private let session: URLSession
  
  init(
    configuration: NetworkConfiguration,
    session: URLSession
  ) {
    self.configuration = configuration
    self.session = session
  }
  
  func request(
    endpoint: Requestable,
    completion: @escaping (Result<Data, NetworkError>) -> Void
  ) -> Cancellable? {
    do {
      let urlRequest = try endpoint.create(with: configuration)
      return self.request(with: urlRequest, completion: completion)
    } catch {
      completion(.failure(.InvalidateURL))
      return nil
    }
  }
  
  private func request(
    with urlRequest: URLRequest,
    completion: @escaping (Result<Data, NetworkError>) -> Void
  ) -> Cancellable {
    let task = session.dataTask(with: urlRequest) { data, response, error in
      guard error == nil, let data = data else { return }
      guard let response = response as? HTTPURLResponse else { return }
      
      switch response.statusCode {
      case 200..<300: completion(.success(data))
      case 400: completion(.failure(.BadRequest))
      case 404: completion(.failure(.NotFound))
      default: completion(.failure(.InternalServer))
      }
    }
    task.resume()
    return task
  }
}
