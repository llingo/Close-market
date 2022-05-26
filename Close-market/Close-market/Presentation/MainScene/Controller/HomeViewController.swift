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
  
  private var currentPageNumber = 1
  private var itemsPerPage = 20
  
  private lazy var refreshControl: UIRefreshControl = {
    let refresh = UIRefreshControl()
    refresh.tintColor = .systemOrange
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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.paging()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView.refreshControl = refreshControl
  }
  
  @objc private func refreshData(_ sender: UIRefreshControl) {
    if sender.isRefreshing {
      self.fetchProducts()
      self.currentPageNumber = 1
      self.refreshControl.endRefreshing()
    }
  }
  
  private func fetchProducts() {
    let baseURL = "https://market-training.yagom-academy.kr"
    let config = DefaultNetworkConfiguration(baseURL: URL(string: baseURL)!)
    let service = DefaultNetworkService(configuration: config, session: .shared)
    let repo = DefaultProductRepository(service: service)
    repo.fetchProductAll(pageNumber: 1, itemsPerPage: itemsPerPage) { [weak self] result in
      guard case let .success(products) = result else { return }
      self?.products = products
    }
  }
  
  private func paging() {
    let baseURL = "https://market-training.yagom-academy.kr"
    let config = DefaultNetworkConfiguration(baseURL: URL(string: baseURL)!)
    let service = DefaultNetworkService(configuration: config, session: .shared)
    let repo = DefaultProductRepository(service: service)
    repo.fetchProductAll(pageNumber: currentPageNumber, itemsPerPage: itemsPerPage) { [weak self] result in
      guard case let .success(products) = result else { return }
      self?.products.append(contentsOf: products)
    }
  }
  
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let height = scrollView.frame.height
    
    if offsetY > (contentHeight - height) {
      self.currentPageNumber += 1
      self.paging()
    }
  }
  
  @IBAction func addButtonDidTap(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "ProductRegister", bundle: .main)
    let viewController = storyboard.instantiateViewController(
      identifier: "ProductRegisterViewController")
    
    viewController.view.backgroundColor = .systemBackground
    viewController.modalPresentationStyle = .fullScreen
    self.present(viewController, animated: true)
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
