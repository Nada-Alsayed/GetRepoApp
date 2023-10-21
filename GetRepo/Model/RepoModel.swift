////
////  RepoModel.swift
////  GetRepo
////
////  Created by MAC on 19/10/2023.
////
//
import Foundation
//
struct RepoModel:Codable{
    let id: Int
    let nodeID: String
    let fullName: String
    let name: String
    let owner: Owner
    let welcomePrivate: Bool
    let html_url: String
    init(){
        id = 0
        nodeID = ""
        fullName = ""
        name = ""
        owner = Owner()
        welcomePrivate = false
        html_url = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case welcomePrivate = "private"
        case owner
        case html_url
    }
    
}
struct Owner: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    init(){
        id = 0
        login = ""
        nodeID = ""
        avatarURL = ""
    }
    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
    }
}

struct RepositoryDetails: Codable {
    let createdAt: String
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
    }
    init(){
        createdAt = ""
    }
}

