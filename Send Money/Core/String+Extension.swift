//
//  String+Extension.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 30/01/25.
//
import Foundation
extension String {
  var localized: String {
    Bundle.localizedString(forKey: self)
  }
}
