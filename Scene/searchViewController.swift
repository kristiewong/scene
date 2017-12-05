//
//  searchViewController.swift
//  
//
//  Created by Kristie Wong on 12/4/17.
//

import UIKit

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage

var postInfo = [String: String]()

class searchViewController: UIViewController {
    
    @IBOutlet weak var locationText: UITextField!
    
    @IBAction func searchButton(_ sender: UIButton) {
        let validLocations = ["Sather Tower", "Berkeley Marina", "The Big C"]
        let searchedLocation = locationText.text!
        if validLocations.contains(searchedLocation){
            let dbRef = Database.database().reference()
            dbRef.child("Posts").observeSingleEvent(of: .value, with: { snapshot -> Void in
                if snapshot.exists() {
                    if let posts = snapshot.value as? [String:AnyObject] {
                        for postKey in posts.keys {
                            
                            if (posts[postKey]!["title"] as! String == searchedLocation){
                                postInfo["title"] = posts[postKey]!["title"] as? String
                                postInfo["displayImage"] = posts[postKey]!["displayImage"] as? String
                                postInfo["image1"] = posts[postKey]!["image1"] as? String
                                postInfo["image2"] = posts[postKey]!["image2"] as? String
                                postInfo["image3"] = posts[postKey]!["image3"] as? String
                                postInfo["comments"] = posts[postKey]!["comments"] as? String
                                self.performSegue(withIdentifier: "toSceneInfo", sender: nil)
                            }
                        }
                    }
                }
            })
            
        }else{
            let alertController = UIAlertController(title: "Sorry", message: "We weren't able to find your requested location", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

