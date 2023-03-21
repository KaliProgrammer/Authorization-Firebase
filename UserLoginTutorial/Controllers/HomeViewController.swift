//
//  HomeViewController.swift
//  UserLoginTutorial
//
//  Created by MacBook Air on 18.03.2023.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    // MARK: - UI Components
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "Loading..."
        label.numberOfLines = 2
        return label
    }()

    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        AuthService.shared.fetchUser { [weak self] user, error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showFetchingUserError(on: self, with: error)
                return
            }
            if let user = user {
                self.label.text = "\(user.username)\n\(user.email)"
            }
        }
        
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(didTapLogut))
        
        self.view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY)

        }
        
    }

    // MARK: - Selectors

    @objc private func didTapLogut() {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showLogoutError(on: self, with: error)
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
}

