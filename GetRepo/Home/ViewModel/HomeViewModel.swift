//
//  HomeViewModel.swift
//  GetRepo
//
//  Created by MAC on 19/10/2023.
//

import Foundation
class HomeViewModel{
    private var apiFetchHandler : NetworkManagerProtocol!
    var bindResultToView : (()->()) = {}
      
    var res = [RepoModel]() {
          didSet{
              bindResultToView()
          }
      }
    var repository = RepositoryDetails() {
          didSet{
              bindResultToView()
          }
      }
    
    init(apiFetchHandler: NetworkManagerProtocol!) {
           self.apiFetchHandler = apiFetchHandler
       }
    
    func getData(url:URL){
        apiFetchHandler.fetchAllRepos(url: url, responseType: [RepoModel].self) {result in
                switch result {
                case .success(let repos):
                    self.res = repos
                case .failure(let error):
                    print("Failed to fetch Data: \(error)")
                }
        }
    }
    
    func getRepoDetails(url:URL){
        apiFetchHandler.fetchAllRepos(url: url, responseType: RepositoryDetails.self) {result in
                switch result {
                case .success(let repository):
                    self.repository = repository
                case .failure(let error):
                    print("Failed to fetch Data: \(error)")
                }
        }
    }
}
