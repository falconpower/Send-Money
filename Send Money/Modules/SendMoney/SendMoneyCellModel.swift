//
//  SendMoneyTextViewModel.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 29/01/25.
//
import UIKit

class SendMoneyCellModel: SMCellViewModel {
  var height: CGFloat?
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
  var buttonAction: (() -> Void)?
  var capturedString: ((String) -> Void)?
  init(cellUIType: SMCellType,
       cellProvider: CellProvider,
       identifier: String? = nil,
       title: String? = nil,
       placeHolder: String? = nil,
       options: [String]? = nil,
       selectedValue: String? = nil,
       validation: String? = nil,
       maxLength: Int? = nil,
       validationMessage: String? = nil,
       height: CGFloat? = nil,
       buttonAction: (() -> Void)? = nil,
       capturedString: ((String) -> Void)? = nil
  ) {
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
    self.height = height
    self.buttonAction = buttonAction
    self.capturedString = capturedString
  }
}

