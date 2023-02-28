//
//  UserViewController.swift
//  Auth_Test_App
//
//  Created by Zaur on 27.02.2023.
//

import UIKit

class UserViewController: UIViewController {
    
    //MARK: - Views
    private var logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Out", for: .normal)
        button.addTarget(self, action: #selector(buttonLogoutHandler), for: .touchUpInside)
        return button
    }()
    
    private var emailLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 24)
        lable.textColor = .brown
        lable.textAlignment = .center
        return lable
    }()
    
    private var nameLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 18)
        lable.textColor = .brown
        lable.textAlignment = .center
        return lable
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setViews()
        setLayout()
    }
     
    //MARK: - Setting views
    
    let auth = [Auth]()

    func configure() {
        view.backgroundColor = .white
        title = "Account"
        ApiManager.shared.getUSer { result in
            switch result {
            case .success(let model):
                self.emailLable.text = model.data?.profile?.email ?? "nil email"
                self.nameLable.text = model.data?.profile?.name ?? "nil name"
                print("result_code: - ", model.result_code ?? "nil")
            case .failure(let error):
                print("error user", error.localizedDescription)
            }
        }
        
    }
    
    
    @objc func buttonLogoutHandler(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setViews() {
        view.addSubviews([logOutButton, emailLable, nameLable])
    }
    
    func setLayout() {
        logOutButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        emailLable.snp.makeConstraints {
            $0.top.equalTo(logOutButton.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(40)
        }
        nameLable.snp.makeConstraints {
            $0.top.equalTo(emailLable.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(40)
        }
    }
    
}
