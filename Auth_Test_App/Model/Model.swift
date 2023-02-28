//
//  Model.swift
//  Auth_Test_App
//
//  Created by Zaur on 27.02.2023.
//

struct Model: Codable {
    let result_code: String?
    let result_message: String?
    let data: Data?
}

struct Data: Codable {
    let key: String?
    let image_data: String?
}
// auth
struct Auth: Codable {
    let username: String?
    let password: String?
    let captcha: Captcha?
    let result_code: String?
    let result_message: String?
    let data: Token?
}

struct Token: Codable {
    let access_token: String?
}

struct Captcha: Codable {
    let key: String?
    let value: String?
}


struct UserProfile: Codable {
    let result_message: String?
    //let data: Profile?
}

//struct Profile: Codable {
//    let profile: ProfileData?
//}
//
//struct ProfileData: Codable {
//    let middle_name: String?
//}
