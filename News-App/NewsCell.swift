//
//  NewsCell.swift
//  News-App
//
//  Created by Johnny Perdomo on 7/13/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsSource: UILabel!
    
    func configureCell(newsImage: UIImage, newsTitle: String, newsSource: String) {
        self.newsImage.image = newsImage
        self.newsTitle.text = newsTitle
        self.newsSource.text = newsSource
    }
    
}
