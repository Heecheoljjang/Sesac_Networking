//
//  ProfileViewController.swift
//  Sesac_Networking
//
//  Created by HeecheolYoon on 2022/11/02.
//

import UIKit
import RxSwift
import RxCocoa

final class ProfileViewController: BaseViewController {
    
    let viewModel = ProfileViewModel()
    
    var mainView = ProfileView()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        
        //유저디폴트 세팅
        viewModel.setLoginValue()
        
        //데이터가져오기
        viewModel.fetchProfileData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(UserDefaultsManager.fetchLoginValue())
    }
    private func bind() {
        viewModel.profile
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { [weak self] value in
                
                guard let photo = value?.user.photo,
                      let url = URL(string: photo),
                      let data = try? Data(contentsOf: url) else { return }
                                
                self?.mainView.profileImageView.image = UIImage(data: data)
                
                self?.mainView.name.text = value?.user.username
                
                self?.mainView.email.text = value?.user.email
            })
            .disposed(by: disposeBag)
        
        mainView.logoutButton.rx.tap
            .bind(onNext: { [weak self] _ in
                //유저디폴트 삭제하고 다시 회원가입 화면
                self?.viewModel.removeLoginValue()
                
                self?.setSignUpViewController()
            })
            .disposed(by: disposeBag)
    }
    
    private func setSignUpViewController() {
        
        //로그인 화면으로 루트뷰컨트롤러 바꾸기
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
        let vc = SignUpViewController()
                
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
