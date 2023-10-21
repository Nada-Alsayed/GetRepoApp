//
//  URL_Creator.swift
//  GetRepo
//
//  Created by MAC on 20/10/2023.
//

import Foundation
class URL_Creator{
    static private let baseURL = "https://api.github.com"
    
    static func repositorois_URL()->URL{
        return URL(string: baseURL+"/repositories")!
    }
    
    static func repoDetails(ownerName:String,repoName:String)->URL{
        let string = baseURL + "/repos" + "/\(ownerName)" + "/\(repoName)"
        return URL(string: string)!
    }
}
