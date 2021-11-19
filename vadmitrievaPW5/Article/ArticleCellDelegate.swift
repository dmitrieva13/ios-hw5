//
//  ArticleCellDelegate.swift
//  vadmitrievaPW5
//
//  Created by Varvara on 18.11.2021.
//

import UIKit

protocol ArticleCellDelegate: AnyObject {
    func loadWebPage (model: ArticleModel)
}
