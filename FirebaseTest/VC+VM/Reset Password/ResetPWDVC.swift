//
//  ResetPWDVC.swift
//  FirebaseTest
//
//  Created by Sathsara Maduranga on 6/25/20.
//  Copyright © 2020 Sathsara Maduranga. All rights reserved.
//

import UIKit
import Firebase

class ResetPWDVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnReset: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    func getEmailAddress()->String
    {
        let email = txtEmail.text ?? ""
        return email
    }
    

    @IBAction func clickOnReset(_ sender: UIButton) {
        Auth.auth().sendPasswordReset(withEmail: getEmailAddress()) { (error) in
          if let error = error as? NSError {
            switch AuthErrorCode(rawValue: error.code) {
            case .userNotFound:
              // Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
                print("")
            case .invalidEmail:
              // Error: The email address is badly formatted.
                print("")
            case .invalidRecipientEmail:
              // Error: Indicates an invalid recipient email was sent in the request.
                print("")
            case .invalidSender:
              // Error: Indicates an invalid sender email is set in the console for this action.
                print("")
            case .invalidMessagePayload:
              // Error: Indicates an invalid email template for sending update email.
                print("")
            default:
              print("Error message: \(error.localizedDescription)")
            }
          } else {
            print("Reset password email has been successfully sent")
          }
        }
        
    }
    
}
