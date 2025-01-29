import UIKit
import UIKit

class SendMoneyViewController: SMTableViewController<SendMoneyCellModel> {
  
  var sendMoneyViewModel: SendMoneyViewModel? {
    return viewModel as? SendMoneyViewModel
  }
  
  private let pickerView = UIPickerView()
  private var selectedIndexPath: IndexPath?
  private var isServicePicker = true // Flag to distinguish between service and provider picker
  private let pickerContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    return view
  }()
  
  init(viewModel: SendMoneyViewModel) {
    super.init(viewModel: viewModel)
    setupPickerView()
  }
  
  @MainActor required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func registerCells() {
    listTableView.register(SendMoneyDropdownCell.self, forCellReuseIdentifier: String(describing: SendMoneyDropdownCell.self))
    listTableView.register(SendMoneyTextFieldCell.self, forCellReuseIdentifier: String(describing: SendMoneyTextFieldCell.self))
  }
  
  override func didSelectionOfRow(_ indexPath: IndexPath) {
    guard let selectedCellModel = sendMoneyViewModel?.cellModels[indexPath.row] else { return }
        selectedIndexPath = indexPath

        showPicker(for: selectedCellModel)
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
    if selectedCellModel.identifier == "service" {
      sendMoneyViewModel?.selectService(selectedOption)
    } else if selectedCellModel.identifier == "provider" {
      sendMoneyViewModel?.selectProvider(selectedOption)
    }
    selectedCellModel.selectedValue = selectedOption
    refreshAndReload()
    pickerContainerView.removeFromSuperview()
  }
  
  @objc override func didTapStickyButton() {
    print("Sticky button tapped", sendMoneyViewModel?.cellDataSource)
    // Handle button tap action
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
