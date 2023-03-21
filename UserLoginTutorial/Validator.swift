//
//  Validator.swift
//  UserLoginTutorial
//
//  Created by MacBook Air on 21.03.2023.
//

import Foundation

class Validator {
    static func isValidEmail(with email: String) -> Bool {
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPred.evaluate(with: email)
    }
    
    static func isValidUserName(for username: String) -> Bool {
        let username = username.trimmingCharacters(in: .whitespacesAndNewlines)
        let usernameRegex = "\\w{4,24}"
        let usernamePred = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        return usernamePred.evaluate(with: username)
    }
    
    static func isValidPassword(for password: String) -> Bool {
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,32}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPred.evaluate(with: password)
    }
    
    
}
