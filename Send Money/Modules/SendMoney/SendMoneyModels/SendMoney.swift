import Foundation

struct SendMoney: Codable {
    var title: Title?
    var services: [Services]?
}

struct Title: Codable {
    var en: String?
    var ar: String?
}
extension Title {
  var localized: String {
    switch LanguageManager.shared.currentLanguage {
    case "ar":
      return ar ?? en ?? ""
    default:
      return en ?? ar ?? ""
    }
  }
}

struct Services: Codable {
  var label: Title?
  var name: String?
  var providers: [Providers]?
  var localizedLabel: String {
    return label?.localized ?? ""
  }
}

struct Providers: Codable {
    var name: String?
    var id: String?
    var requiredFields: [RequiredFields]?

    enum CodingKeys: String, CodingKey {
        case name
        case id
        case requiredFields = "required_fields"
    }
}

struct RequiredFields: Codable {
    var label: Title?
    var name: String?
    var placeholder: String?
    var type: String?
    var validation: String?
    var maxLength: Int?
    var validationErrorMessage: String?
    var options: [Options]?

    enum CodingKeys: String, CodingKey {
        case label
        case name
        case placeholder
        case type
        case validation
        case maxLength = "max_length"
        case validationErrorMessage = "validation_error_message"
        case options
    }
}

struct Options: Codable {
    var label: String?
    var name: String?
}
