//
//  TextValidationReducer.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 30/01/25.
//

import Foundation

class TextValidationReducer {
  static let shared = TextValidationReducer()
  var store: Store?
  private init() {
    store = Store(reducer: textValidationReducer, state: nil)
  }
  func textValidationReducer(_ action: Action, _ state: State?) -> State {
    var newState = state as? TextValidationState ?? TextValidationState()
    guard let actionReceived = action as? TextValidationAction else { return newState }
    newState.isValid = actionReceived.isValid
    newState.actionType = actionReceived.actionType
    newState.cellModel = actionReceived.cellModel
    return newState
  }
}
