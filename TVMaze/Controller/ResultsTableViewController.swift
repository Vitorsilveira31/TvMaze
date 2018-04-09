//
//  ResultsTableViewController.swift
//  TVMaze
//
//  Created by Vitor Silveira on 07/04/2018.
//  Copyright © 2018 Vitor Silveira. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    let identifier = "ResultTableViewCell"
    
    var query = ""
    
    var feed: [SearchModel]?
    
    let api = Api.shared
    
    var searchBar:UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = .prominent
        search.placeholder = "Search..."
        search.sizeToFit()
        search.isTranslucent = true
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupApi()
        setupView()
        requestData(query: self.query)
    }
    
    func setupApi() {
        self.api.delegate = self
    }
    
    func setupView() {
        self.navigationItem.titleView = self.searchBar
        self.searchBar.text = self.query
        
        self.searchBar.delegate = self
        
        self.tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: self.identifier)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
    }
    
    func requestData(query: String) {
        self.api.requestSearch(search: query)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feed?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! ResultTableViewCell
        
        if let result = self.feed?[indexPath.row].show {
            cell.labelTitle.text = result.name
            
            if let resultImage = result.image {
                cell.imageViewResult.downloadedFrom(link: resultImage.medium)
            } else {
                cell.imageViewResult.image = #imageLiteral(resourceName: "sem_imagem_medium")
            }
            
            cell.imageViewResult.clipsToBounds = true
            cell.imageViewResult.contentMode = .scaleToFill
            
            if let genres = result.genres {
                cell.labelGenres.getGenre(genres: genres)
            }
            
            cell.buttonFavoriteResult.setImage(FavoriteUserDefaults.shared.recover().contains(result.id) ? #imageLiteral(resourceName: "favorite_full") : #imageLiteral(resourceName: "favorite_stroke"), for: .normal)
            
            cell.delegate = self
            
            cell.index = indexPath
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let result = self.feed?[indexPath.row].show {
            let resultViewController = ResultViewController()
            resultViewController.result = result
            resultViewController.delegate = self
            resultViewController.index = indexPath
            self.navigationController?.pushViewController(resultViewController, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let width: CGFloat = tableView.frame.width * 0.6
        return width * (3 / 4)
    }
    
}


extension ResultsTableViewController: FeedDelegate {
    func response(status: Int, feed: [SearchModel]?) {
        if status == 200 {
            self.feed = feed
            self.tableView.reloadData()
            if self.feed?.count == 0 {
                self.showAlert(title: "Vazio", message: "A pesquisa não retornou nenhum item", preferredStyle: .alert, titleAction: "OK", styleAction: .cancel)
            }
        }
    }
}

extension ResultsTableViewController: FavoriteDelegate {
    func favorite(index: IndexPath) {
        if let result = self.feed?[index.row].show {
            if FavoriteUserDefaults.shared.recover().contains(result.id) {
                var indexResult = 0
                for position in FavoriteUserDefaults.shared.recover() {
                    if position == result.id {
                        FavoriteUserDefaults.shared.remove(index: indexResult)
                        break
                    }
                    indexResult += 1
                }
            } else {
                FavoriteUserDefaults.shared.save(id: result.id)
            }
            self.tableView.reloadData()
        }
    }
}

extension ResultsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            self.showAlert(title: "Erro", message: "Digite algo na barra de pesquisa", preferredStyle: .alert, titleAction: "OK", styleAction: .cancel)
            return
        }
        requestData(query: searchText)
    }
}
