//
//  profileViewController.swift
//  Scene
//
//  Created by Hector Aguilar on 11/20/17.
//  Copyright © 2017 Kristie Wong. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
//import UIImagePickerControllerPHAsset



class profileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = Auth.auth().currentUser
        var usersName = (user?.displayName)!.split(separator: " ")
        name.text = "Hi, " + usersName[0] + "!"
        
        print((user?.photoURL)!)
        let data = try? Data(contentsOf: (user?.photoURL)!)
        
        print(data)
        profilePicture.image = UIImage(data: data!)
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addProfilePicture(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Photo Source" , message: "Choose the source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler : { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler : nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenPic = info[UIImagePickerControllerOriginalImage] as! UIImage
        profilePicture.image = chosenPic
        
        let user = Auth.auth().currentUser
        let changeRequest = user!.createProfileChangeRequest()
        
        print("11111111111111")
        
        let storageRef = Storage.storage().reference().child((user?.displayName)! + ".png")
        print("22222222222222222")
        if let uploadData = UIImagePNGRepresentation(chosenPic){
            print("333333333333333")
            storageRef.putData(uploadData, metadata: nil, completion:
                {(metadata, error) in
                    print("anyting----1--1-1-1-1--1")
                    if error == nil{
                        //                        let url = metadata?.downloadURL()
                        //                        print(url!)
                        changeRequest.photoURL = metadata?.downloadURL()!
                        changeRequest.commitChanges() {(error) in
                            print(error)
                        }
                        
                    }else{
                        print(error)
                        print("there was a fucking error")
                        return
                    }
            })
            
        }
        picker.dismiss(animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

