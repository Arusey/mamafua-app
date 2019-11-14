//
//  Message.swift
//  Mamafua
//
//  Created by macbook on 16/11/2019.
//  Copyright © 2019 Arusey. All rights reserved.
//

import Foundation

class User: Codable {
    var firstName: String?
    var lastName: String?
    var email: String?
    var password: String?
    

    private enum CodingKeys: String, CodingKey {
            case firstName = "first_name"
            case lastName = "last_name"
            case email
            case password
    }
    
    required public init(from decoder: Decoder) throws { let container = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try? container.decode(String.self, forKey: .firstName); lastName = try? container.decode(String.self, forKey: .lastName)
            email = try? container.decode(String.self, forKey: .email)
    }

    func encode(to encoder: Encoder) throws { var container = encoder.container(keyedBy: CodingKeys.self); try container.encode(firstName, forKey: .firstName) 
        try container.encode(lastName, forKey: .lastName)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)             }

    
    
    init(firstName: String, lastName: String, email: String, password: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
    }
    
}



class AuthUser: Codable {
    var email: String?
    var password: String?
    
    private enum CodingKeys: String, CodingKey {
        case email
        case password
    }
    
    required public init(from decoder: Decoder) throws { let container = try decoder.container(keyedBy: CodingKeys.self)
        
        email = try? container.decode(String.self, forKey: .email)
    }
    
    func encode(to encoder: Encoder) throws { var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
    }
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
        
    }
    
}

