//
//  HomeVC.swift
//  FirebaseTest
//
//  Created by Sathsara Maduranga on 6/25/20.
//  Copyright © 2020 Sathsara Maduranga. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Firebase
import FirebaseDatabase
import FirebaseAuth

class HomeVC: UIViewController , UIScrollViewDelegate {
    
    @IBOutlet weak var btnAdd: UIBarButtonItem!
    @IBOutlet weak var tblView: UITableView!
    
    var userList = BehaviorRelay<[User]>(value: [])
    
    var ref = Database.database().reference().child("users")
    
    var bag = DisposeBag();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.rx.setDelegate(self).disposed(by: bag)
        
        addDataBindObservers()
        fetchFirebaseData()
    }
    
    func addDataBindObservers() {
        userList.asObservable()
            .bind(to: tblView.rx.items(cellIdentifier: "cell", cellType: TableViewCell.self)) { row, model, cell in
                cell.configureCell(with: model)
        }
        .disposed(by: bag)
    }
    
    func fetchFirebaseData() {
        
        ref.observe(.value, with: { (snapshot) in
            guard let value = snapshot.value as? [String: Any] else {
                return
            }
            
            var _users = [User]()
            for (key, value) in value {
                guard let userdict = value as? [String: Any],
                    let firstname = userdict["firstname"] as? String,
                    let email = userdict["email"] as? String,
                    let lastname = userdict["lastname"] as? String else {
                        continue
                }
                _users.append(User(FirstName:firstname, LastName: lastname, Email: email))
            }
            
            self.userList.accept(_users)
            
            
        })
    }
    
    
    
    
    
    @IBAction func clickOnAdd(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "AddUserSB") as! AddUserVC
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    
    
}





