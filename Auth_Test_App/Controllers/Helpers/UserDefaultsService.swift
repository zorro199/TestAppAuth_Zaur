//
//  UserDefaultsService.swift
//  Auth_Test_App
//
//  Created by Zaur on 28.02.2023.
//

import Foundation

@propertyWrapper
struct UserDefaultsService<T: Codable> {
    
    private let key: String
    private let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
       
        get {
            guard let data = UserDefaults.standard.object(forKey: key) as? Foundation.Data else { return defaultValue }
            
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}

extension UserDefaults {
    @UserDefaultsService(key: "token", defaultValue: "")
    static var token: String
    
    @UserDefaultsService(key: "refreshToken", defaultValue: "")
    static var refreshToken: String
}
