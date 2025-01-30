//
//  SpacerCell.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 30/01/25.
//

import UIKit

class SpacerCell: UITableViewCell, SMDynamicCell {
  var cellModel: SendMoneyCellModel?
  private var spacerView: UIView!
  
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
    updateHeight()
  }
  
  private func setupUI() {
    selectionStyle = .none
    spacerView = UIView()
    contentView.addSubview(spacerView)
    setupConstraints()
  }
  
  private func setupConstraints() {
    spacerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      spacerView.topAnchor.constraint(equalTo: contentView.topAnchor),
      spacerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      spacerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      spacerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
  
  private func updateHeight() {
    guard let height = cellModel?.height else { return }
    NSLayoutConstraint.activate([
      spacerView.heightAnchor.constraint(equalToConstant: height)
    ])
  }
}
