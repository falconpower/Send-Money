//
//  SendMoneyTextViewModel.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 29/01/25.
//

class SendMoneyCellModel: SMCellViewModel {
  typealias Cell = SendMoneyDropdownCell
  var validation: String?
  var maxLength: Int?
  var validationMessage: String?
  var title: String?
  var placeHolder: String?
  var cellProvider: CellProvider
  var cellUIType: SMCellType
  var identifier: String?
  var options: [String]?
  var selectedValue: String?
  init(cellUIType: SMCellType,
       cellProvider: CellProvider,
       identifier: String? = nil,
       title: String? = nil,
       placeHolder: String? = nil,
       options: [String]? = nil,
       selectedValue: String? = nil,
       validation: String? = nil,
       maxLength: Int? = nil,
       validationMessage: String? = nil) {
    self.cellUIType = cellUIType
    self.cellProvider = cellProvider
    self.identifier = identifier
    self.title = title
    self.placeHolder = placeHolder
    self.options = options
    self.selectedValue = selectedValue
    self.validation = validation
    self.maxLength = maxLength
    self.validationMessage = validationMessage
  }
}

