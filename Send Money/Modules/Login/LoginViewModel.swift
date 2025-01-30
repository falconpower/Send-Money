//
//  LoginViewModel.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 30/01/25.
//
import Foundation
import Combine

class LoginViewModel: SMTableViewModel<SendMoneyCellModel> {
  private var enteredUsername: String?
  private var enteredPassword: String?
  var loginStatusPublisher = PassthroughSubject<Bool, Never>()
  override init() {
    super.init()
    setupCellModels()
  }
  
  func setupCellModels() {
    let spacer = SendMoneyCellModel(
      cellUIType: .spacer,
      cellProvider: CellProvider(cellType: SpacerCell.self),
      height: 60
    )
    
    let titleModel = SendMoneyCellModel(
      cellUIType: .title,
      cellProvider: CellProvider(cellType: TitleCell.self),
      identifier: "title",
      title: "sendMoneyApp".localized,
      placeHolder: "",
      validation: "",
      maxLength: 40,
      validationMessage: "Please enter valid email"
    )
    
    let spacer2 = SendMoneyCellModel(
      cellUIType: .spacer,
      cellProvider: CellProvider(cellType: SpacerCell.self),
      height: 30
    )
    
    let subTitleModel =  SendMoneyCellModel(
      cellUIType: .title,
      cellProvider: CellProvider(cellType: SubtitleCell.self),
      identifier: "subtitle",
      title: "welcomToSendMoneyApp".localized,
      placeHolder: "",
      validation: "",
      maxLength: 40,
      validationMessage: "Please enter valid email"
    )
    
    let spacer3 = SendMoneyCellModel(
      cellUIType: .spacer,
      cellProvider: CellProvider(cellType: SpacerCell.self),
      height: 30
    )
    
    let usernameModel =  SendMoneyCellModel(
      cellUIType: .freeText,
      cellProvider: CellProvider(cellType: SendMoneyTextFieldCell.self),
      identifier: "email",
      title: "email".localized,
      placeHolder: "email".localized,
      validation: "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$",
      maxLength: 40,
      validationMessage: "Please enter valid email") { [weak self ]capturedValue in
        self?.enteredUsername = capturedValue
        print(capturedValue)
      }
    
    let password =  SendMoneyCellModel(
      cellUIType: .password,
      cellProvider: CellProvider(cellType: SendMoneyTextFieldCell.self),
      identifier: "password",
      title: "password".localized,
      placeHolder: "password".localized,
      validation: ".*",
      maxLength: 40,
      validationMessage: "") { [weak self] capturedValue in
        self?.enteredPassword = capturedValue
      }
    
    let spacer4 = SendMoneyCellModel(
      cellUIType: .spacer,
      cellProvider: CellProvider(cellType: SpacerCell.self),
      height: 30
    )
    
    let loginButton =  SendMoneyCellModel(
      cellUIType: .primaryButton,
      cellProvider: CellProvider(cellType: ButtonCell.self),
      identifier: "login",
      title: "signIn".localized,
      placeHolder: "",
      validation: ".*" ,
      maxLength: 40,
      validationMessage: "",
      buttonAction: { [weak self] in
        print("Tapped", self?.cellDataSource)
        self?.handleLogin()
      }
    )
    
    cellDataSource = [[spacer, titleModel, spacer2, subTitleModel, spacer3, usernameModel, password, spacer4,
                       loginButton]]
  }
  
  private func handleLogin() {
    guard let username = enteredUsername, let password = enteredPassword else {
      loginStatusPublisher.send(false)
      return
    }
    let validUsername = "Test@test.com"
    let validPassword = "123"
    if username == validUsername && password == validPassword {
      loginStatusPublisher.send(true)
    } else {
      loginStatusPublisher.send(false)
    }
  }
}
