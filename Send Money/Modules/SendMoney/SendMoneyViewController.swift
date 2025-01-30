//
//  SendMoneyViewController.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 29/01/25.
//

import UIKit

class SendMoneyViewController: SMTableViewController<SendMoneyCellModel> {
  var sendMoneyViewModel: SendMoneyViewModel? {
    return viewModel as? SendMoneyViewModel
  }
  private let pickerView = UIPickerView()
  private var selectedIndexPath: IndexPath?
  private let pickerContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    return view
  }()
  
  init(viewModel: SendMoneyViewModel) {
    super.init(viewModel: viewModel)
    setupPickerView()
    self.title = "Send Money Details"
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func didSelectionOfRow(_ indexPath: IndexPath) {
    guard let selectedCellModel = sendMoneyViewModel?.cellModels[indexPath.row] else { return }
    if (selectedCellModel.cellUIType != .freeText) &&
        (selectedCellModel.cellUIType != .numberText) {
      selectedIndexPath = indexPath
      
      showPicker(for: selectedCellModel)
    }
  }
  
  private func setupPickerView() {
    pickerView.delegate = self
    pickerView.dataSource = self
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePickerSelection))
    toolbar.setItems([flexSpace, doneButton], animated: false)
    pickerContainerView.addSubview(toolbar)
    pickerContainerView.addSubview(pickerView)
    toolbar.translatesAutoresizingMaskIntoConstraints = false
    pickerView.translatesAutoresizingMaskIntoConstraints = false
    pickerContainerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      toolbar.topAnchor.constraint(equalTo: pickerContainerView.topAnchor),
      toolbar.leadingAnchor.constraint(equalTo: pickerContainerView.leadingAnchor),
      toolbar.trailingAnchor.constraint(equalTo: pickerContainerView.trailingAnchor),
      toolbar.heightAnchor.constraint(equalToConstant: 44),
      pickerView.topAnchor.constraint(equalTo: toolbar.bottomAnchor),
      pickerView.leadingAnchor.constraint(equalTo: pickerContainerView.leadingAnchor),
      pickerView.trailingAnchor.constraint(equalTo: pickerContainerView.trailingAnchor),
      pickerView.bottomAnchor.constraint(equalTo: pickerContainerView.bottomAnchor),
      pickerContainerView.heightAnchor.constraint(equalToConstant: 250)
    ])
  }
  
  private func showPicker(for cellModel: SendMoneyCellModel) {
    pickerView.reloadAllComponents()
    if pickerContainerView.superview == nil {
      view.addSubview(pickerContainerView)
      NSLayoutConstraint.activate([
        pickerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        pickerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        pickerContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
      ])
    }
  }
  
  @objc private func donePickerSelection() {
    guard let indexPath = selectedIndexPath else { return }
    let selectedRow = pickerView.selectedRow(inComponent: 0)
    guard let selectedCellModel = sendMoneyViewModel?.cellModels[indexPath.row],
          let selectedOption = selectedCellModel.options?[selectedRow] else {
      return
    }
    if selectedCellModel.identifier == SendMoneyViewModel.SendMoneyPickerType.service.rawValue {
      sendMoneyViewModel?.selectService(selectedOption)
    } else if selectedCellModel.identifier == SendMoneyViewModel.SendMoneyPickerType.provider.rawValue {
      sendMoneyViewModel?.selectProvider(selectedOption)
    }
    selectedCellModel.selectedValue = selectedOption
    refreshAndReload()
    pickerContainerView.removeFromSuperview()
    TextValidationReducer.shared.store?.dispatch(action: TextValidationAction(isValid: true, actionType: .validate, cellModel: selectedCellModel))
  }
  
  @objc override func didTapStickyButton() {
    print("Sticky button tapped", sendMoneyViewModel?.cellDataSource)
    sendMoneyViewModel?.saveDetails()
    self.navigationController?.popViewController(animated: true)
  }
}

extension SendMoneyViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      guard let indexPath = selectedIndexPath,
            let selectedCellModel = sendMoneyViewModel?.cellModels[indexPath.row] else {
          return 0
      }
      
      return selectedCellModel.options?.count ?? 0
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      guard let indexPath = selectedIndexPath,
            let selectedCellModel = sendMoneyViewModel?.cellModels[indexPath.row] else {
          return nil
      }
      
      return selectedCellModel.options?[row]
  }
}
