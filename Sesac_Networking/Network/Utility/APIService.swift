//
//  APIService.swift
//  Sesac_Networking
//
//  Created by HeecheolYoon on 2022/11/02.
//

import Foundation
import Alamofire

final class APIService {
    
    private init() {}
    
    static let shared = APIService()
    
    func signUp(name: String, email: String, password: String, completionHandler: @escaping ((Bool) -> ())){
        
        let api = SesacAPI.signUp(username: name, email: email, password: email)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseString { response in
            
            switch response.result {
            case .success(let result):
                completionHandler(true)
                print(result)
            case .failure(let error):
                completionHandler(false)
                print(error)
            }
        }
    }
    
    func login(email: String, password: String) {
        
        let api = SesacAPI.signIn(email: email, password: password)

        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).validate(statusCode: 200...299)
            .responseDecodable(of: SignIn.self) { response in
            switch response.result {
            case .success(let data):
                print(data.token) //디코딩했기때문에 token이라는 값에 접근가능
                UserDefaults.standard.set(data.token, forKey: "token")
            case .failure(_):
                print(response.response?.statusCode)
            }
        }
    }
    
    func profile() {
        
        let api = SesacAPI.profile

        AF.request(api.url, method: .get, headers: api.headers).responseDecodable(of: Profile.self) { response in
            switch response.result {
            case .success(let data):
                print(data)
            case .failure(_):
                print(response.response?.statusCode)
            }
        }
    }
    
}

