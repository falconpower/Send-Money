//
//  TextValidationState.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 30/01/25.
//
import Foundation


struct TextValidationState: State {
  var isValid: Bool?
  var actionType: ActionType? = .validate
  var cellModel: SendMoneyCellModel?
}
