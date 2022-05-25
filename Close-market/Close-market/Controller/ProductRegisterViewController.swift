//
//  ProductRegisterViewController.swift
//  Close-market
//
//  Created by Lingo on 2022/05/26.
//

import UIKit

final class ProductRegisterViewController: UIViewController {
  @IBOutlet weak var uploadImageView: UIView!
  @IBOutlet weak var uploadImageCount: UILabel!
  @IBOutlet weak var uploadImageStackView: UIStackView!
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var priceTextField: UITextField!
  @IBOutlet weak var descriptionTextView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureUI()
  }
  
  @IBAction func cancelButtonDidTap(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true)
  }
  
  @IBAction func registerButtonDidTap(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true)
  }
  @IBAction func uploadImageViewDidTap(_ sender: UITapGestureRecognizer) {
    let picker = UIImagePickerController()
    picker.allowsEditing = true
    picker.sourceType = .photoLibrary
    picker.delegate = self
    self.present(picker, animated: true)
  }
}

// MARK: - UI

extension ProductRegisterViewController {
  private func configureUI() {
    self.uploadImageView.layer.borderWidth = 1.0
    self.uploadImageView.layer.borderColor = UIColor.systemGray5.cgColor
    self.uploadImageView.layer.cornerRadius = uploadImageView.frame.width * 0.1
  }
}

// MARK: - Delegate

extension ProductRegisterViewController: UIImagePickerControllerDelegate {
  func imagePickerController(
    _ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
  ) {
    if let image = info[.editedImage] as? UIImage {
      let resizedImage = resizeImage(image: image, height: uploadImageStackView.frame.height)
      let imageView = UIImageView(image: resizedImage)
      imageView.layer.cornerRadius = imageView.frame.width * 0.1
      imageView.layer.borderWidth = 1.0
      imageView.layer.borderColor = UIColor.systemGray5.cgColor
      imageView.clipsToBounds = true
      imageView.contentMode = .scaleToFill
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
      self.uploadImageStackView.addArrangedSubview(imageView)
      self.uploadImageCount.text = "\(self.uploadImageStackView.arrangedSubviews.count)/10"
    }
    self.dismiss(animated: true)
  }
  
  private func resizeImage(image: UIImage, height: CGFloat) -> UIImage? {
    let scale = height / image.size.height
    let width = image.size.width * scale
    UIGraphicsBeginImageContext(CGSize(width: width, height: height))
    image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
  }
}

extension ProductRegisterViewController: UINavigationControllerDelegate {}
