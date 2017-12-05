//
//  loginPageViewController.swift
//  Scene
//
//  Created by Hector Aguilar on 11/18/17.
//  Copyright © 2017 Kristie Wong. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class loginPageViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailField.delegate = self
        self.passwordField.delegate = self
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signUp(_ sender: UIButton) {
        performSegue(withIdentifier: "toSignUp", sender: nil)
    }
    
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    @IBAction func loginB(_ sender: UIButton) {
        guard let emailText = emailField.text else { return }
        guard let passwordText = passwordField.text else { return }
        if emailText == "" || passwordText == ""{
            if emailText == "" && passwordText != ""{
                let alertController = UIAlertController(title: "Failure!", message: "The emial field must be filled!", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else if emailText != "" && passwordText == ""{
                let alertController = UIAlertController(title: "Failure!", message: "The password field must be filled!", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else{
                let alertController = UIAlertController(title: "Failure!", message: "All fields must be non-empty.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        else if !validateEmail(candidate: emailText){
            let alertController = UIAlertController(title: "Failure!", message: "The email doesn't look valid, try another one!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            print("6857463475867970968547890765890")
            Auth.auth().signIn(withEmail: emailText, password: passwordText){ (user, error) in
                if error == nil {
                    print("00000000000000000000000000000000")
                    self.performSegue(withIdentifier: "L2m", sender: nil)
                }else{ // if (error != nil),
                    let alertController = UIAlertController(title: "Log In Error", message:
                        error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    
    
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        if Auth.auth().currentUser != nil {
//            self.performSegue(withIdentifier: "L2m", sender: self)
//        }
//    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}
