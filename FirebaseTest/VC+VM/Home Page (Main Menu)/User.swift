//
//  User.swift
//  FirebaseTest
//
//  Created by Sathsara Maduranga on 6/26/20.
//  Copyright © 2020 Sathsara Maduranga. All rights reserved.
//
class User {
    let FirstName: String?
    let LastName: String?
    let Email: String?
    let id : String?
    
    init(id : String,FirstName: String, LastName: String, Email: String ) {
        self.FirstName = FirstName
        self.LastName = LastName
        self.Email = Email
        self.id = id
        
    }
    
    
    
    
}
