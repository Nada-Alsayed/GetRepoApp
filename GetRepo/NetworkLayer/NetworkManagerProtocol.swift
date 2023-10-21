//
//  NetworkManagerProtocol.swift
//  GetRepo
//
//  Created by MAC on 21/10/2023.
//

import Foundation
protocol NetworkManagerProtocol{
    func fetchAllRepos<T: Decodable>(url: URL, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}
