//
//  UIImageView+SwiftNews.swift
//  SwiftNews
//
//  Created by Vineet Sansare on 9/7/19.
//  Copyright © 2019 Loblaw. All rights reserved.
//

import SDWebImage
import UIKit

extension UIImageView {
    func reset(hidden: Bool = true) {
        image = nil
        isHidden = hidden
    }
    
    func setImage(withURLString urlString: String?, placeholderImage placeholder: UIImage? = nil) {
        setImage(withURL: URL(string: urlString ?? ""), placeholderImage: placeholder)
    }
    
    func setImage(withURL url: URL?, placeholderImage placeholder: UIImage? = nil) {
        sd_setImage(with: url, placeholderImage: placeholder)
    }
}
