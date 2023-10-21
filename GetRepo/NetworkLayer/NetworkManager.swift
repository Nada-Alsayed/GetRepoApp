//
//  NetworkManager.swift
//  GetRepo
//
//  Created by MAC on 19/10/2023.
//

import Foundation
import Alamofire

class NetworkManager : NetworkManagerProtocol{
    static var shared = NetworkManager()

    private let headers: HTTPHeaders = [
        "Authorization": "Bearer \(Strings.TOKEN)"
        ]
    
    private init(){}
    
    func fetchAllRepos<T: Decodable>(url: URL, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void){
        AF.request(url, headers: headers).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode(responseType, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    
}
