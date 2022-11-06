//
//  SignInViewModel.swift
//  Sesac_Networking
//
//  Created by HeecheolYoon on 2022/11/02.
//

import Foundation
import RxSwift
import RxCocoa

final class SignInViewModel {
    
    var result = BehaviorRelay<Bool>(value: false)
    
    var profileResult = BehaviorRelay<Profile?>(value: nil)
    
    func requestSignIn(email: String, password: String) {
//        APIService.shared.requestSignIn(email: email, password: password) { [weak self] value in
//            self?.result.accept(value)
//        }
        APIService.shared.requestSignIn(email: email, password: password) { [weak self] value in
            self?.result.accept(value)
        }
    }
    
    func requestProfile() {
//        APIService.shared.requestProfile { [weak self] value in
//            self?.profileResult.accept(value)
//        }
        APIService.requestProfile { [weak self] value in
            self?.profileResult.accept(value)
        }
    }
    
    func fetchAccessToken() -> String {
        return UserDefaultsManager.fetchAccessToken()
    }
}
