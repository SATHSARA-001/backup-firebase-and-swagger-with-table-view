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
                    
                case .emailAlreadyInUse:
                    print("")
                    
                case .invalidEmail:
                    print("")
                    
                case .weakPassword:
                    print("")
                    
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

