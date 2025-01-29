//
//  SendMoneyTextFieldCell.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 29/01/25.
//

import UIKit

class SendMoneyTextFieldCell: UITableViewCell, SMDynamicCell, UITextFieldDelegate {
  
  var cellModel: SendMoneyCellModel?
  
  var titleLabel: UILabel!
  var textField: UITextField!
  var errorLabel: UILabel!
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    titleLabel = UILabel()
    textField = UITextField()
    errorLabel = UILabel()
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    textField.translatesAutoresizingMaskIntoConstraints = false
    errorLabel.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(titleLabel)
    contentView.addSubview(textField)
    contentView.addSubview(errorLabel)
    
    errorLabel.textColor = .red
    errorLabel.font = UIFont.systemFont(ofSize: 12)
    errorLabel.isHidden = true
    
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.gray.cgColor
    textField.layer.cornerRadius = 6
    textField.clipsToBounds = true
    textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
    textField.leftViewMode = .always
    textField.delegate = self
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      
      textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      textField.heightAnchor.constraint(equalToConstant: 44),
      
      errorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4),
      errorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      errorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      errorLabel.heightAnchor.constraint(equalToConstant: 20),
      errorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(_ dataType: (any SMCellViewModel)?) {
    guard let data = dataType as? SendMoneyCellModel else { return }
    cellModel = data
    titleLabel.text = data.title
    textField.placeholder = data.placeHolder
    switch data.cellUIType {
    case .numberText:
      textField.keyboardType = .numberPad
    default:
      textField.keyboardType = .default
    }
    
    textField.text = data.selectedValue
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if let enteredText = textField.text {
      validateText(enteredText)
      cellModel?.selectedValue = enteredText
    }
  
  }
  
  private func validateText(_ text: String?) {
    errorLabel.isHidden = true
    
    if let maxLength = cellModel?.maxLength, let text = text {
      if text.count > maxLength {
        errorLabel.text = "Text exceeds maximum length of \(maxLength) characters."
        errorLabel.isHidden = false
        return
      }
    }
    
    if let validationRegex = cellModel?.validation, let text = text {
      let regex = try? NSRegularExpression(pattern: validationRegex)
      let range = NSRange(location: 0, length: text.utf16.count)
      if regex?.firstMatch(in: text, options: [], range: range) == nil {
        errorLabel.text = cellModel?.validationMessage ?? "Invalid input format."
        errorLabel.isHidden = false
        return
      }
    }
    
    errorLabel.isHidden = true
  }
}
