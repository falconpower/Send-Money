//
//  SendMoneyViewModel.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 29/01/25.
//

import Foundation

class SendMoneyViewModel: SMTableViewModel<SendMoneyCellModel> {
  enum SendMoneyPickerType: String {
    case service
    case provider
    case gender
  }
  private var services: [Services] = []
  private var selectedService: Services?
  private var selectedProvider: Providers?
  private var selectedGender: String?
  var cellModels:[SendMoneyCellModel] = []
  var serviceOptions: [String] {
    services.map { $0.localizedLabel }
  }
  
  var providerOptions: [String] {
    selectedService?.providers?.map({ $0.name ?? "" }) ?? []
  }
  
  var genderOptions: [String] {
    selectedProvider?.requiredFields?
      .first(where: { $0.type == "gender" })?
      .options?.compactMap { $0.label } ?? []
  }

  
  var requiredFields: [RequiredFields] {
    selectedProvider?.requiredFields ?? []
  }
  
  override init() {
    super.init()
    fetchData()
  }
  
  func fetchData() {
    do {
      if let path = Bundle.main.path(forResource: "sendmoney", ofType: "json"),
         let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
        let decoder = JSONDecoder()
        let response = try decoder.decode(SendMoney.self, from: data)
        self.services = response.services ?? []
        updateCellModels()
      }
    } catch {
      // Handle error
      print("Error loading or decoding JSON: \(error.localizedDescription)")
    }
  }
  
  
  func selectService(_ serviceName: String) {
    selectedService = services.first { service in
      service.localizedLabel == serviceName || service.name == serviceName
    }
    if let serviceCell = cellModels.first(where: { $0.identifier == SendMoneyPickerType.service.rawValue }) {
      serviceCell.selectedValue = serviceName
    }
    selectedProvider = nil
    updateCellModels()
  }
  
  func selectProvider(_ providerName: String) {
    selectedProvider = selectedService?.providers?.first { $0.name == providerName }
    if let providerCell = cellModels.first(where: { $0.identifier == SendMoneyPickerType.provider.rawValue }) {
      providerCell.selectedValue = providerName
    }
    updateCellModels()
  }
  
  
  private func createServiceTypeDropdownCell() -> SendMoneyCellModel {
    let cellModel = SendMoneyCellModel(
      cellUIType: .option,
      cellProvider: CellProvider(cellType: SendMoneyDropdownCell.self),
      identifier: SendMoneyPickerType.service.rawValue,
      title: "service".localized,   
      placeHolder: "choose".localized,
      options: serviceOptions,
      selectedValue: selectedService?.localizedLabel
    )
    return cellModel
  }
  
  private func createProviderTypeDropdownCell() -> SendMoneyCellModel? {
    guard let providerOptions = selectedService?.providers else { return nil }
    let cellModel = SendMoneyCellModel(
      cellUIType: .option,
      cellProvider: CellProvider(cellType: SendMoneyDropdownCell.self),
      identifier: SendMoneyPickerType.provider.rawValue,
      title: "provider".localized,
      placeHolder: "choose".localized,
      options: providerOptions.map { $0.name ?? "" },
      selectedValue: selectedProvider?.name
    )
    return cellModel
  }
  
  private func updateCellModels() {
    cellModels.removeAll()
    let dropdownCellModel = createServiceTypeDropdownCell()
    cellModels.append(dropdownCellModel)
    if let providerCellModel = createProviderTypeDropdownCell() {
      cellModels.append(providerCellModel)
    }
    for field in selectedProvider?.requiredFields ?? [] {
      guard let type = field.type, let cellType = SMCellType(rawValue: type) else { continue }
      let cellModel = SendMoneyCellModel(
        cellUIType: cellType,
        cellProvider: cellType == .option ?  CellProvider(cellType: SendMoneyDropdownCell.self) : CellProvider(cellType: SendMoneyTextFieldCell.self),
        identifier: field.name,
        title: field.label?.localized,
        placeHolder: field.placeholder,
        options: field.options?.map({$0.label ?? ""}),
        validation: field.validation,
        maxLength: field.maxLength,
        validationMessage: field.validationErrorMessage
      )
      cellModels.append(cellModel)
    }
    cellDataSource = [cellModels]
  }
  
  func saveDetails() {
    if let cellDataSource {
      LocalStorage.cellDataSource.append(cellDataSource)
    }
  }
}
