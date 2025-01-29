//
//  SMTableViewController.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 29/01/25.
//

import UIKit

class SMTableViewController<CellDataType: SMCellViewModel>: UIViewController, SMTableDelegateActions  {
  var viewModel: SMTableViewModel<CellDataType>
  lazy var listTableView: UITableView = {
    let table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    table.separatorStyle = .none
    return table
  }()
  var listDataSource: SMTableDataSource<CellDataType>?
  var listDelegate: SMTableDelegate?
  
  init(viewModel: SMTableViewModel<CellDataType>) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    addTableView()
    configureTable()
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
  // Implemented in child classes
  func registerCells() {
    
  }
  private func addTableView() {
    self.view.addSubview(listTableView)
    listTableView.translatesAutoresizingMaskIntoConstraints = false
    listTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: .zero).isActive = true
    listTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: .zero).isActive = true
    listTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: .zero).isActive = true
    listTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: .zero).isActive = true
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
}

