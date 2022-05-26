//
//  HomeCollectionViewCell.swift
//  Close-market
//
//  Created by Lingo on 2022/05/24.
//

import UIKit

final class HomeCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var thumbnailImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  
  private var canceller: Cancellable?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.configureUI()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.canceller?.suspend()
    self.canceller?.cancel()
    self.thumbnailImageView.image = nil
    self.titleLabel.text = nil
    self.priceLabel.text = nil
  }
  
  func configure(with product: Product) {
    self.titleLabel.text = product.name
    self.priceLabel.text = product.price.toDecimal + (product.currency == .KRW ? "원" : "달러")
    self.canceller = thumbnailImageView.setImage(with: product.thumbnail)
  }
}

// MARK: - UI

extension HomeCollectionViewCell {
  private func configureUI() {
    self.thumbnailImageView.layer.borderWidth = 1.0
    self.thumbnailImageView.layer.borderColor = UIColor.systemGray5.cgColor
    self.thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.width * 0.1
  }
}
