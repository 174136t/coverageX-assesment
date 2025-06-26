//
//  UserService.swift
//  UserListApp-CoverageX
//
//  Created by Lahiru Neranjan on 2025-06-26.
//

import Foundation

enum NetworkError:Error{
    case invalidURL
    case networkError(Error)
    case noData
    case decodingError
    
    var localizedDescription: String{
        switch self{
        case .invalidURL:
            return "Invalid URL"
        case .networkError(let error):
            return error.localizedDescription
        case .noData:
            return "No data is received"
        case .decodingError:
            return "Decoding Error happened"
        }
    }
}

class UserService{
    static let shared = UserService()
    private let baseURL = "https://randomuser.me/api"
    
    func fetchUsersList(completion: @escaping(Result<[User], NetworkError>) -> Void){
        guard let url = URL(string: "\(baseURL)/?results=20")else{
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                print("success")
                completion(.success(apiResponse.results))
            } catch {
                print("Error: \(error)")
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
