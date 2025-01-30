//
//  SMTableViewController.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 29/01/25.
//

import UIKit

class SMTableViewController<CellDataType: SMCellViewModel>: UIViewController, SMTableDelegateActions {
  
  var viewModel: SMTableViewModel<CellDataType>
  var primaryButton: String {
    "Save"
  }
  lazy var listTableView: UITableView = {
    let table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    table.separatorStyle = .none
    return table
  }()
  
  var listDataSource: SMTableDataSource<CellDataType>?
  var listDelegate: SMTableDelegate?
  
  // Sticky button at the bottom
  lazy var stickyButton: UIButton = {
    let button = UIButton(type: .system)
    button.isEnabled = false
    button.setTitle(primaryButton, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .systemBlue
    button.layer.cornerRadius = 8
    button.alpha = 0.5
    button.addTarget(self, action: #selector(didTapStickyButton), for: .touchUpInside)
    return button
  }()
  
  init(viewModel: SMTableViewModel<CellDataType>) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    addStickyButton()
    addTableView()
    configureTable()
    configureRedux()
  }
  private func configureRedux() {
    TextValidationReducer.shared.store?.subscribe(self)
    }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureTable() {
    listDataSource = SMTableDataSource<CellDataType>(dataSource: viewModel.cellDataSource ?? [[]])
    registerCells()
    listTableView.rowHeight = UITableView.automaticDimension
    listDelegate = SMTableDelegate(delegate: self)
    listTableView.dataSource = listDataSource
    listTableView.delegate = listDelegate
    listTableView.tableFooterView = UIView()
    listTableView.backgroundColor = UIColor.white
  }
  
  func registerCells() {
    listTableView.register(SendMoneyDropdownCell.self, forCellReuseIdentifier: String(describing: SendMoneyDropdownCell.self))
    listTableView.register(SendMoneyTextFieldCell.self, forCellReuseIdentifier: String(describing: SendMoneyTextFieldCell.self))
    listTableView.register(ButtonCell.self, forCellReuseIdentifier: String(describing: ButtonCell.self))
    listTableView.register(SpacerCell.self, forCellReuseIdentifier: String(describing: SpacerCell.self))
    listTableView.register(SubtitleCell.self, forCellReuseIdentifier: String(describing: SubtitleCell.self))
    listTableView.register(TitleCell.self, forCellReuseIdentifier: String(describing: TitleCell.self))
  }
  
  private func addTableView() {
    self.view.backgroundColor = .white
    self.view.addSubview(listTableView)
    listTableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      listTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      listTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      listTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
      listTableView.bottomAnchor.constraint(equalTo: stickyButton.topAnchor)
    ])
  }
  
  private func addStickyButton() {
    self.view.addSubview(stickyButton)
    NSLayoutConstraint.activate([
      stickyButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
      stickyButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
      stickyButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
      stickyButton.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
  
  @objc func didTapStickyButton() {
    print("Sticky button tapped")
  }
  
  func refreshAndReload() {
    listDataSource?.dataSource = viewModel.cellDataSource ?? [[]]
    reload()
  }
  
  func reload() {
    listTableView.reloadData()
  }
  
  func didSelectionOfRow(_ indexPath: IndexPath) {
    print("Didselect called")
  }
  
  private var keyboardHeight: CGFloat = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  deinit {
    TextValidationReducer.shared.store?.removeSubscriber(self)
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc func keyboardWillShow(notification: NSNotification) {
    if let userInfo = notification.userInfo,
       let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
      keyboardHeight = keyboardFrame.height
      adjustTableViewForKeyboard()
    }
  }
  
  @objc func keyboardWillHide(notification: NSNotification) {
    keyboardHeight = 0
    adjustTableViewForKeyboard()
  }
  
  private func adjustTableViewForKeyboard() {
    let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
    listTableView.contentInset = contentInset
    listTableView.scrollIndicatorInsets = contentInset
  }
}

extension SMTableViewController: StoreSubscriber {
  func newState(state: State) {
    print("validation", state)
    checkFieldsAndUpdateButton()
  }
  
  func checkFieldsAndUpdateButton() {
    var isValid = false
    for data in viewModel.cellDataSource?.flatMap({ $0 }) ?? [] {
      if let sendMoneyModel = data as? SendMoneyCellModel {
        if sendMoneyModel.identifier != SendMoneyViewModel.SendMoneyPickerType.service.rawValue && sendMoneyModel.identifier != SendMoneyViewModel.SendMoneyPickerType.provider.rawValue {
          if sendMoneyModel.selectedValue?.isEmpty ?? true {
            isValid = false
            break
          } else {
            isValid = true
          }
        }
      }
    }
    stickyButton.isEnabled = isValid
    stickyButton.alpha = isValid ? 1.0 : 0.5
  }
}
