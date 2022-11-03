//
//  SignUpViewController.swift
//  Sesac_Networking
//
//  Created by HeecheolYoon on 2022/11/02.
//

import UIKit
import RxSwift
import RxCocoa

final class SignUpViewController: BaseViewController {
    
    private var mainView = SignUpView()
    
    private let viewModel = SignUpViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaultsManager.setLoginValue(value: false)
        bind()
    }
    
    override func configure() {
        super.configure()
    }
    
    private func bind() {
        
        Observable.combineLatest(mainView.nameTextField.rx.text.orEmpty, mainView.emailTextField.rx.text.orEmpty, mainView.passwordTextField.rx.text.orEmpty) { name, email, password in
            name.count != 0 && email.count != 0 && password.count >= 8
        }
        .bind(to: mainView.doneButton.rx.isEnabled)
        .disposed(by: disposeBag)

        mainView.doneButton.rx.tap
            .bind(onNext: { [weak self] _ in
                
                guard let name = self?.mainView.nameTextField.text,
                      let email = self?.mainView.emailTextField.text,
                      let password = self?.mainView.passwordTextField.text else { return }
                    
                self?.viewModel.signUp(name: name, email: email, password: password)
            })
            .disposed(by: disposeBag)

        viewModel.signUpSuccess
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] value in
                print("회원가입 밸류 \(value)")
                value ? self?.setRootViewController(vc: SignInViewController()) : self?.showAlert(title: .signUp, message: .signUp)
            })
            .disposed(by: disposeBag)
    }
}
