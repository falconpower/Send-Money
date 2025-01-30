//
//  ButtonCell.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 30/01/25.
//

import UIKit

class ButtonCell: UITableViewCell, SMDynamicCell {
  var cellModel: SendMoneyCellModel?
  private var actionButton: UIButton!

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
    actionButton.setTitle(cellModel?.title, for: .normal)
  }

  private func setupUI() {
    selectionStyle = .none
    actionButton = UIButton(type: .system)
    actionButton.setTitle("", for: .normal)
    actionButton.setTitleColor(.white, for: .normal)
    actionButton.backgroundColor = .systemBlue
    actionButton.layer.cornerRadius = 8
    actionButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    contentView.addSubview(actionButton)
    setupConstraints()
  }
  
  @objc private func didTapButton() {
    cellModel?.buttonAction?()
  }

  private func setupConstraints() {
    actionButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      actionButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      actionButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      actionButton.widthAnchor.constraint(equalToConstant: 150),
      actionButton.heightAnchor.constraint(equalToConstant: 44),
      actionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
    ])
  }
}
