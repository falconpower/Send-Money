//
//  ExportableSendMoneyModel.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 30/01/25.
//

struct ExportableSendMoneyModel: Codable {
  var requestId: SendMoneyCellModelObject?
  var service: SendMoneyCellModelObject?
  var provider: SendMoneyCellModelObject?
  var amount: SendMoneyCellModelObject?
  
  init(from models: [[SendMoneyCellModel]]) {
    for model in models.first ?? [] {
      switch model.identifier {
      case "requestId":
        self.requestId = SendMoneyCellModelObject(from: model)
      case "service":
        self.service = SendMoneyCellModelObject(from: model)
      case "provider":
        self.provider = SendMoneyCellModelObject(from: model)
      case "amount":
        self.amount = SendMoneyCellModelObject(from: model)
      default:
        break
      }
    }
  }
}

struct SendMoneyCellModelObject: Codable {
  var title: String?
  var placeHolder: String?
  var options: [String]?
  var selectedValue: String?
  var identifier: String?
  
  init(from model: SendMoneyCellModel) {
    self.title = model.title
    self.placeHolder = model.placeHolder
    self.options = model.options
    self.selectedValue = model.selectedValue
    self.identifier = model.identifier
  }
}
