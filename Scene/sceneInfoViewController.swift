//
//  sceneInfoViewController.swift
//  Scene
//
//  Created by Kristie Wong on 11/28/17.
//  Copyright © 2017 Kristie Wong. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class sceneInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var comments :  [Dictionary<String, String>] = []
    
    @IBOutlet weak var commentTable: UITableView!
    
    @IBOutlet weak var commentText: UITextField!
    
    @IBAction func postCommentButton(_ sender: UIButton) {
        let newComment = commentText.text
        let dbRef = Database.database().reference()
        
        let user = Auth.auth().currentUser
        let usersName = (user?.displayName)!.split(separator: " ")
        let commenter = usersName[0] + ": "
        
        let dict: [String:String] = [
            "comment" : newComment!,
            "commenter" : String(commenter)
        ]
        comments.append(dict)
        dbRef.child(postInfo["comments"]!).childByAutoId().setValue(dict)
        
        commentText.text = ""
        commentTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currComment = comments[indexPath.row]
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = currComment["commenter"]! + currComment["comment"]!
        return cell
    }
    
    
    @IBOutlet weak var locationTitle: UILabel!
    
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var image3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTitle.text = postInfo["title"]
        
        var url = URL(string:postInfo["image1"]!)
        var data = try? Data(contentsOf: url!)
        let imageToPost: UIImage = UIImage(data: data!)!
        image1.image = imageToPost
        
        url = URL(string:postInfo["image2"]!)
        data = try? Data(contentsOf: url!)
        let toPost: UIImage = UIImage(data: data!)!
        image2.image = toPost
        
        url = URL(string:postInfo["image3"]!)
        data = try? Data(contentsOf: url!)
        let tp: UIImage = UIImage(data: data!)!
        image3.image = tp
        
        let dbRef = Database.database().reference()
        dbRef.child(postInfo["comments"]!).observeSingleEvent(of: .value, with: { snapshot -> Void in
            if snapshot.exists() {
                if let posts = snapshot.value as? [String:AnyObject] {
                    for postKey in posts.keys {
                        let dict: [String: String] = [
                            "comment":  (posts[postKey]!["comment"] as? String)!,
                            "commenter" : (posts[postKey]!["commenter"] as? String)!,
                            ]
                        self.comments.append(dict)
                        
                    }
                    self.commentTable.reloadData()
                }
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
