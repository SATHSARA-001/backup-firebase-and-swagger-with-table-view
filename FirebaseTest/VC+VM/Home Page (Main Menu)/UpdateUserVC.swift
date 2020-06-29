//
//  UpdateUserVC.swift
//  FirebaseTest
//
//  Created by Sathsara Maduranga on 6/29/20.
//  Copyright © 2020 Sathsara Maduranga. All rights reserved.
//

import UIKit
import FirebaseDatabase
import RxSwift
import RxCocoa

class UpdateUserVC: UIViewController {
    
    var id  : String?
    var fname : String?
    var lname : String?
    var Email : String?
    
    
    
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnUpdate: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.text = Email
        txtFName.text = fname
        txtLastName.text = lname
        
        addObservers()
        
    }
    
    var firstname = BehaviorRelay<String>(value: "")
    var lastname = BehaviorRelay<String>(value: "")
    var email = BehaviorRelay<String>(value: "")
    
    var ref = Database.database().reference()
    
    var bag = DisposeBag()
    
    
    
    
    func addObservers() {
        
        btnUpdate.rx.tap
            .subscribe() {[weak self] event in
                self?.updateUser(id: self?.id ?? "")
        }
        .disposed(by: bag)
        
        txtFName.rx.text
            .orEmpty
            .bind(to: firstname)
            .disposed(by: bag)
        
        txtLastName.rx.text
            .orEmpty
            .bind(to: lastname)
            .disposed(by: bag)
        
        txtEmail.rx.text
            .orEmpty
            .bind(to: email)
            .disposed(by: bag)
    }
    
    func updateUser(id: String) {
        
        let ref = Database.database().reference(withPath: "users")
        
        let newUserId = id
        let userInfoDictionary = ["id" :newUserId,
                                  "firstname" : self.firstname.value,
                                  "lastname" : self.lastname.value,
                                  "email" : self.email.value]
        
        ref.child(newUserId).updateChildValues(userInfoDictionary) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let currentUsers: [User] = HomeVC().userList.value
                HomeVC().userList.accept(currentUsers)
            }
        }
    }
    
    
    
}
