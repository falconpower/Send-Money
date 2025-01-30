//
//  SendMoneyCell.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 30/01/25.
//

import UIKit

class SendMoneyCell: UITableViewCell {
  
  private let requestIdLabel = UILabel()
  private let serviceNameLabel = UILabel()
  private let providerNameLabel = UILabel()
  private let amountLabel = UILabel()
  
  private let stackView = UIStackView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupUI()
  }
  
  private func setupUI() {
    selectionStyle = .none
    requestIdLabel.font = UIFont.boldSystemFont(ofSize: 16)
    serviceNameLabel.font = UIFont.systemFont(ofSize: 14)
    providerNameLabel.font = UIFont.systemFont(ofSize: 14)
    amountLabel.font = UIFont.systemFont(ofSize: 14)
    
    [requestIdLabel, serviceNameLabel, providerNameLabel, amountLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.numberOfLines = 1
      $0.textColor = .black
    }
    
    // Configure stackView
    stackView.axis = .vertical
    stackView.spacing = 8
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.addArrangedSubview(requestIdLabel)
    stackView.addArrangedSubview(serviceNameLabel)
    stackView.addArrangedSubview(providerNameLabel)
    stackView.addArrangedSubview(amountLabel)
    contentView.addSubview(stackView)
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
    ])
  }
  
  func configure(with models: [SendMoneyCellModel]?) {
    for model in models ?? []{
      switch model.identifier {
      case "requestId":
        requestIdLabel.text = "Request ID: \(model.selectedValue ?? "")"
      case "service":
        serviceNameLabel.text = "Service Name: \(model.selectedValue ?? "")"
      case "provider":
        providerNameLabel.text = "Provider Name: \(model.selectedValue ?? "")"
      case "amount":
        amountLabel.text = "Amount: \(model.selectedValue ?? "")"
      default:
        break
      }
    }
  }
}
