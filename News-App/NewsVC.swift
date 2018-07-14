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
import AlamofireImage


class NewsVC: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    
    var titleArray = [String]()
    var newsSourceArray = [String]()
    var imageURLArray = [String]()
    var imageArray = [UIImage]()
    
    
    
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
        var images: UIImage?
        
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
        
        if imageArray.count > 0 {
            images = imageArray[indexPath.row]
        } else {
            images = UIImage(named: "newsPlaceholder")!
        }
        
        
        
        cell.newsImage.layer.cornerRadius = 10
        
        cell.configureCell(newsImage: images!, newsTitle: titles, newsSource: sources)
        
        return cell
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
                    
                    Alamofire.request(item["urlToImage"].stringValue).responseImage { (response) in

                        guard let image = response.result.value else { return }

                        
                        //print(self.imageURLArray)
                        self.imageArray.append(image)
                       // print(self.imageArray.count)
                    }
                }
            self.newsTableView.reloadData()
            complete(true)
        
        }
    
    }
    
    
}










