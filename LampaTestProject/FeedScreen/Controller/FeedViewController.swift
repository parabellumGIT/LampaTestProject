//
//  FeedViewController.swift
//  LampaTestProject
//
//  Created by ParaBellum on 11/9/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit
import MBProgressHUD

class FeedViewController: UIViewController {
    private enum CellIds:String{
        case TopNewsCell
        case NewsCell
        case NewsWithoutImageCell
    }
    
    //MARK: Properties
    var news:[NewsFeedViewModelItem] = []
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        getNews()
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    
    fileprivate func getNews() {
        let webService = WebService.shared()
        webService.getNews { (items, error) in
            if let newsItems = items{
                let newsFeedVM = NewsFeedViewModel(news: newsItems)
                self.news = newsFeedVM.items
                DispatchQueue.main.async(execute: { () -> Void in
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.tableView.reloadData()
                })
                
            }else{
                print(error!)
            }
        }
    }
}

extension FeedViewController:UITableViewDelegate{
    
}

extension FeedViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(news.count)
        return news.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = news[indexPath.row]
        switch item.type {
        case .topItem:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.TopNewsCell.rawValue , for: indexPath) as? TopNewsTableViewCell{
                cell.item = item
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
