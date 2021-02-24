//
//  HomeViewController.swift
//  pTweet
//
//  Created by Eddy Wister on 24/02/21.
//

import UIKit
import Simple_Networking
import SVProgressHUD
import NotificationBannerSwift

class HomeViewController: UIViewController {

    //mark outlets
    @IBOutlet weak var tableView: UITableView!
    
    private let cellId = "pTweetsTableViewCell"
    private var dataSource = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getPosts()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI(){
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    private func getPosts(){
        //indicar load
        SVProgressHUD.show()
        //get services
        SN.get(endpoint: Endpoints.getPosts) { (response: SNResultWithEntity<[Post],ErrorResponse>) in
            SVProgressHUD.dismiss()
            switch response{
            case .success(let posts):
                self.dataSource = posts
                self.tableView.reloadData()
                
            case .error(let error):
                NotificationBanner(subtitle: "Usuario Invalido", style: .warning).show()
                return
                
            case .errorResult(let entity):
                NotificationBanner(subtitle: "Error no controlado", style: .warning).show()
                return
        }
        }
    }
}
extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        if let cell = cell as? pTweetsTableViewCell {
            cell.setUpCellWith(post: dataSource[indexPath.row])
            
        }
        return cell
    }
}
