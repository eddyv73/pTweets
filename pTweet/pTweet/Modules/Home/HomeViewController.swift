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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getPosts()
    }
    
    private func setupUI(){
        tableView.delegate = self
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
    private func deletePostAt(indexPath: IndexPath){
        SVProgressHUD.show()
        //obtener id
        let postiId = dataSource[indexPath.row].id
        
        //query string para borrar
        let endpoint = Endpoints.delete + postiId
        
        SN.delete(endpoint: endpoint) { (response : SNResultWithEntity<GeneralResponse , ErrorResponse>) in
            SVProgressHUD.dismiss()
            switch response{
            case .success:
                self.dataSource.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .left)
                
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
extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //mark aqui se borra
        let deleteAction = UITableViewRowAction(style: UITableViewRowAction.Style.destructive, title: "borrar") { (_, _) in
            self.deletePostAt(indexPath: indexPath)
        }
        return [deleteAction]
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
extension HomeViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMap", let mapViewController = segue.destination as? MapViewController{
            mapViewController.posts = dataSource.filter({$0.hasLocation})
        }
    }
}
