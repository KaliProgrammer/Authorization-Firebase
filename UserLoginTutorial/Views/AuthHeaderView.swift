
import UIKit
import SnapKit

class AuthHeaderView: UIView {
    
    // MARK: - UI Components
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "logo")
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.text = "Error"
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Error"
        return label
    }()
    
    // MARK: - LifeCycle
    init(title: String, subTitle: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.addSubview(logoImageView)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        
        self.logoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(30)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(90)
            make.height.equalTo(logoImageView.snp.width)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(19)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo( self.snp.trailing)
        }
        
        self.subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo( self.snp.trailing)
        }
    }
}
