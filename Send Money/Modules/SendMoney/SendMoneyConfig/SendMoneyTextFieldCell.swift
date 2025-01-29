//
//  SendMoneyTextFieldCell.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 29/01/25.
//

import UIKit

import UIKit

class SendMoneyTextFieldCell: UITableViewCell, SMDynamicCell {
  
  var cellModel: SendMoneyCellModel?
  
  var titleLabel: UILabel!
  var textField: UITextField!
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    titleLabel = UILabel()
    textField = UITextField()
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    textField.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(titleLabel)
    contentView.addSubview(textField)
    
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.gray.cgColor
    textField.layer.cornerRadius = 6
    textField.clipsToBounds = true
    textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
    textField.leftViewMode = .always
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      
      textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      textField.heightAnchor.constraint(equalToConstant: 44),
      textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(_ dataType: (any SMCellViewModel)?) {
    guard let data = dataType as? SendMoneyCellModel else { return }
    titleLabel.text = data.title
    textField.placeholder = data.placeHolder
    switch data.cellUIType {
    case .numberText:
      textField.keyboardType = .numberPad
    default:
      textField.keyboardType = .default
    }
  }
}
