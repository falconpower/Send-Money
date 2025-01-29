//
//  TextValidationAction.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 30/01/25.
//

import UIKit
enum ActionType {
  case validate
}
struct TextValidationAction: Action {
  var isValid: Bool?
  var actionType: ActionType
  var cellModel: SendMoneyCellModel?
}
