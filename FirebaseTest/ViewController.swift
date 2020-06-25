//
//  ViewController.swift
//  FirebaseTest
//
//  Created by Sathsara Maduranga on 6/25/20.
//  Copyright © 2020 Sathsara Maduranga. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    @IBOutlet weak var btnSignIn: UIButton!
    
    @IBOutlet weak var txtPWD: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func clickOnSignUp(_ sender: UIButton) {
        
        unuse()
        
    }
    
    func unuse()
    {
        let email = txtEmail.text ?? ""
        let password = txtPWD.text ?? ""
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as? NSError {
                switch AuthErrorCode(rawValue: error.code) {
                case .operationNotAllowed:
                    print("")
                // Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
                case .emailAlreadyInUse:
                    print("")
                // Error: print("")The email address is already in use by another account.
                case .invalidEmail:
                    print("")
                // Error: The email address is badly formatted.
                case .weakPassword:
                    print("")
                // Error: The password must be 6 characters long or more.
                default:
                    print("Error: \(error.localizedDescription)")
                }
            } else {
                print("User signs up successfully")
                let newUserInfo = Auth.auth().currentUser
                let email = newUserInfo?.email
            }
        }
    }
    
    
}

