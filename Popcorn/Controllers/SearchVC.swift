//
//  SearchVC.swift
//  Popcorn
//
//  Created by ilkay sever on 26.06.2020.
//  Copyright © 2020 ilkay sever. All rights reserved.
//

import UIKit
import SVProgressHUD

class SearchVC: UIViewController {
    
    let searchService = SearchService()
    var searchData: [MovieModel]!
    var text: String = ""
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieTableView.isHidden = true
        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide NavigationBar in this viewController.
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show NavigationBar other viewController.
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func fetchMovies() {
        searchService.getSearch(text: text) { [weak self](result) in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                self.searchData = response.search
                DispatchQueue.main.async {
                    self.movieTableView.reloadData()
                    print(response.search ?? "")
                }
            case .failure(let error):
                print("*************************\(error)*******************************")
            }
        }
    }
    
    func setDelegates() {
        searchBar.delegate = self
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.register(MovieTableViewCell.self)
    }
    
}

extension SearchVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.text = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchMovies()
        self.movieTableView.reloadData()
        self.movieTableView.isHidden = false
        self.view.endEditing(true)
    }

}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchData != nil {
            return searchData.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.fillSearchList(searchResponse: searchData[indexPath.row])
        cell.searchResponse = searchData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MovieDetailVC", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailVC
        destination.identifier = self.searchData[indexPath.row].imdbID
        self.navigationController?.pushViewController(destination, animated: true)
    }
}
