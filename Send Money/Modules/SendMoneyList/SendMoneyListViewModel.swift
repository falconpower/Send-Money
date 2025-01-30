//
//  SendMoneyListViewModel.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 30/01/25.
//

import Foundation
import Combine

class SendMoneyListViewModel {
  var data: [[[SendMoneyCellModel]]] {
    LocalStorage.cellDataSource
  }
}
