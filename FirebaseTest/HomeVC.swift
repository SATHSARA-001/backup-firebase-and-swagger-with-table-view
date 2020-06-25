//
//  HomeVC.swift
//  FirebaseTest
//
//  Created by Sathsara Maduranga on 6/25/20.
//  Copyright © 2020 Sathsara Maduranga. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var btnAdd: UIBarButtonItem!
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func clickOnAdd(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "AddUserSB") as! AddUserVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

 

}
