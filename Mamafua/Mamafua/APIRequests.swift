//
//  APIRequests.swift
//  Mamafua
//
//  Created by macbook on 14/11/2019.
//  Copyright © 2019 Arusey. All rights reserved.
//

import Foundation


enum APIError: Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}


struct APIRequest {
    let resourceURL: URL
    
    init(endpoint: String) {
        let resourceString = "http://127.0.0.1:8000/user/\(endpoint)/"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func save (_ userToSave: User, completion: @escaping(Result<User, APIError>) -> Void) {
        
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(userToSave)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest)
            { data, response, _ in
                
                if let data = data { print(String(data: data, encoding: .utf8)!) }
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                
                do {
                    let userData = try JSONDecoder().decode(User.self, from: jsonData)
                    completion(.success(userData))
                }catch {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        }catch {
            completion(.failure(.encodingProblem))
        }
    }
    
}

struct LoginRequest {
    let resourceURL: URL
    
    init(endpoint: String) {
        let resourceString = "http://127.0.0.1:8000/user/\(endpoint)/"
        guard let resourceURL = URL(string: resourceString) else {
            fatalError()
        }
        self.resourceURL = resourceURL
    }
    
    func loginUser(_ userToLogin: AuthUser, completion: @escaping(Result<AuthUser, APIError>) -> Void) {
        
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(userToLogin)
            
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest)
            {
                data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200, let jsonData = data else {
                        completion(.failure(.responseProblem))
                        return
                }
                
                do {
                    let userData = try JSONDecoder().decode(AuthUser.self, from: jsonData)
                    completion(.success(userData))
                } catch {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
            
            
        }
        catch {
            completion(.failure(.encodingProblem))
        }
    }

}
