//
//  SendMoneyViewModel.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 29/01/25.
//

import UIKit

class SendMoneyDropdownCell: UITableViewCell, SMDynamicCell {
  var cellModel: SendMoneyCellModel?
  private var titleLabel: UILabel!
  private var textField: UITextField!
  private var arrowImageView: UIImageView!
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupUI()
  }
  
  func configure(_ dataType: (any SMCellViewModel)?) {
    guard let dataType = dataType as? SendMoneyCellModel else { return }
    cellModel = dataType
    titleLabel.text = dataType.title?.localized
    if let selectedValue = dataType.selectedValue {
      textField.text = selectedValue
    } else {
      textField.text = "choose".localized
    }
    let isRTL = LanguageManager.shared.currentLanguage.hasPrefix("ar")
    titleLabel.textAlignment = isRTL ? .right : .left
    textField.textAlignment = isRTL ? .right : .left
    contentView.semanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
  }
  
  private func setupUI() {
    selectionStyle = .none
    titleLabel = UILabel()
    titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
    titleLabel.textColor = .black
    contentView.addSubview(titleLabel)
    textField = UITextField()
    textField.font = UIFont.systemFont(ofSize: 14)
    textField.textColor = .black
    textField.isEnabled = false
    textField.textAlignment = .left
    textField.borderStyle = .roundedRect
    contentView.addSubview(textField)
    arrowImageView = UIImageView(image: UIImage(systemName: "chevron.down"))
    arrowImageView.tintColor = .gray
    textField.rightView = arrowImageView
    textField.rightViewMode = .always
    setupConstraints()
  }
  
  private func setupConstraints() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    textField.translatesAutoresizingMaskIntoConstraints = false
    arrowImageView.translatesAutoresizingMaskIntoConstraints = false
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.gray.cgColor
    textField.layer.cornerRadius = 6
    textField.clipsToBounds = true
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
      textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
      textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
      textField.heightAnchor.constraint(equalToConstant: 40),
      textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
    ])
  }
}
