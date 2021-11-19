//
//  ViewController.swift
//  vadmitrievaPW5
//
//  Created by Varvara on 09.11.2021.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController, ArticleCellDelegate {
    func loadWebPage(model: ArticleModel) {
        let webViewController = WebViewController()
        webViewController.setURL(url: model.articleUrl ?? URL(string: "https://www.apple.com")!)
        present(webViewController, animated: true, completion: nil)
    }
    
    var manager: ArticleManager?
    var table: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemMint
        setupTableView()
        self.table?.register(ArticleCell.self, forCellReuseIdentifier: "articleCell")
        self.table?.delegate = self
        self.table?.dataSource = self
        manager = ArticleManager()
        manager?.fetchNews { artcl in
            self.manager?.articles = artcl
            DispatchQueue.main.async {
                self.table?.reloadData()
            }
        }
    }
    
    private func setupTableView() {
        let table = UITableView(frame: .zero)
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.table = table
    }
    
    let scroll = UIScrollView()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scroll.contentSize = CGSize(width: self.scroll.frame.width,
                                    height: (table?.frame.height)!)
        scroll.alwaysBounceVertical = true
    }
}

extension ArticleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection
                   section: Int) -> Int {
        return manager?.articles?.count ?? 8
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight:CGFloat = CGFloat()
        cellHeight = 400
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? ArticleCell
        cell?.didClicked()
    }
    
    private func handleShare(cell: ArticleCell) {
        let title = cell.model.title
        let url = cell.model.articleUrl
        if (url == nil || title == nil) {
            print("Incorrect!")
            return
        }
        let objectsToShare = [url as AnyObject, title as AnyObject]
        let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.assignToContact, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.saveToCameraRoll]
        present(activityViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let shareAction = UIContextualAction(style: .normal, title: "Share") {
            [weak self] (action, view, completionHandler) in
            self?.handleShare(cell: tableView.cellForRow(at: indexPath) as? ArticleCell ?? ArticleCell())
            completionHandler(true)
        }
        shareAction.backgroundColor = .systemIndigo
        let configuration = UISwipeActionsConfiguration(actions: [shareAction])
        return configuration
    }
}

extension ArticleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "articleCell",
            for: indexPath
        ) as? ArticleCell
        cell?.cellDelegate = self
        cell?.setupSize()
        cell?.setupArticleCell(model: manager?.articles?[indexPath.row] ?? ArticleModel())
        cell?.backgroundColor = .white
        return cell ?? UITableViewCell()
    }
}
