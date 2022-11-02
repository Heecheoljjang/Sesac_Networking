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
    
    var mainView = SignUpView()
    
    let viewModel = SignUpViewModel()
    
    let disposeBag = DisposeBag()
    
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
                value ? self?.setSignInViewController() : self?.showAlert()
            })
            .disposed(by: disposeBag)
    }
    
    private func setSignInViewController() {
        
        //로그인 화면으로 루트뷰컨트롤러 바꾸기
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
        let vc = SignInViewController()
                
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "회원가입 실패", message: "다시 입력해주세요.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
