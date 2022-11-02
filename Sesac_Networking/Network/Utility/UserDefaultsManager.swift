//
//  UserDefaultsManager.swift
//  Sesac_Networking
//
//  Created by HeecheolYoon on 2022/11/02.
//

import Foundation

final class UserDefaultsManager {
    
    private init() {}
    
    static let userDefaults = UserDefaults.standard
    
    static func setLoginValue(value: Bool) {
        userDefaults.set(value, forKey: "SignUp")
    }
    
    static func setAccessToken(token: String) {
        userDefaults.set(token, forKey: "Login")
    }
    
    static func fetchLoginValue() -> Bool {
        return userDefaults.bool(forKey: "SignUp")
    }
    
    static func fetchAccessToken() -> String {
        return userDefaults.string(forKey: "Login") ?? ""
    }
}
