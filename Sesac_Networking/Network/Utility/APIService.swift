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
        
        let api = SesacAPI.signUp(username: name, email: email, password: password)
        print("네트워크 요청 이전 -> 이름 \(name) 이메일 \(email) 비밀번호 \(password)")
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
    
    func requestSignIn(email: String, password: String, completionHandler: @escaping ((Bool) -> ())) {
        
        let api = SesacAPI.signIn(email: email, password: password)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).validate(statusCode: 200...299)
            .responseDecodable(of: SignIn.self) { response in
            switch response.result {
            case .success(let data):
                UserDefaultsManager.setAccessToken(token: data.token)
                completionHandler(true)
                print("토큰 \(data.token)")
            case .failure(_):
                completionHandler(false)
                print("에러")
            }
        }
    }
    
    func requestProfile(completionHandler: @escaping ((Profile?) -> ())) {
        
        let api = SesacAPI.profile

        AF.request(api.url, method: .get, headers: api.headers).responseDecodable(of: Profile.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(data)
                print(data)
            case .failure(_):
                completionHandler(nil)
                print(NetworkingError.error)
            }
        }
    }
    
}

