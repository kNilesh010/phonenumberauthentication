//
//  SMSVerificationViewController.swift
//  SMSVerificationViewController
//
//  Created by Nilesh Kumar on 06/04/22.
//

import UIKit

class SMSVerificationViewController: UIViewController, UITextFieldDelegate {

    private let myTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter phone Number"
        textField.textAlignment = .left
        textField.returnKeyType = .continue
        textField.backgroundColor = .gray .withAlphaComponent(0.1)
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myTextField)
        myTextField.frame = CGRect(x: 0, y: 200, width: 300, height: 50)
        myTextField.center = view.center
        view.backgroundColor = .gray
        myTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let text = textField.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }
        let code = text
        AuthManager.shared.verifySMSCode(smsCode: code) {[weak self] success in
            guard success else{
                return
            }
            DispatchQueue.main.async {
                let vc = HomeViewController()
                vc.modalPresentationStyle = .fullScreen
                vc.title = "Home"
                self?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
            }
        }
        
        return true
    }

}
