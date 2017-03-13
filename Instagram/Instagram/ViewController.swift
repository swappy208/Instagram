//
//  ViewController.swift
//  Instagram
//
//  Created by Swapnil Tamrakar on 3/13/17.
//  Copyright © 2017 Swapnil Tamrakar. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var usernameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onSignIn(_ sender: UIButton) {
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user, error) in
            if user != nil
            {
                print("Successfully logged in!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }

    @IBAction func onSignUp(_ sender: UIButton) {
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        newUser.signUpInBackground { (success, error) in
            if success {
                print ("yay, created a user!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else
            {
                print(error?.localizedDescription)
            }
        }
    }

}

