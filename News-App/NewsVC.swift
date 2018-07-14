//
//  ViewController.swift
//  News-App
//
//  Created by Johnny Perdomo on 7/13/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class NewsVC: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }

    
}

extension NewsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = newsTableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsCell else { return UITableViewCell() }
        
        
        cell.newsImage.layer.cornerRadius = 10
        
        cell.configureCell(newsImage: UIImage(named: "download")!, newsTitle: "Johnson & Johnson still battling thousands of cases involving its talcum powder", newsSource: "Washington Post")
        
        return cell
    }
    
}
