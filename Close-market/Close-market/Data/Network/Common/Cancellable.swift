//
//  Cancellable.swift
//  Close-market
//
//  Created by Lingo on 2022/05/24.
//

protocol Cancellable {
  func suspend()
  func cancel()
}
