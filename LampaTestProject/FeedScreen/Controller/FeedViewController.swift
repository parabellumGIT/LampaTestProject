//
//  FeedViewController.swift
//  LampaTestProject
//
//  Created by ParaBellum on 11/9/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    enum CellIds:String{
        case TopNewsCell
        case NewsCell
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

 

}

extension FeedViewController:UITableViewDelegate{
    
}

extension FeedViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.TopNewsCell.rawValue, for: indexPath) as! TopNewsTableViewCell
            cell.imageURLs.append(URL(string: "https://www.google.com/search?biw=1264&bih=908&tbm=isch&q=funny+cats&sa=X&ved=0ahUKEwixsquPlbHXAhVOKuwKHS_EB3AQhyYIJQ#imgrc=kNxxpnFk0aZAuM")!)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.NewsCell.rawValue, for: indexPath) as! NewsTableViewCell
            return cell
        }
        
    }
    
}
