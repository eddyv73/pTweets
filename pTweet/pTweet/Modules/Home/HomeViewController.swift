//
//  HomeViewController.swift
//  pTweet
//
//  Created by Eddy Wister on 24/02/21.
//

import UIKit

class HomeViewController: UIViewController {

    //mark outlets
    @IBOutlet weak var tableView: UITableView!
    
    private let cellId = "pTweetsTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI(){
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    

}
extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        if let cell = cell as? pTweetsTableViewCell {
            //config celda
        }
        return cell
    }
}
