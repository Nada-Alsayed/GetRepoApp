//
//  HomeVC.swift
//  GetRepo
//
//  Created by MAC on 19/10/2023.
//

import UIKit
import Kingfisher

class HomeVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel : HomeViewModel!
    var arrayOfRepos = [RepoModel]()
    var repositoriesPerPages = 10
    var maxNumber = 10
    var paginationarray:[RepoModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel(apiFetchHandler: NetworkManager.shared)
        setTableCinfigration()
        getRepositories()
    }
    
    func setTableCinfigration(){
        tableView.register(UINib(nibName: Strings.CELL_REPO_ID, bundle: nil), forCellReuseIdentifier: Strings.CELL_REPO_ID)
    }
    
    func getRepositories(){
        viewModel.bindResultToView = {[weak self] in
            
            self?.arrayOfRepos = self?.viewModel.res ?? []
            self?.maxNumber = self?.arrayOfRepos.count ?? 0
            
            for i in 0..<10 {
                self?.paginationarray.append((self?.arrayOfRepos[i])!)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.getData(url: URL_Creator.repos_URL())
    }
    
//    func getRepositoryDetails(){
//        var date : Date = Date()
//        viewModel.bindResultToView = {[weak self] in
//            date = self?.viewModel.repository.createdAt ?? Date()
//        }
//        viewModel.getRepoDetails(url: URL_Creator.repoDetails(ownerName: <#T##String#>, repoName: <#T##String#>))
//    }
    
    func setPaginationArray(repositoriesPerPages:Int){
        if repositoriesPerPages >= maxNumber {
            return
        }
        else if repositoriesPerPages >= maxNumber - 10 {
            for i in repositoriesPerPages..<maxNumber {
                paginationarray.append(arrayOfRepos[i])
            }
            self.repositoriesPerPages += 10
        }
        else{
            for i in repositoriesPerPages..<repositoriesPerPages + 10{
                paginationarray.append(arrayOfRepos[i])
            }
            self.repositoriesPerPages += 10
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension HomeVC :UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Strings.CELL_REPO_ID, for: indexPath) as!TableViewCell
        
        cell.ownerName.text = self.paginationarray[indexPath.row].owner.login
        cell.repoName.text = self.paginationarray[indexPath.row].fullName
        cell.ownerAvatar.kf.setImage(with:URL(string: paginationarray[indexPath.row].owner.avatarURL))
       
        cell.ownerAvatar.layer.cornerRadius = 15
//        var date : Date = Date()
//        viewModel.bindResultToView = {[weak self] in
//            date = self?.viewModel.repository.createdAt ?? Date()
//            cell.creationDate.text = "\(date)"
//        }
//        viewModel.getRepoDetails(url: URL_Creator.repoDetails(ownerName: self.paginationarray[indexPath.row].owner.login, repoName: self.paginationarray[indexPath.row].name))
        cell.view.layer.cornerRadius = 15
        cell.view.layer.masksToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginationarray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(150)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == tableView {
            if (scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height){
                setPaginationArray(repositoriesPerPages: repositoriesPerPages)
            }
        }
    }
}
