//
//  ExploreViewController.swift
//  Scene
//
//  Created by Kristie Wong on 11/20/17.
//  Copyright © 2017 Kristie Wong. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage


class exploreViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var table: UITableView!
    
    var postCollection : [Dictionary<String, String>] = []
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(self.postCollection.count)
        return self.postCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = postCollection[indexPath.row]["title"]
        
        let url = URL(string:postCollection[indexPath.row]["displayImage"]!)
        let data = try? Data(contentsOf: url!)
        let imageToPost: UIImage = UIImage(data: data!)!
        cell.imageView?.image = imageToPost
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPosts()
        
    }
    
    func getPosts() {
        let dbRef = Database.database().reference()
        dbRef.child("Posts").observeSingleEvent(of: .value, with: { snapshot -> Void in
            if snapshot.exists() {
                if let posts = snapshot.value as? [String:AnyObject] {
                    for postKey in posts.keys {
                        let dict: [String: String] = [
                            "title":  (posts[postKey]!["title"] as? String)!,
                            "displayImage" : (posts[postKey]!["displayImage"] as? String)!,
                            "image1" : (posts[postKey]!["image1"] as? String)!,
                            "image2" : (posts[postKey]!["image2"] as? String)!,
                            "image3" : (posts[postKey]!["image3"] as? String)!,
                            "comments" : (posts[postKey]!["comments"] as? String)!
                            
                        ]
                        self.postCollection.append(dict)
                        print("before")
                        
                    }
                    self.table.reloadData()
                }
            }
        })
        print(postCollection)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print( indexPath.row )
        postInfo["title"] = postCollection[indexPath.row]["title"] as? String
        postInfo["displayImage"] = postCollection[indexPath.row]["displayImage"] as? String
        postInfo["image1"] = (postCollection[indexPath.row]["image1"] as? String)!
        postInfo["image2"] = (postCollection[indexPath.row]["image2"] as? String)!
        postInfo["image3"] = (postCollection[indexPath.row]["image3"] as? String)!
        postInfo["comments"] = (postCollection[indexPath.row]["comments"] as? String)!
        performSegue(withIdentifier: "toInfo", sender: nil)
        //        print(indexPath)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

