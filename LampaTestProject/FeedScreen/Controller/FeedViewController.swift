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

class FeedViewController: UIViewController{
    private enum CellIds:String{
        case TopNewsCell
        case NewsCell
        case NewsWithoutImageCell
    }
    
    //MARK: Properties
    private var menuShowing: Bool = false
    fileprivate weak var navController:ScrollingNavigationController!
    var searchController: UISearchController!
    var news:[NewsFeedViewModelItem] = []
    var filteredNews:[NewsFeedViewModelItem] = []
    let tryAgainButton: UIButton = {
        let button = UIButton()
        button.setTitle("Try again", for: .normal)
        button.addTarget(self, action: #selector(getNews), for: .touchUpInside)
        button.isHidden = true
        button.setTitleColor(UIColor.red, for: .normal)
        button.sizeToFit()
        return button
    }()
    let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "Apologies, something went wrong. Please check your internet connection and try again later..."
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    //MARK: IBActions
    @IBAction func searchButtonTapped(_ sender: UIBarButtonItem) {
        navController.stopFollowingScrollView(showingNavbar: true)
        navController.showNavbar()
     
        tableView.setContentOffset(CGPoint(x:0,y: -tableView.contentInset.top), animated: true)
        tableView.tableHeaderView = searchController.searchBar
        
        
        
    }
    @IBAction func menuOpen(_ sender: UIBarButtonItem) {
        if menuShowing{
            menuLeadingConstraint.constant = -180
            UIView.animate(withDuration: 0.4, animations: {
                self.view.layoutIfNeeded()
            })
        }else{
            menuLeadingConstraint.constant = 0
            UIView.animate(withDuration: 0.4, animations: {
                self.view.layoutIfNeeded()
            })
        }
        menuShowing = !menuShowing
    }
    
    
    //MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        getNews()
    }
    
    //MARK: - Funcs
    
    
    @objc fileprivate func getNews() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        hideErrorScreen()
        let webService = WebService.shared()
        webService.getNews { (items, error) in
            if let _ = error{
                DispatchQueue.main.async(execute: {self.errorMessageLabel.isHidden = false
                   self.showErrorScreen()
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
    private func hideErrorScreen() {
        self.tryAgainButton.isHidden = true
        self.errorMessageLabel.isHidden = true
    }
    private func showErrorScreen(){
        self.errorMessageLabel.frame = self.tableView.frame
        self.tryAgainButton.isHidden = false
        self.tryAgainButton.center = CGPoint(x: self.errorMessageLabel.center.x, y: self.errorMessageLabel.center.y + 40)
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    private func initialSetup() {
        setupSearchController()
        navController = self.navigationController as? ScrollingNavigationController
        tableView.addSubview(self.errorMessageLabel)
        tableView.addSubview(self.tryAgainButton)
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets(top: -6, left: 0, bottom: 0, right: 0)
       
        enableScrollNavItems()
    }
    
    fileprivate func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = .white
        searchController.searchBar.backgroundColor = .black
        searchController.searchBar.barTintColor = .black
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    fileprivate func enableScrollNavItems(){
        if tabBarController != nil {
            navController.followScrollView(tableView, delay: 60, scrollSpeedFactor: 1, followers: [tabBarController!.tabBar])
        }
    }
}

extension FeedViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
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
extension FeedViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            filteredNews = searchText.isEmpty ? news : news.filter({ (item:NewsFeedViewModelItem) -> Bool in
                return  item.titleName.range(of: searchText, options: .caseInsensitive) != nil
            })
            tableView.reloadData()
        }
    }
}
