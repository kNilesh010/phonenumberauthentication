//
//  AuthManager.swift
//  AuthManager
//
//  Created by Nilesh Kumar on 06/04/22.
//

import Foundation
import FirebaseAuth

class AuthManager{
    static let shared = AuthManager()
    private let auth = Auth.auth()
    
    var verificationId: String?
    
    public func verifyPhoneNumber(phoneNumber: String, completion: @escaping(Bool) -> Void){
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) {[weak self] verificationId, error in
            guard let verificationId = verificationId, error == nil else {
                completion(false)
                return
            }
            self?.verificationId = verificationId
            completion(true)
        }
        
    }
    
    public func verifySMSCode(smsCode: String, completion: @escaping(Bool) -> Void){
        guard let verificationId = verificationId else {
            completion(false)
            return
        }
       let credentials = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: smsCode)
        auth.signIn(with: credentials) { authResult, error in
            guard let authResult = authResult, error == nil else {
                completion(false)
                return
                
            }
            completion(true)
        }
    }
}
