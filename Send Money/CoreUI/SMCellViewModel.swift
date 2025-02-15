//
//  SMCellViewModel.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 29/01/25.
//

import Foundation
import UIKit
enum SMCellType: String, Codable {
  case title
  case subTitle
  case option = "option"
  case numberText = "number"
  case freeText = "text"
  case password
  case spacer
  case primaryButton
  case disclaimerText
  case displayCard
}
struct CellProvider {
  var cellType: UITableViewCell.Type
}
protocol SMCellViewModel {
  var cellProvider: CellProvider { get set }
  var cellUIType: SMCellType { get set }
  var identifier: String? { get set }
  var title: String? { get set }
  var placeHolder: String?  { get set }
  var options: [String]?  { get set }
  var selectedValue: String?  { get set }
  var validation: String?  { get set }
  var maxLength: Int?  { get set }
  var validationMessage: String?  { get set }
  var height: CGFloat? { get set }
}
