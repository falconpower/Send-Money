//
//  SMTableDelegate.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 29/01/25.
//

import Foundation
import UIKit

protocol SMTableDelegateActions: AnyObject {
  func didSelectionOfRow(_ indexPath: IndexPath)
}

class SMTableDelegate: NSObject, UITableViewDelegate {
  weak var delegate: SMTableDelegateActions?
  init(delegate: SMTableDelegateActions) {
    self.delegate = delegate
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.delegate?.didSelectionOfRow(indexPath)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}
