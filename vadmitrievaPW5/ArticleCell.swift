//
//  ArticleCell.swift
//  vadmitrievaPW5
//
//  Created by Varvara on 11.11.2021.
//

import UIKit

final class ArticleCell: UITableViewCell {
    var model: ArticleModel!
    var imgView: UIImageView?
    var titleLabel: UILabel?
    var descriptionLabel: UILabel?
    var articleView: UIView!
    var cellDelegate: ArticleCellDelegate?
    
    override func prepareForReuse() {
        imgView = nil
        titleLabel = nil
        descriptionLabel = nil
        articleView = nil
    }
    
    public func setupArticleCell(model: ArticleModel) {
        self.model = model
        prepareForReuse()
        for subview in contentView.subviews {
            subview.removeFromSuperview()
            
        }
        setupImage(model: model)
        setupTitleLabel(title: model.title ?? "")
        setupDescriptionLabel(description: model.announce ?? "")
        contentView.addSubview(articleView)
    }
    
    private func setupImage(model: ArticleModel) {
        articleView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
        var articleImage = UIImage()
        DispatchQueue.global().async {
            articleImage = self.loadImage(img: model.img ?? ImageContainer(url: URL(fileURLWithPath: ""))) ?? UIImage()
            DispatchQueue.main.async {
                self.imgView?.image = articleImage
            }
        }
        self.imgView = UIImageView(image: articleImage)
        self.articleView.addSubview(self.imgView ?? UIImageView())
        self.imgView?.layer.cornerRadius = 15
        self.imgView?.translatesAutoresizingMaskIntoConstraints = false
        self.imgView?.topAnchor.constraint(equalTo: self.articleView.topAnchor,
                                           constant: 0).isActive = true
        self.imgView?.leadingAnchor.constraint(equalTo: self.articleView.leadingAnchor, constant: 0).isActive = true
        self.imgView?.trailingAnchor.constraint(equalTo: self.articleView.trailingAnchor, constant: 0).isActive = true
        self.imgView?.bottomAnchor.constraint(equalTo: self.articleView.bottomAnchor, constant: -80).isActive = true
    }
    
    private func setupTitleLabel(title: String) {
        titleLabel = UILabel()
        articleView.addSubview(titleLabel ?? UILabel())
        titleLabel?.text = title
        titleLabel?.font=UIFont.boldSystemFont(ofSize: 18.0)
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.topAnchor.constraint(equalTo: articleView.bottomAnchor, constant: -65).isActive = true
        titleLabel?.bottomAnchor.constraint(equalTo: articleView.bottomAnchor, constant: -40).isActive = true
        titleLabel?.leadingAnchor.constraint(equalTo: articleView.leadingAnchor, constant: 0).isActive = true
        titleLabel?.trailingAnchor.constraint(equalTo: articleView.trailingAnchor, constant: 0).isActive = true
    }
    
    private func setupDescriptionLabel(description: String) {
        descriptionLabel = UILabel()
        articleView.addSubview(descriptionLabel ?? UILabel())
        descriptionLabel?.text = description
        descriptionLabel?.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel?.topAnchor.constraint(equalTo: titleLabel?.bottomAnchor ?? self.topAnchor, constant: 10).isActive = true
        descriptionLabel?.bottomAnchor.constraint(equalTo: articleView.bottomAnchor, constant: -10).isActive = true
        descriptionLabel?.leadingAnchor.constraint(equalTo: articleView.leadingAnchor, constant: 0).isActive = true
        descriptionLabel?.trailingAnchor.constraint(equalTo: articleView.trailingAnchor, constant: 0).isActive = true
    }
    
    private func loadImage(img: ImageContainer) -> UIImage? {
        guard let data = try? Data(contentsOf: img.url) else {
            return nil
        }
        return UIImage(data: data)
    }
    
    func setupSize() {
        self.frame.size.height = 400
        self.frame.size.width = 300
    }
    
    public func didClicked() {
        cellDelegate?.loadWebPage(model: self.model)
    }
}
