//
//  Langiage.swift
//  Send Money
//
//  Created by Pratheesh Bennet on 30/01/25.
//

import Foundation


class LanguageManager {
  
  static let shared = LanguageManager()
  
  // Get the current language (defaults to system language if not set)
  var currentLanguage: String {
    get {
      return UserDefaults.standard.string(forKey: "AppLanguage") ?? Locale.preferredLanguages.first ?? "en"
    }
    set {
      UserDefaults.standard.set(newValue, forKey: "AppLanguage")
      UserDefaults.standard.synchronize()
      // After setting the new language, apply it
      Bundle.setLanguage(newValue)
    }
  }
  
  // Set the language and update the bundle
  func setLanguage(languageCode: String) {
    currentLanguage = languageCode
    Bundle.setLanguage(languageCode)
  }
  
  // Get the current language
  func getCurrentLanguage() -> String {
    return currentLanguage
  }
}


extension Bundle {
  
  private static var languageBundle: Bundle?
  
  // Set the language by loading the appropriate localized bundle
  class func setLanguage(_ language: String) {
    // Get the path for the appropriate language folder (e.g., en.lproj, ar.lproj)
    guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
          let bundle = Bundle(path: path) else {
      return
    }
    
    objc_sync_enter(self)
    languageBundle = bundle
    objc_sync_exit(self)
  }
  
  // Get the localized string from the current selected language bundle
  class func localizedString(forKey key: String, value: String? = nil, table: String? = nil) -> String {
    guard let bundle = Bundle.languageBundle else {
      return NSLocalizedString(key, tableName: table, bundle: Bundle.main, value: value ?? "", comment: "")
    }
    return NSLocalizedString(key, tableName: table, bundle: bundle, value: value ?? "", comment: "")
  }
}
