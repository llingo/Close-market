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
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
    return 1
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
    
    cell.configure()
    return cell
  }
}
