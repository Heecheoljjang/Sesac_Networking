//
//  ProfileViewModel.swift
//  Sesac_Networking
//
//  Created by HeecheolYoon on 2022/11/02.
//

import Foundation
import RxCocoa
import RxSwift

final class ProfileViewModel {
    
    var profile = BehaviorRelay<Profile?>(value: nil)
    
    func fetchProfileData() {
        APIService.shared.requestProfile { [weak self] value in
            self?.profile.accept(value)
        }
    }
    
    func setLoginValue() {
        UserDefaultsManager.setLoginValue(value: true)
    }
    
    func removeLoginValue() {
        UserDefaultsManager.setLoginValue(value: false)
    }
}
