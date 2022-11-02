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
    
}
