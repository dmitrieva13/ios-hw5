//
//  ViewController.swift
//  vadmitrievaPW5
//
//  Created by Varvara on 09.11.2021.
//

import UIKit

class ArticleViewController: UIViewController {
    
    var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView = UITableView()
        tableView?.delegate = self
        tableView?.dataSource = self
    }
}

extension ArticleViewController: UITableViewDelegate {
}

extension ArticleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
