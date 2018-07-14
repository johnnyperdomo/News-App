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
    
    var titleArray = [String]()
    var newsSourceArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        getNewsData { (success) in
            if success {
                print("success")
                self.newsTableView.reloadData()
            } else {
                print("doesnt work ")
            }
        }
        
    }

    
}

extension NewsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = newsTableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsCell else { return UITableViewCell() }
        
        var titles = String()
        var sources = String()
        
        if titleArray.count > 0 {
             titles = titleArray[indexPath.row]
        } else {
             titles = ""
        }
        
        if newsSourceArray.count > 0 {
            sources = newsSourceArray[indexPath.row]
        } else {
            sources = ""
        }
        
        cell.newsImage.layer.cornerRadius = 10
        
        cell.configureCell(newsImage: UIImage(named: "download")!, newsTitle: titles, newsSource: sources)
        
        return cell
    }
    
}

extension NewsVC {
    
    func getNewsData(complete: @escaping (_ status: Bool) -> ()) {
        
        Alamofire.request("https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=96983db1075641f283b65aff6d422cff", method: .get).responseJSON { (response) in
            
            if let value = response.result.value {
                let json = JSON(value)
                
                for item in json["articles"].arrayValue {
                    
                    self.titleArray.append(item["title"].stringValue)
                    self.newsSourceArray.append(item["source"]["name"].stringValue)
                }
            }
            complete(true)
        }
        
    }
    
}










