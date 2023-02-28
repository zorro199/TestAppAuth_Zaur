//
//  ViewController.swift
//  Auth_Test_App
//
//  Created by Zaur on 26.02.2023.
//

import UIKit
import SnapKit
import SDWebImage

class LoginViewController: UIViewController {
    
    //MARK: - Views
    private var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your login"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your password"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private var captchaTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter captcha"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private var captchaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .magenta
        return imageView
    }()
    
    private var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
        return button
    }()
    
    private var lable: UILabel = {
        let lable = UILabel()
        lable.textColor = .brown
        lable.textAlignment = .center
        return lable
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setViews()
        setLayouts()
    }

    //MARK: - Setting views
    private func configure() {
        view.backgroundColor = UIColor(red: 240/255, green: 243/255, blue: 255/255, alpha: 1)
        title = "Sign in"
        ApiManager.shared.getCaptcha { model in
            guard let icon = model.data?.image_data, let url = URL(string: icon) else { return }
            self.captchaImageView.sd_setImage(with: url)
            print("key ", model.data?.key ?? "")
        }
        
    }
    
    // handler
    @objc func buttonHandler() {
        let username = loginTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let captcha = captchaTextField.text ?? ""
        ApiManager.shared.logIn(user: username, pass: password, captcha: captcha) { result in
            switch result {
            case .success(let model):
                print("work", model.result_message ?? "nil")
                print(model.result_code ?? "nil")
                print(model.data?.access_token ?? "nil")
                
                if model.result_code == "FLSCS" {
                    self.navigationController?.pushViewController(UserViewController(), animated: true)
                } else {
                    self.lable.text = model.result_message ?? "nil message"
                }
            case .failure(let error):
                print("error push", error.localizedDescription)
            }
        }
    }
    
    private func setViews() {
        view.addSubviews([loginTextField, passwordTextField,
                          captchaTextField ,captchaImageView,
                          signInButton, lable])
    }
    
    private func setLayouts() {
        loginTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.equalTo(50)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(loginTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.equalTo(50)
        }
        captchaTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.equalTo(50)
        }
        captchaImageView.snp.makeConstraints {
            $0.top.equalTo(captchaTextField.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(60)
            $0.trailing.equalToSuperview().offset(-60)
            $0.height.equalTo(70)
        }
        signInButton.snp.makeConstraints {
            $0.top.equalTo(captchaImageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(150)
        }
        lable.snp.makeConstraints {
            $0.top.equalTo(signInButton.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(60)
            $0.trailing.equalToSuperview().offset(-60)
            $0.height.equalTo(40)
        }
    }

}


// qwer12 password ИНТЕРЕС
