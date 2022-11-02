//
//  SesacAPI.swift
//  Sesac_Networking
//
//  Created by HeecheolYoon on 2022/11/02.
//

import Foundation
import Alamofire

enum SesacAPI {
    case signUp(username: String, email: String, password: String)
    case signIn(email: String, password: String)
    case profile
        
    var url: URL {
        switch self {
        case .signUp:
            return URL(string: "http://api.memolease.com/api/v1/users/signup")!
        case .signIn:
            return URL(string: "http://api.memolease.com/api/v1/users/login")!
        case .profile:
            return URL(string: "http://api.memolease.com/api/v1/users/me")!
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .signUp, .signIn:
            return ["Content-Type": "application/x-www-form-urlencoded"]
        case .profile:
            return [
                "Authorization": "Bearer \(UserDefaultsManager.fetchAccessToken())"
            ]
        }
    }
    
    var parameters: [String: String]? {
        switch self {
        case .signUp(let username, let email, let password):
            return [
                "userName": username,
                "email": email,
                "password": password
            ]
        case .signIn(let email, let password):
            return [
                "email": email,
                "password": password
            ]
        case .profile:
            return nil
        }
    }
}
