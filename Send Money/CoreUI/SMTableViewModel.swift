//
//  SMTableViewModel.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 29/01/25.
//

import UIKit
 
class SMTableViewModel<CellDataType: SMCellViewModel>: NSObject {
  var cellDataSource: [[CellDataType]]?
  override init() {
    super.init()
    cellDataSource = [[]]
  }
}
