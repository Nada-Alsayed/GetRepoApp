//
//  HomeViewModel.swift
//  GetRepo
//
//  Created by MAC on 19/10/2023.
//

import Foundation
class HomeViewModel{
    private var apiFetchHandler : NetworkManagerProtocol!
    var bindRepositoriesToView : (()->()) = {}
    var bindCreatedTimeToView : (()->()) = {}
    
    var res = [RepoModel]() {
        didSet{
            DispatchQueue.global().async {
                for i in self.res {
                    self.getRepoDetails(url:  URL_Creator.repoDetails(ownerName: i.owner.login, repoName: i.name))
                }
            }
            bindRepositoriesToView()
        }
    }
    var repository = RepositoryDetails(){
        didSet{
            bindCreatedTimeToView()
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
                print("Failed  Date: \(error)")
            }
        }
    }
    
    func getRepoDetails(url: URL) {
        apiFetchHandler.fetchAllRepos(url: url, responseType: RepositoryDetails.self) { result in
            switch result {
            case .success(let repository):
                self.repository = repository
            case .failure(let error):
                print("Failed to fetch Repository Details: \(error)")
            }
        }
    }

}


