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
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    var createdTimeArray :[RepositoryDetails] = []
    var arrayOfRepos :[RepoModel] = []
    var viewModel : HomeViewModel!

    var repositoriesPerPages = 10
    var maxNumber = 10
    var paginationarray:[RepoModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel(apiFetchHandler: NetworkManager.shared)
        showIndicator()
            self.setTableCinfigration()
            self.getRepositories()
            self.getTime()
    }
    func showIndicator(){
        indicator.startAnimating()
        indicator.isHidden = false
    }
    func hideIndicator(){
        indicator.stopAnimating()
        indicator.isHidden = true
    }
    func setTableCinfigration(){
        tableView.register(UINib(nibName: Strings.CELL_REPO_ID, bundle: nil), forCellReuseIdentifier: Strings.CELL_REPO_ID)
    }
    
    func getRepositories(){
        viewModel.bindRepositoriesToView = {[weak self] in

            self?.arrayOfRepos = self?.viewModel.repositories ?? []
            self?.maxNumber = self?.arrayOfRepos.count ?? 0
            for i in 0..<10 {
                self?.paginationarray.append((self?.arrayOfRepos[i])!)
            }
        }
        viewModel.getData(url: URL_Creator.repositorois_URL())
    }
    
    func getTime(){
        viewModel.bindCreatedTimeToView = {[weak self] in
            self?.createdTimeArray.append(self?.viewModel.repository ?? RepositoryDetails())
            if self?.createdTimeArray.count == self?.arrayOfRepos.count {
                DispatchQueue.main.async {
                    self?.hideIndicator()
                    self?.tableView.reloadData()
                }
            }
        }
    }
    // simulate pagination
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
            cell .creationDate.text = Date_Formatter.formatDate(self.createdTimeArray[indexPath.row].createdAt)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginationarray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(170)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == tableView {
            if (scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height){
                setPaginationArray(repositoriesPerPages: repositoriesPerPages)
            }
        }
    }
}

 
