//
//  SignInView.swift
//  Sesac_Networking
//
//  Created by HeecheolYoon on 2022/11/02.
//

import UIKit
import SnapKit

final class SignInView: BaseView {
    
    let signInLabel: UILabel = {
        let label = UILabel()
        label.text = "로그인"
        label.textAlignment = .center
        
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일"
        label.textAlignment = .left
        
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .lightGray
        textField.placeholder = "이메일을 입력해주세요."
        
        return textField
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.textAlignment = .left
        
        return label
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .lightGray
        textField.placeholder = "비밀번호를 입력해주세요."
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    let doneButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .systemTeal
        configuration.title = "로그인"
        configuration.cornerStyle = .medium
        
        button.configuration = configuration
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configure() {
        super.configure()
        
        [signInLabel, emailTextField, emailLabel, passwordTextField, passwordLabel, doneButton].forEach {
            addSubview($0)
        }
        
        backgroundColor = .white
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        
        signInLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(signInLabel.snp.bottom).offset(120)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(80)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
    }
}
