//
//  AddUserVC.swift
//  FirebaseTest
//
//  Created by Sathsara Maduranga on 6/25/20.
//  Copyright © 2020 Sathsara Maduranga. All rights reserved.
//

import UIKit
import FirebaseDatabase
import RxSwift
import RxCocoa

class AddUserVC: UIViewController {
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtLName: UITextField!
    @IBOutlet weak var txtPNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    
    var firstname = BehaviorRelay<String>(value: "")
    var lastname = BehaviorRelay<String>(value: "")
    var email = BehaviorRelay<String>(value: "")
    
    var ref = Database.database().reference()
    
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
    }
    
    
    
    func addObservers() {
        
        btnAdd.rx.tap
            .subscribe() {[weak self] event in
                self?.addNewUserToList()
        }
        .disposed(by: bag)
        
        txtFName.rx.text
            .orEmpty
            .bind(to: firstname)
            .disposed(by: bag)
        
        txtLName.rx.text
            .orEmpty
            .bind(to: lastname)
            .disposed(by: bag)
        
        txtEmail.rx.text
            .orEmpty
            .bind(to: email)
            .disposed(by: bag)
    }
    
    func addNewUserToList() {
        
        let _user = User(FirstName: self.firstname.value, LastName: self.lastname.value, Email: self.email.value)
        let ref = Database.database().reference(withPath: "users").childByAutoId()
        let newUserId = ref.key ?? NSUUID().uuidString
        let userInfoDictionary = ["id" :newUserId,
                                  "firstname" : self.firstname.value,
                                  "lastname" : self.lastname.value,
                                  "email" : self.email.value]
        
        
        ref.setValue(userInfoDictionary) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                var currentUsers: [User] = HomeVC().userList.value
                currentUsers.append(_user)
                HomeVC().userList.accept(currentUsers)
            }
        }
    }
    
}
