import Foundation

protocol TokenStorage {
  var token: String? { get }
}

final class OAuth2TokenStorage {
    static let shared = OAuth2TokenStorage()
    private let tokenKey = "token"

    var token: String? {
           get {
               return UserDefaults.standard.string(forKey: tokenKey)
           }
           set {
               UserDefaults.standard.set(newValue, forKey: tokenKey)
           }
       }
}
