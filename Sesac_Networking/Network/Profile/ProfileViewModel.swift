//
//  ProfileViewModel.swift
//  Sesac_Networking
//
//  Created by HeecheolYoon on 2022/11/02.
//

import Foundation
import RxCocoa
import RxSwift

final class ProfileViewModel: CommonViewModel {

    struct Input {
        let logoutTap: ControlEvent<Void>
    }

    struct Output {
        let logoutTap: ControlEvent<Void>
        let profile: Driver<Profile?>
    }

    func transform(input: Input) -> Output {
        let profile = profile.asDriver(onErrorJustReturn: nil)
        
        return Output(logoutTap: input.logoutTap, profile: profile)
    }
    
    var profile = BehaviorRelay<Profile?>(value: nil)
    
    func fetchProfileData() {
//        APIService.shared.requestProfile { [weak self] value in
//            self?.profile.accept(value)
//        }
        APIService.requestProfile { [weak self] value in
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
