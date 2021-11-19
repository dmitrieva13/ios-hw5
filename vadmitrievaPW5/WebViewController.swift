//
//  WebViewController.swift
//  vadmitrievaPW5
//
//  Created by Varvara on 18.11.2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var url: URL!
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.load(URLRequest(url: url))
        setupCloseButton()
    }
    
    public func setURL(url: URL) {
        self.url = url
    }
    
    private func setupCloseButton() {
        let button = UIButton(type: .close)
        view.addSubview(button)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -10 ).isActive = true
        button.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 10
        ).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalTo:
                                        button.heightAnchor).isActive = true
        button.addTarget(self, action: #selector(closeScreen),
                         for: .touchUpInside)
    }
    
    @objc
    private func closeScreen() {
        dismiss(animated: true, completion: nil)
    }
}
