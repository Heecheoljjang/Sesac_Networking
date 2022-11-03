//
//  enum.swift
//  Sesac_Networking
//
//  Created by HeecheolYoon on 2022/11/04.
//

import Foundation

enum AlertActionTitle {
    static let ok = "확인"
}

enum AlertTitle: String {
    case signUp = "회원가입 실패"
    case signIn = "로그인 실패"
}

enum AlertMessage: String {
    case signUp = "다시 입력해주세요."
    case signIn = "이메일과 비밀번호를 확인해주세요."
}
