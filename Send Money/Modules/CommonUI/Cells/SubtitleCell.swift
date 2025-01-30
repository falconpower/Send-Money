//
//  SubtitleCell.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 30/01/25.
//
import UIKit

class SubtitleCell: UITableViewCell, SMDynamicCell {
  var cellModel: SendMoneyCellModel?
  private var titleLabel: UILabel!
  
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
    titleLabel.text = cellModel?.title
  }
  
  private func setupUI() {
    selectionStyle = .none
    titleLabel = UILabel()
    titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
    titleLabel.textColor = .gray
    titleLabel.numberOfLines = 0
    titleLabel.textAlignment = .center
    contentView.addSubview(titleLabel)
    setupConstraints()
  }
  
  private func setupConstraints() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
    ])
  }
}
