//
//  ForgetPasswordViewController.swift
//  UserLoginTutorial
//
//  Created by MacBook Air on 18.03.2023.
//

import UIKit
import SnapKit

class ForgetPasswordViewController: UIViewController {

    //MARK: - UI Components
    private let headerView = AuthHeaderView(title: "Forgot Password"  , subTitle: "Reset your Password")
    
    private let emailField = CustomTextField(fieldType: .email)
    
    private let resetPasswordButton = CustomButton(title: "Sign up", hasBackground: true, fontSize: .big)
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.resetPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - UI Setup
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(headerView)
        self.view.addSubview(emailField)
        self.view.addSubview(resetPasswordButton)
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top).offset(30)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.height.equalTo(230)
        }
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(11)
            make.centerX.equalTo(headerView.snp.centerX)
            make.height.equalTo(55)
            make.width.equalTo(self.view.snp.width).multipliedBy(0.85)
        }
        
        resetPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(22)
            make.centerX.equalTo(headerView.snp.centerX)
            make.height.equalTo(55)
            make.width.equalTo(self.view.snp.width).multipliedBy(0.85)
        }
    }
    
    
    //MARK: - Selectors
    
    @objc private func didTapForgotPassword() {

        let email = emailField.text ?? ""
        if !Validator.isValidEmail(with: email) {
            AlertManager.showInvalidEmailAlert(on: self)
        }
        
        AuthService.shared.forgotPassword(with: email) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showErrorSendingPasswordReset(on: self, with: error)
                return
            }
            
            AlertManager.showPasswordResetSent(on: self)
        }
        
    //TODO: - Email validation
        
        
        
        
        
    }
}
