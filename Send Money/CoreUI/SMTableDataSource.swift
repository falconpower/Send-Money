//
//  SMTableDataSource.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 29/01/25.
//

import Foundation
import UIKit

protocol SMTableViewConfigurable: AnyObject {
  associatedtype CellDataType: SMCellViewModel
  var screenTitle: String? { get set }
  var dataSource: [[CellDataType]]? { get set  }
}

class SMTableDataSource<CellDataType: SMCellViewModel>: NSObject, SMTableViewConfigurable, UITableViewDataSource {
  var screenTitle: String?
  var dataSource: [[CellDataType]]?
  
  init(dataSource: [[CellDataType]]) {
    self.dataSource = dataSource
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    dataSource?[section].count ?? 0
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    dataSource?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
    if let configItem = dataSource?[indexPath.section][indexPath.row] {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: configItem.cellProvider.cellType)) as? SMDynamicCell else {
        return UITableViewCell()
      }
      cell.configure(configItem)
      return cell
    }
    return UITableViewCell()
  }
}
