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
  
  @IBOutlet private weak var uploadImageView: UIView!
  @IBOutlet private weak var uploadImageCount: UILabel!
  @IBOutlet private weak var uploadImageStackView: UIStackView!
  @IBOutlet private weak var titleTextField: UITextField!
  @IBOutlet private weak var priceTextField: UITextField!
  @IBOutlet private weak var descriptionTextView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureUI()
    self.configureKeyboardToolBar()
  }
  
  @IBAction private func cancelButtonDidTap(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true)
  }
  
  @IBAction private func registerButtonDidTap(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true)
  }
}

// MARK: - Functions

extension ProductRegisterViewController {

  // MARK: 이미지 업로드 관련 메서드
  @IBAction private func uploadImageViewDidTap(_ sender: UITapGestureRecognizer) {
    let imageCount = uploadImageStackView.arrangedSubviews.count
    if imageCount == Const.Limit.imageUploadMaximumCount {
      self.presentAlert()
    } else {
      self.presentImagePicker()
    }
  }
  
  private func presentAlert() {
    let message = String(
      format: Const.Message.imageUploadAlertMessage,
      Const.Limit.imageUploadMaximumCount
    )
    let alert = UIAlertController(
      title: Const.Message.alertNoticeMessage,
      message: message,
      preferredStyle: .alert
    )
    let cancel = UIAlertAction(
      title: Const.Message.alertCloseMessage,
      style: .cancel
    )
    alert.addAction(cancel)
    self.present(alert, animated: true)
  }
  
  private func presentImagePicker() {
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.allowsEditing = true
    picker.sourceType = .photoLibrary
    self.present(picker, animated: true)
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
  
  private func configureKeyboardToolBar() {
    let toolBar = UIToolbar()
    let image = UIImage(systemName: "keyboard.chevron.compact.down")
    let keyboard = UIBarButtonItem(
      image: image,
      style: .plain,
      target: self,
      action: #selector(keyBoardBarButtonDidTap)
    )
    keyboard.tintColor = .label
    let flexible = UIBarButtonItem(
      barButtonSystemItem: .flexibleSpace,
      target: nil,
      action: nil
    )
    toolBar.sizeToFit()
    toolBar.setItems([flexible, keyboard], animated: false)
    self.descriptionTextView.inputAccessoryView = toolBar
  }
  
  @objc private func keyBoardBarButtonDidTap() {
    self.view.endEditing(true)
  }
}

// MARK: - Delegates

// MARK: UIImagePickerController Delegate

extension ProductRegisterViewController: UINavigationControllerDelegate {}
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

// MARK: UITextView Delegate

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
