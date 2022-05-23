//
//  NetworkError.swift
//  Close-market
//
//  Created by Lingo on 2022/05/24.
//

import Foundation

enum NetworkError: LocalizedError {
  case BadRequest
  case NotFound
  case InternalServer
  
  var errorDescription: String? {
    switch self {
    case .BadRequest:
      return "BAD_REQUEST_ERROR"
    case .NotFound:
      return "NOT_FOUND_ERROR"
    case .InternalServer:
      return "INTERNAL_SERVER_ERROR"
    }
  }
}

