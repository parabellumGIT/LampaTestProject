//
//  FeedViewController.swift
//  LampaTestProject
//
//  Created by ParaBellum on 11/9/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit
import MBProgressHUD
import AMScrollingNavbar

class FeedViewController: UIViewController,UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
       
        if let searchText = searchController.searchBar.text{
            filteredNews = searchText.isEmpty ? news : news.filter({ (item:NewsFeedViewModelItem) -> Bool in
              return  item.titleName.range(of: searchText, options: .caseInsensitive) != nil
            })
            
            tableView.reloadData()
        }
    }
    
    private enum CellIds:String{
        case TopNewsCell
        case NewsCell
        case NewsWithoutImageCell
    }
    
    //MARK: Properties
    fileprivate weak var navController:ScrollingNavigationController!
    var searchController: UISearchController!
    
    var news:[NewsFeedViewModelItem] = []
    var filteredNews:[NewsFeedViewModelItem] = []
    let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "Apologies, something went wrong. Please try again later..."
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    
    
    @IBAction func searchButtonTapped(_ sender: UIBarButtonItem) {
        
        navController.stopFollowingScrollView(showingNavbar: true)
        tableView.tableHeaderView = searchController.searchBar
        let rect = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.tableView.frame.height)
        tableView.scrollRectToVisible(rect, animated: true)
        
    }
    
    
    //MARK: - Lyfecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    
    fileprivate func getNews() {
        let webService = WebService.shared()
        webService.getNews { (items, error) in
            if let _ = error{
                DispatchQueue.main.async(execute: {
                    self.errorMessageLabel.isHidden = false
                    self.errorMessageLabel.frame = self.tableView.frame
                    MBProgressHUD.hide(for: self.view, animated: true)
                })
               return
            }
            if let newsItems = items{
                let newsFeedVM = NewsFeedViewModel(news: newsItems)
                self.news = newsFeedVM.items
                self.filteredNews = self.news
                DispatchQueue.main.async(execute: { () -> Void in
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.tableView.reloadData()
                })
            }
            
        }
    }
    fileprivate func initialSetup() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = .white
        searchController.searchBar.backgroundColor = .black
        searchController.searchBar.barTintColor = .black
        searchController.hidesNavigationBarDuringPresentation = false
        navController = self.navigationController as? ScrollingNavigationController
        tableView.addSubview(self.errorMessageLabel)
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets(top: -6, left: 0, bottom: 0, right: 0)
        getNews()
        MBProgressHUD.showAdded(to: self.view, animated: true)
        enableScrollNavItems()
    }
    fileprivate func enableScrollNavItems(){
        if tabBarController != nil {
            navController.followScrollView(tableView, delay: 60, scrollSpeedFactor: 1, followers: [tabBarController!.tabBar])
        }
    }
}

extension FeedViewController:UITableViewDelegate{
    
}

extension FeedViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(news.count)
        return filteredNews.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = filteredNews[indexPath.row]
        switch item.type {
        case .topItem:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.TopNewsCell.rawValue , for: indexPath) as? TopNewsTableViewCell{
                cell.item = item
                self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                return cell
            }
        case .withImageItem:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.NewsCell.rawValue , for: indexPath) as? NewsTableViewCell{
                cell.item = item
                return cell
            }
        case .noImageItem:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.NewsWithoutImageCell.rawValue, for: indexPath) as? NewsWithoutImageTableViewCell{
                cell.item = item
                return cell
            }
            
        }
        return UITableViewCell()
    }
}

extension FeedViewController: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.enableScrollNavItems()
        self.tableView.tableHeaderView = nil
    }
}
