//
//  NetworkManager.swift
//  EverDrink
//
//  Created by Данил Прокопенко on 16.09.2022.
//

import Foundation
import Alamofire

enum Link: String {
case apiLink = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s="
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}


class NetworkManager {
    
    static let shared = NetworkManager()
    
    
    private init() {}
    
    func fetchWithAlamofire(_ url: String, prefix: String, completion: @escaping(Result<Drinks, NetworkError>) -> Void) {
        AF.request(url+prefix)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let drink = Drinks.getDrinks(from: value) else {return}
                    completion(.success(drink))
                case .failure(let error):
                    print(error)
                    completion(.failure(.decodingError))
                }
            }
        
    }
    
    func fetchImageWithAlamofire(_ url: String, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(_):
                    guard let imageData = dataResponse.data else { return }
                    completion(.success(imageData))
                case .failure(let error):
                    print(error)
                    completion(.failure(.decodingError))
                }
            }
    }

}
