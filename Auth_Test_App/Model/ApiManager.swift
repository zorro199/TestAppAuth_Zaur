//
//  ApiManager.swift
//  Auth_Test_App
//
//  Created by Zaur on 27.02.2023.
//

import Foundation

 let captchaUrl = "https://api-events.pfdo.ru/v1/captcha"
 let authUserUrl = "https://api-events.pfdo.ru/v1/auth"
 let userLogOut = "https://api-events.pfdo.ru/v1/user"

class ApiManager {
    static let shared = ApiManager()
    
    
    // MARK: - getCaptcha
    func getCaptcha(complition: @escaping (Model) -> Void) {
        guard let url = URL(string: captchaUrl) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { data, _ , error in
            if error != nil {
                print("Error captcha")
            }
            if let data = data, let captchaDecoder = try? JSONDecoder().decode(Model.self, from: data) {
                complition(captchaDecoder)
            } else {
                print("Error decode")
            }
        }
        task.resume()
    }
    
    
    let auth = [Auth]()
    let getUser = [UserProfile]()
    
    // MARK: - LOG IN
    func logIn(user: String, pass: String, captcha: Any, completion: @escaping (Result<Auth, Error>) -> Void) {
        let captcha = auth.map { auth in
            auth.captcha?.value ?? ""
        }
        guard let url = URL(string: authUserUrl) else { return }
        var request = URLRequest(url: url)
        let parametrs: [String: Any] = ["username": user,
                                        "password": pass,
                                        "captcha": captcha]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parametrs, options: []) else { return }
        request.httpBody = httpBody
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if error != nil {
                print("Error auth")
            }
            if let data = data, let authDecoder = try? JSONDecoder().decode(Auth.self, from: data) {
                DispatchQueue.main.async {
                    completion(.success(authDecoder))
                }
            } else {
                //completion(.failure(error!))
                print("error decode login")
            }
        }
        task.resume()
    }
    
    // MARK: - GET USER
    func getUSer(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        let token = auth.first?.data?.access_token ?? "nil getUser"
        guard let url = URL(string: userLogOut) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "authorization")
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if error != nil {
                print("Error auth")
            }
            if let data = data, let profileDecode = try? JSONDecoder().decode(UserProfile.self, from: data) {
                DispatchQueue.main.async {
                    completion(.success(profileDecode))
                }
            } else {
                //completion(.failure(error!))
                print("error decode get user")
            }
        }
        task.resume()
    }
}
