//
//  Langiage.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 30/01/25.
//

import Foundation


class LanguageManager {
  static let shared = LanguageManager()
  var currentLanguage: String {
    get {
      return UserDefaults.standard.string(forKey: "AppLanguage") ?? Locale.preferredLanguages.first ?? "en"
    }
    set {
      UserDefaults.standard.set(newValue, forKey: "AppLanguage")
      UserDefaults.standard.synchronize()
      Bundle.setLanguage(newValue)
    }
  }
  
  func setLanguage(languageCode: String) {
    currentLanguage = languageCode
    Bundle.setLanguage(languageCode)
  }
  func getCurrentLanguage() -> String {
    return currentLanguage
  }
}


extension Bundle {
  private static var languageBundle: Bundle?
  static func setLanguage(_ language: String) {
    guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
          let bundle = Bundle(path: path) else {
      return
    }
    languageBundle = bundle
  }
  
  static func localizedString(forKey key: String, value: String? = nil, table: String? = nil) -> String {
    guard let bundle = Bundle.languageBundle else {
      return NSLocalizedString(key, tableName: table, bundle: Bundle.main, value: value ?? "", comment: "")
    }
    return NSLocalizedString(key, tableName: table, bundle: bundle, value: value ?? "", comment: "")
  }
}
