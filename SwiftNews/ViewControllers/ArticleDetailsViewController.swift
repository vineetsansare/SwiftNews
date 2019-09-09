//
//  ArticleDetailsViewController.swift
//  SwiftNews
//
//  Created by Vineet Sansare on 9/7/19.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import UIKit

class ArticleDetailsViewController: UIViewController {
    var articleData: ArticleData!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var articleDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: Private Methods
    
    private func setupUI() {
        title = articleData.articleTitle
        articleDescription.text = articleData.articleDesc
        
        if canOpenURL(articleData.thumbnailURLString) {
            imageView.setImage(withURL: articleData.imageURL)
        } else {
            imageView.frame.size.height = 0
            imageView.isHidden = true
            articleDescription.frame.origin.y = 10
        }
    }
    
    private func canOpenURL(_ string: String?) -> Bool {
        guard let urlString = string,
            let url = URL(string: urlString)
            else { return false }
        
        if !UIApplication.shared.canOpenURL(url) { return false }
        
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
    }
}
