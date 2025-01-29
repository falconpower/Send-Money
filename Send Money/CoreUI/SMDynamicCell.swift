//
//  SMDynamicCell.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 29/01/25.
//

import UIKit
protocol SMDynamicCell where Self: UITableViewCell {
  func configure(_ dataType: SMCellViewModel?)
}
