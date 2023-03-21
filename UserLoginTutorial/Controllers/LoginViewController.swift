//
//  LoginViewController.swift
//  UserLoginTutorial
//
//  Created by MacBook Air on 18.03.2023.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    private let headerView = AuthHeaderView(title: "Sign in", subTitle: "Sign in to your account")
    
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)
    
    private let signInButton = CustomButton(title: "Sign in", hasBackground: true, fontSize: .big)
    private let newUserButton = CustomButton(title: "New user? Create Account.", fontSize: .med)
    private let forgotPasswordButton = CustomButton(title: "Forgot Password?", fontSize: .small)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        self.newUserButton.addTarget(self, action: #selector(didTapNewUser), for: .touchUpInside)
        self.forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)

        
        self.didTapNewUser()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(headerView)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(signInButton)
        self.view.addSubview(newUserButton)
        self.view.addSubview(forgotPasswordButton)
    
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(self.view.layoutMarginsGuide.snp.top)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.height.equalTo(222)
        }
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(12)
            make.width.equalTo(view.snp.width).multipliedBy(0.85)
            make.height.equalTo(55)
            make.centerX.equalTo(headerView.snp.centerX)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(22)
            make.centerX.equalTo(headerView.snp.centerX)
            make.height.equalTo(55)
            make.width.equalTo(view.snp.width).multipliedBy(0.85)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(22)
            make.centerX.equalTo(headerView.snp.centerX)
            make.height.equalTo(55)
            make.width.equalTo(view.snp.width).multipliedBy(0.85)
        }
        
        newUserButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(11)
            make.centerX.equalTo(headerView.snp.centerX)
            make.height.equalTo(44)
            make.width.equalTo(view.snp.width).multipliedBy(0.85)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(newUserButton.snp.bottom).offset(6)
            make.centerX.equalTo(headerView.snp.centerX)
            make.height.equalTo(44)
            make.width.equalTo(view.snp.width).multipliedBy(0.85)
        }
    }
    
    // MARK: - Selectors
    @objc private func didTapSignIn() {
        let loginRequest = LoginUserRequest(email: emailField.text ?? "",
                                            password: passwordField.text ?? "")
        
     
        //email check
        if !Validator.isValidEmail(with: loginRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        //password check
        if !Validator.isValidPassword(for: loginRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        AuthService.shared.signIn(with: loginRequest) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showSignInErrorAlert(on: self, with: error)
                return
            }
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
        
    }
    
    @objc private func didTapNewUser() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapForgotPassword() {
        let vc = ForgetPasswordViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
