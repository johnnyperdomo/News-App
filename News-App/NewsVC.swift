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
import SDWebImage


class NewsVC: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    
    var titleArray = [String]()
    var newsSourceArray = [String]()
    var imageURLArray = [String]()
    var newsStoryUrlArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        
        self.newsTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getNewsData { (success) in
            if success {
                print("success")
                
                self.imageURLArray = self.imageURLArray.filter { $0 != ""} //filter array to remove nil values
                
                print(self.newsStoryUrlArray)
                self.newsTableView.reloadData()
                print(self.imageURLArray.count)
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
        
       return imageURLArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = newsTableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsCell else { return UITableViewCell() }
        
        var titles = String()
        var sources = String()
        
        if titleArray.count > 0 {
             titles = titleArray[indexPath.row ]
        } else {
             titles = ""
        }
        
        if newsSourceArray.count > 0 {
            sources = newsSourceArray[indexPath.row]
        } else {
            sources = ""
        }
    
        if imageURLArray.count > 0 {
            cell.newsImage.sd_setImage(with: URL(string: imageURLArray[indexPath.row]))
        } else {
            cell.newsImage.image = UIImage(named: "newsPlaceholder")!
        }
        
        
        cell.newsImage.layer.cornerRadius = 10
        
        cell.configureCell(newsTitle: titles, newsSource: sources)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!) as! NewsCell
        
        var urls = newsStoryUrlArray[(indexPath?.row)!]
    
        UIApplication.shared.open( URL(string: urls)!, options: [:] ) { (success) in
            if success {
                print("open link")
            }
        }
        
        
    }
    
}

extension NewsVC {
    
    func getNewsData(complete: @escaping (_ status: Bool) -> ()) {
        
        Alamofire.request("https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=96983db1075641f283b65aff6d422cff", method: .get).responseJSON { (response) in
            
            guard let value = response.result.value else { return }
            
                let json = JSON(value)
                
                for item in json["articles"].arrayValue {
                    
                
                    self.titleArray.append(item["title"].stringValue)
                    self.newsSourceArray.append(item["source"]["name"].stringValue)
                    self.imageURLArray.append(item["urlToImage"].stringValue)
                    self.newsStoryUrlArray.append(item["url"].stringValue)
                
                }
            complete(true)
        
        }
    
    }
    
    
}










