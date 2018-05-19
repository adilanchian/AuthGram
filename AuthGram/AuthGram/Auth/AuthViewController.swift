//
//  AuthViewController.swift
//  AuthGram
//
//  Created by Alec Dilanchian on 5/19/18.
//  Copyright © 2018 Alec Dilanchian. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func close(_ sender: Any) {
        print("Closing view...")
        self.dismiss(animated: true) {
            print("View closed!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
