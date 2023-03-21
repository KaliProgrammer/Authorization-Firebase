//
//  RegisterViewController.swift
//  UserLoginTutorial
//
//  Created by MacBook Air on 18.03.2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - UI Components
    private let headerView = AuthHeaderView(title: "Sign Up", subTitle: "Create your account")
    
    private let usernameField = CustomTextField(fieldType: .username)
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)
    
    private let signUpButton = CustomButton(title: "Sign Up", hasBackground: true, fontSize: .big)
    private let signInButton = CustomButton(title: "Already have an account? Sign In.", fontSize: .med)
    
    private let termsTextView: UITextView = {
        
        let attributedString = NSMutableAttributedString(string: "By creating an account, you agree to our Terms & Conditions and you acknowledge that you have read our Privacy Policy.")
        attributedString.addAttribute(.link, value: "terms://termsAndConditions", range: (attributedString.string as NSString).range(of: "Terms & Conditions"))
        
        attributedString.addAttribute(.link, value: "privacy://privacyPolicy", range: (attributedString.string as NSString).range(of: "Privacy Policy"))
        
        
        let tv = UITextView()
        tv.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        tv.backgroundColor = .clear
        tv.attributedText = attributedString
        tv.textColor = .label
        tv.isSelectable = true
        tv.isEditable = false
        tv.delaysContentTouches = false
        tv.isScrollEnabled = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        self.setupUI()
        
        self.termsTextView.delegate = self
        
        self.signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupUI() {
        
        
        self.view.backgroundColor = .systemBackground

        self.view.addSubview(headerView)
        self.view.addSubview(usernameField)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(signUpButton)
        self.view.addSubview(termsTextView)
        self.view.addSubview(signInButton)
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(self.view.layoutMarginsGuide.snp.top)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.height.equalTo(222)
        }
        
        usernameField.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(12)
            make.centerX.equalTo(headerView.snp.centerX)
            make.height.equalTo(55)
            make.width.equalTo(view.snp.width).multipliedBy(0.85)
        }
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(usernameField.snp.bottom).offset(22)
            make.centerX.equalTo(headerView.snp.centerX)
            make.height.equalTo(55)
            make.width.equalTo(view.snp.width).multipliedBy(0.85)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(22)
            make.centerX.equalTo(headerView.snp.centerX)
            make.height.equalTo(55)
            make.width.equalTo(view.snp.width).multipliedBy(0.85)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(22)
            make.centerX.equalTo(headerView.snp.centerX)
            make.height.equalTo(55)
            make.width.equalTo(view.snp.width).multipliedBy(0.85)
        }
        
        termsTextView.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(6)
            make.centerX.equalTo(headerView.snp.centerX)
            make.width.equalTo(view.snp.width).multipliedBy(0.85)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(termsTextView.snp.bottom).offset(11)
            make.centerX.equalTo(headerView.snp.centerX)
            make.height.equalTo(44)
            make.width.equalTo(view.snp.width).multipliedBy(0.85)
        }
    }
    
    // MARK: - Selectors
    @objc func didTapSignUp() {
        
        let registerUserRequest = RegisterUserRequest(username: self.usernameField.text ?? "",
                                                      email: self.emailField.text ?? "",
                                                      password: self.passwordField.text ?? "")
        
        //username check
        if !Validator.isValidUserName(for: registerUserRequest.username) {
            AlertManager.showInvalidUsernameAlert(on: self)
            return
        }
        
        //email check
        if !Validator.isValidEmail(with: registerUserRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        //password check
        if !Validator.isValidPassword(for: registerUserRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        AuthService.shared.registerUser(with: registerUserRequest) { [weak self] wasRegistered, error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: self, with: error)
                return
            }
            if wasRegistered {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
            }  else {
                AlertManager.showRegistrationErrorAlert(on: self)
            }
        }
    }
    
    @objc private func didTapSignIn() {
        self.navigationController?.popToRootViewController(animated: true)
    }
  
}

extension RegisterViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        if URL.scheme == "terms" {
            self.showWebViewerController(with: "https://policies.google.com/terms?hl=en")
        } else if URL.scheme == "privacy" {
            self.showWebViewerController(with: "https://policies.google.com/privacy?hl=en")
        }
        
        return true
    }
    
    private func showWebViewerController(with urlString: String) {
        let vc = WebViewerController(with: urlString)
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        textView.delegate = nil
        textView.selectedTextRange = nil
        textView.delegate = self
    }
}
