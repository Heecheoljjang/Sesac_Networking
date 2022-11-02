//
//  SignUpViewModel.swift
//  Sesac_Networking
//
//  Created by HeecheolYoon on 2022/11/02.
//

import Foundation
import RxSwift
import RxCocoa

final class SignUpViewModel {
        
    var signUpSuccess = BehaviorRelay<Bool>(value: false)
    
    func checkUserDefaults() -> Bool {
        return UserDefaultsManager.fetchLoginValue()
    }
    
    func signUp(name: String, email: String, password: String) {
        APIService.shared.signUp(name: name, email: email, password: password) { [weak self] value in
            self?.signUpSuccess.accept(value)
        }
    }
}
