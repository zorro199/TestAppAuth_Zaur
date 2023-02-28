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
        setLayout()
    }
     
    //MARK: - Setting views

    func configure() {
        view.backgroundColor = .white
        ApiManager.shared.getUSer { result in
            switch result {
            case .success(let model):
                self.lable.text = model.result_message ?? "nil"
            case .failure(let error):
                print("error user", error.localizedDescription)
            }
        }
        
    }
    
    @objc func buttonLogoutHandler(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setViews() {
        view.addSubviews([logOutButton, lable])
    }
    
    func setLayout() {
        logOutButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        lable.snp.makeConstraints {
            $0.top.equalTo(logOutButton.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(40)
        }
    }
    
}
