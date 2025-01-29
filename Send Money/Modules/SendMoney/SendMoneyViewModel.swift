//
//  SendMoneyViewModel.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 29/01/25.
//

import Foundation

class SendMoneyViewModel: SMTableViewModel<SendMoneyCellModel> {
  
  private var services: [Services] = []
  private var selectedService: Services?
  private var selectedProvider: Providers?
  var cellModels:[SendMoneyCellModel] = []
  var serviceOptions: [String] {
    services.map { $0.label?.en ?? "" }
  }
  
  var providerOptions: [String] {
    selectedService?.providers?.map({ $0.name ?? "" }) ?? []
  }
  
  var requiredFields: [RequiredFields] {
    selectedProvider?.requiredFields ?? []
  }
  
  override init() {
    super.init()
    fetchData()
  }
  
  private func fetchData() {
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
      service.label?.en == serviceName || service.name == serviceName
    }
    selectedProvider = nil
    updateCellModels()
  }
  
  func selectProvider(_ providerName: String) {
    selectedProvider = selectedService?.providers?.first { $0.name == providerName }
    updateCellModels()
  }
  
  private func createServiceTypeDropdownCell() -> SendMoneyCellModel {
    let cellModel = SendMoneyCellModel(
      cellUIType: .option,
      cellProvider: CellProvider(cellType: SendMoneyDropdownCell.self),
      identifier: "serviceType",  // Field name
      title: "Service",    // Title for the dropdown
      placeHolder: "Choose",
      options: serviceOptions,
      selectedValue: selectedService?.label?.en
    )
    return cellModel
  }
  
  private func createProviderTypeDropdownCell() -> SendMoneyCellModel? {
    guard let providerOptions = selectedService?.providers else { return nil }
    let cellModel = SendMoneyCellModel(
      cellUIType: .option,
      cellProvider: CellProvider(cellType: SendMoneyDropdownCell.self),
      identifier: "providerType",
      title: "Provider",
      placeHolder: "Choose",
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
        cellProvider: CellProvider(cellType: SendMoneyTextFieldCell.self),
        identifier: field.name,
        title: field.label?.en,
        placeHolder: field.placeholder
      )
      cellModels.append(cellModel)
    }
    cellDataSource = [cellModels]
  }
}
