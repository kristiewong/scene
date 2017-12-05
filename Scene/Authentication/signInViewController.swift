//
//  signInViewController.swift
//  Scene
//
//  Created by Hector Aguilar on 11/18/17.
//  Copyright © 2017 Kristie Wong. All rights reserved.
//

import UIKit
import FirebaseAuth


class signInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordVerificationField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameField.delegate = self
        self.emailField.delegate = self
        self.passwordField.delegate  = self
        self.passwordVerificationField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    @IBAction func sUP(_ sender: UIButton) {
        guard let name = nameField.text else { return }
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        guard let verifiedPassword = passwordVerificationField.text else { return }
        
        if email == "" || password == "" || name == "" || verifiedPassword == "" {
            let alertController = UIAlertController(title: "Failure", message: "A field was left blank, please fill in all fields!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        else if verifiedPassword != password {
            let alertController = UIAlertController(title: "Failure", message: "Your password did not match the password verification field", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        } else if !validateEmail(candidate: email) {
            let alertController = UIAlertController(title: "Failure", message: "Your email doesn't look valid, try another one!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    let changeRequest = user!.createProfileChangeRequest()
                    changeRequest.displayName = name
                    changeRequest.photoURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/scene-84594.appspot.com/o/v4_defpic.png?alt=media&token=d05723a6-82ca-479d-b01c-abcf3d89b747")
                    changeRequest.commitChanges() {(error) in
                    }
                    let alertController = UIAlertController(title: "Success", message: "Your Scene account was created.", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.performSegue(withIdentifier: "s2m", sender: nil)
                    
                } else {
                    let alertController = UIAlertController(title: "Something went wrong", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
