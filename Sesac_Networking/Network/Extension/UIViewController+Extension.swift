//
//  UIViewController+Extension.swift
//  Sesac_Networking
//
//  Created by HeecheolYoon on 2022/11/03.
//

import UIKit

extension UIViewController {
    
    func setRootViewController<T: UIViewController>(vc: T) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
        let vc = vc
                
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    func showAlert(title: AlertTitle, message: AlertMessage) {
        let alert = UIAlertController(title: title.rawValue, message: message.rawValue, preferredStyle: .alert)
        let ok = UIAlertAction(title: AlertActionTitle.ok, style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
