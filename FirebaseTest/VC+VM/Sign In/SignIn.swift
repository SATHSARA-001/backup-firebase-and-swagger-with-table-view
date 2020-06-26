//
//  SignIn.swift
//  FirebaseTest
//
//  Created by Sathsara Maduranga on 6/25/20.
//  Copyright © 2020 Sathsara Maduranga. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SignIn: UIViewController {
    
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPwd: UITextField!
    
    
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func clickOnSignIn(_ sender: UIButton) {
        
        unuse()
    }
    
    func unuse()
    {
        let email = txtEmail.text ?? ""
        let password = txtPwd.text ?? ""
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .operationNotAllowed:
                    // Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.
                    print("")
                case .userDisabled:
                    // Error: The user account has been disabled by an administrator.
                    print("")
                case .wrongPassword:
                    // Error: The password is invalid or the user does not have a password.
                    print("Wrong Passsword")
                case .invalidEmail:
                    // Error: Indicates the email address is malformed.
                    print("Invalid Email")
                default:
                    print("Error: \(error.localizedDescription)")
                }
            } else {
                let sb = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(identifier: "HomeSB") as! HomeVC
                self.navigationController?.pushViewController(vc, animated: true)
                let userInfo = Auth.auth().currentUser
                _ = userInfo?.email
            }
        }
    }
    
    
    
}
