//
//  ProductRegisterViewController.swift
//  Close-market
//
//  Created by Lingo on 2022/05/26.
//

import UIKit

final class ProductRegisterViewController: UIViewController {
  private enum Const {
    enum Message {
      static let textViewPlaceholder = "강남구에 올릴 게시글 내용을 작성해주세요. (가품 및 판매금지 품목은 게시가 제한될 수 있어요.)"
      static let imageUploadAlertMessage = "이미지는 최대 %d까지 첨부할 수 있어요"
      static let alertNoticeMessage = "알림"
      static let alertCloseMessage = "닫기"
    }
    enum Limit {
      static let textViewMaximumLength = 1000
      static let imageUploadMaximumCount = 1
    }
  }
  
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
    if uploadImageStackView.arrangedSubviews.count == Const.Limit.imageUploadMaximumCount {
      let message = String(
        format: Const.Message.imageUploadAlertMessage,
        Const.Limit.imageUploadMaximumCount)
      let alert = UIAlertController(
        title: Const.Message.alertNoticeMessage,
        message: message,
        preferredStyle: .alert)
      let cancel = UIAlertAction(title: Const.Message.alertCloseMessage, style: .cancel)
      alert.addAction(cancel)
      self.present(alert, animated: true)
    } else {
      let picker = UIImagePickerController()
      picker.allowsEditing = true
      picker.sourceType = .photoLibrary
      picker.delegate = self
      self.present(picker, animated: true)
    }
  }
}

// MARK: - UI

extension ProductRegisterViewController {
  private func configureUI() {
    self.descriptionTextView.text = Const.Message.textViewPlaceholder
    self.uploadImageCount.text = "0/\(Const.Limit.imageUploadMaximumCount)"
    self.uploadImageView.layer.borderWidth = 1.0
    self.uploadImageView.layer.borderColor = UIColor.systemGray5.cgColor
    self.uploadImageView.layer.cornerRadius = uploadImageView.frame.width * 0.1
  }
}

// MARK: - UIImagePickerController Delegate

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
      let count = self.uploadImageStackView.arrangedSubviews.count
      self.uploadImageCount.text = "\(count)/\(Const.Limit.imageUploadMaximumCount)"
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

// MARK: - UITextView Delegate

extension ProductRegisterViewController: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.text == Const.Message.textViewPlaceholder {
      textView.text = nil
      textView.textColor = .label
    } else if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
      textView.textColor = .placeholderText
      textView.text = Const.Message.textViewPlaceholder
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
      textView.textColor = .placeholderText
      textView.text = Const.Message.textViewPlaceholder
    }
  }
  
  func textViewDidChange(_ textView: UITextView) {
    if textView.text.count > Const.Limit.textViewMaximumLength {
      textView.deleteBackward()
    }
  }
}
