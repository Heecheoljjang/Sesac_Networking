//
//  SignInViewController.swift
//  Sesac_Networking
//
//  Created by HeecheolYoon on 2022/11/02.
//

import UIKit
import RxCocoa
import RxSwift

final class SignInViewController: BaseViewController {
    
    var mainView = SignInView()
    
    let viewModel = SignInViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    private func bind() {
        Observable.combineLatest(mainView.emailTextField.rx.text.orEmpty, mainView.passwordTextField.rx.text.orEmpty) { email, password in
            email.count != 0 && password.count != 0
        }
        .bind(to: mainView.doneButton.rx.isEnabled)
        .disposed(by: disposeBag)
        
        mainView.doneButton.rx.tap
            .bind(onNext: { [weak self] _ in
                
                guard let email = self?.mainView.emailTextField.text,
                      let password = self?.mainView.passwordTextField.text else { return }
                
                self?.viewModel.requestSignIn(email: email, password: password)
            })
            .disposed(by: disposeBag)
        
        viewModel.result
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] value in
                //result가 true면 성공해서 토큰이 있는 상태이므로 토큰 저장하고, 이 토큰으로 profile 요청
                value ? self?.viewModel.requestProfile() : self?.showAlert()
            })
            .disposed(by: disposeBag)
        
        //profile요청했을때 성공하면 nil이 아닐 것이므로
        viewModel.profileResult
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { [weak self] value in
                value != nil ? self?.presentProfile() : self?.showAlert()
            })
            .disposed(by: disposeBag)
    }
    
    private func presentProfile() {
        let vc = ProfileViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "로그인 실패", message: "이메일과 비밀번호를 확인해주세요.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
