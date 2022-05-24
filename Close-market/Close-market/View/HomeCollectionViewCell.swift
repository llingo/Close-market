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
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.configureUI()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.thumbnailImageView.image = nil
    self.titleLabel.text = nil
    self.priceLabel.text = nil
  }
  
  func configure() {
    self.titleLabel.text = "아이패드 Pro"
    self.priceLabel.text = "399,000원"
    self.thumbnailImageView.image = UIImage(named: "ActivityIndicator")
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
