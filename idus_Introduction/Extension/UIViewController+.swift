//
//  UIViewController+.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/17.
//

import UIKit

extension UIViewController {
    
    func alert(title: String, message: String, okTitle: String = "확인") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: okTitle, style: .default)
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
    }
}
