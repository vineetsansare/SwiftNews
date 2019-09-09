//
//  ArticleListCell.swift
//  SwiftNews
//
//  Created by Vineet Sansare on 9/7/19.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import UIKit

class ArticleListCell: UITableViewCell {
    @IBOutlet private (set) weak var headerImageView: UIImageView!
    @IBOutlet private (set) weak var articleTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        headerImageView.clipsToBounds = true
    }
    
    func updateUI(with articleList: ArticleListDisplayable) {        
        headerImageView.setImage(withURL: articleList.imageURL)
        articleTitleLabel.text = articleList.articleTitle        
    }
}
