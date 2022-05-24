//
//  HomeViewController.swift
//  Close-market
//
//  Created by Lingo on 2022/05/24.
//

import UIKit

final class HomeViewController: UIViewController {
  @IBOutlet weak var regionLabel: UIButton!
  @IBOutlet weak var collectionView: UICollectionView!
  
  private lazy var refreshControl: UIRefreshControl = {
    let refresh = UIRefreshControl()
    refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    return refresh
  }()
  
  private var products = [Product]() {
    didSet {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView.refreshControl = refreshControl
    self.fetchProducts()
  }
  
  @objc private func refreshData(_ sender: UIRefreshControl) {
    self.fetchProducts()
    self.refreshControl.endRefreshing()
  }
  
  private func fetchProducts() {
    let baseURL = "https://market-training.yagom-academy.kr"
    let config = DefaultNetworkConfiguration(baseURL: URL(string: baseURL)!)
    let service = DefaultNetworkService(configuration: config, session: .shared)
    let repo = DefaultProductRepository(service: service)
    repo.fetchProductAll(pageNumber: 1, itemsPerPage: 100) { [weak self] result in
      guard case let .success(products) = result else { return }
      self?.products = products
    }
  }
}

// MARK: - Delegate

extension HomeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return CGSize(width: view.frame.width, height: view.frame.height * 0.17)
  }
}

// MARK: - DataSource

extension HomeViewController: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return self.products.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: HomeCollectionViewCell.identifier,
      for: indexPath) as? HomeCollectionViewCell else {
      return UICollectionViewCell()
    }
    
    cell.configure(with: products[indexPath.row])
    return cell
  }
}
